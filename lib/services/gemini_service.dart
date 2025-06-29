import 'dart:convert';
import 'dart:developer';
import 'package:digifarmer/constants/constants.dart';
import 'package:digifarmer/models/gemini_analysis_model.dart';
import 'package:http/http.dart' as http;

class GeminiService {
  static Future<GeminiAnalysisModel?> analyzeDisease({
    required String diseaseName,
    required List<String> classLabels,
    required List<double> probabilityScores,
    required String detectedClass,
  }) async {
    try {
      // Check if API key is configured

      // Create the prompt for Gemini
      String prompt = _createPrompt(
        diseaseName: diseaseName,
        classLabels: classLabels,
        probabilityScores: probabilityScores,
        detectedClass: detectedClass,
      );

      final response = await http.post(
        Uri.parse('$geminiAPIBaseURL$geminiAPIEndPoint?key=$geminiAPIKey'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'contents': [
            {
              'parts': [
                {'text': prompt},
              ],
            },
          ],
          'generationConfig': {
            'temperature': 0.7,
            'topK': 40,
            'topP': 0.95,
            'maxOutputTokens': 2048,
          },
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['candidates'] != null && data['candidates'].isNotEmpty) {
          final text = data['candidates'][0]['content']['parts'][0]['text'];
          return GeminiAnalysisModel.fromText(text);
        } else {
          log('No candidates found in Gemini response');
          return null;
        }
      } else {
        log('Gemini API Error: ${response.statusCode} - ${response.body}');
        return null;
      }
    } catch (e) {
      log('Error calling Gemini API: $e');
      return null;
    }
  }

  static String _createPrompt({
    required String diseaseName,
    required List<String> classLabels,
    required List<double> probabilityScores,
    required String detectedClass,
  }) {
    // Create probability distribution text
    String probabilityText = '';
    for (
      int i = 0;
      i < classLabels.length && i < probabilityScores.length;
      i++
    ) {
      probabilityText +=
          '${classLabels[i]}: ${(probabilityScores[i] * 100).toStringAsFixed(2)}%\n';
    }

    return '''
You are an expert agricultural pathologist. I have detected a maize/corn leaf disease using machine learning. Here are the detection results:

**Detected Disease:** $diseaseName
**Disease Class:** $detectedClass

**ML Model Probability Scores:**
$probabilityText

Based on this disease detection, please provide a comprehensive analysis in the following structured format:

**Disease Summary:** 
Provide a brief, clear description of the identified condition, its severity, and impact on maize crops.

**Causes:** 
List the primary factors contributing to this disease (environmental conditions, pathogens, soil conditions, etc.).

**Household Remedies:** 
Suggest safe, accessible treatments using common household materials or easily available organic solutions that farmers can implement immediately.

**Agricultural Solutions:** 
Recommend farming practices, crop management techniques, and preventive measures that can help control and prevent this disease.

**Medicinal Treatment:** 
Suggest professional fungicides, bactericides, or other chemical treatments if needed, including application methods and safety precautions.

Please provide practical, actionable advice that would be helpful for farmers, especially those with limited resources. Focus on sustainable and cost-effective solutions.
''';
  }
}
