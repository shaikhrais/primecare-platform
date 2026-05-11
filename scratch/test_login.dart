import 'package:http/http.dart' as http;
import 'dart:convert';

void main() async {
  final url = Uri.parse('http://localhost:8700/v1/auth/login');
  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'email': 'ceo@primecare.com',
      'password': 'admin123',
    }),
  );

  print('Status: ${response.statusCode}');
  print('Body: ${response.body}');
}
