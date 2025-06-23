import 'package:digifarmer/models/alert_model.dart';
import 'package:http/http.dart' as http;

class AlertService {
  Future<List<Alert>> fetchAlert() async {
    try {
      final response = await http.get(
        Uri.parse('https://bipadportal.gov.np/api/v1/alert/?format=json'),
      );
      return alertFromJson(response.body).results ?? [];
    } catch (e) {
      if (e is http.ClientException) {
        throw Exception('No Internet Connection');
      } else {
        throw Exception('Failed to load news data');
      }
    }
  }
}
