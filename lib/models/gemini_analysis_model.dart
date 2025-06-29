class GeminiAnalysisModel {
  final String diseaseSummary;
  final String causes;
  final String householdRemedies;
  final String agriculturalSolutions;
  final String medicinalTreatment;

  GeminiAnalysisModel({
    required this.diseaseSummary,
    required this.causes,
    required this.householdRemedies,
    required this.agriculturalSolutions,
    required this.medicinalTreatment,
  });

  factory GeminiAnalysisModel.fromText(String text) {
    // Parse the structured response from Gemini
    String diseaseSummary = _extractSection(text, 'Disease Summary:');
    String causes = _extractSection(text, 'Causes:');
    String householdRemedies = _extractSection(text, 'Household Remedies:');
    String agriculturalSolutions = _extractSection(text, 'Agricultural Solutions:');
    String medicinalTreatment = _extractSection(text, 'Medicinal Treatment:');

    return GeminiAnalysisModel(
      diseaseSummary: diseaseSummary,
      causes: causes,
      householdRemedies: householdRemedies,
      agriculturalSolutions: agriculturalSolutions,
      medicinalTreatment: medicinalTreatment,
    );
  }

  static String _extractSection(String text, String sectionTitle) {
    final startIndex = text.indexOf(sectionTitle);
    if (startIndex == -1) return 'Information not available';
    
    final contentStart = startIndex + sectionTitle.length;
    final nextSectionIndex = _findNextSectionIndex(text, contentStart);
    
    if (nextSectionIndex == -1) {
      return text.substring(contentStart).trim();
    } else {
      return text.substring(contentStart, nextSectionIndex).trim();
    }
  }

  static int _findNextSectionIndex(String text, int startFrom) {
    final sections = ['Disease Summary:', 'Causes:', 'Household Remedies:', 'Agricultural Solutions:', 'Medicinal Treatment:'];
    int nearestIndex = -1;
    
    for (String section in sections) {
      final index = text.indexOf(section, startFrom);
      if (index != -1 && (nearestIndex == -1 || index < nearestIndex)) {
        nearestIndex = index;
      }
    }
    
    return nearestIndex;
  }

  factory GeminiAnalysisModel.fromJson(Map<String, dynamic> json) {
    return GeminiAnalysisModel(
      diseaseSummary: json['diseaseSummary'] ?? 'Information not available',
      causes: json['causes'] ?? 'Information not available',
      householdRemedies: json['householdRemedies'] ?? 'Information not available',
      agriculturalSolutions: json['agriculturalSolutions'] ?? 'Information not available',
      medicinalTreatment: json['medicinalTreatment'] ?? 'Information not available',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'diseaseSummary': diseaseSummary,
      'causes': causes,
      'householdRemedies': householdRemedies,
      'agriculturalSolutions': agriculturalSolutions,
      'medicinalTreatment': medicinalTreatment,
    };
  }
}
