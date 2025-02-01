import 'package:http/http.dart' as http;

Future<http.Response> ask(String message) {
  final Uri url = Uri.parse('http://10.0.2.2:5000/ask');
  final Map<String, String> formData = {
    'query': message,
  };

  return http.post(
    url,
    headers: {'Content-Type': 'application/x-www-form-urlencoded'},
    body: formData,
  );
}
