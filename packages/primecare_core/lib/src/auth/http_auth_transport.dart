import 'dart:convert';
import 'package:http/http.dart' as http;
import 'base_auth_workflow.dart';

class HttpAuthTransport implements AuthTransport {
  final Uri baseUrl;
  final http.Client client;
  HttpAuthTransport(String url, this.client) : baseUrl = _parseBaseUrl(url);

  static Uri _parseBaseUrl(String url) {
    final uri = Uri.tryParse(url);
    if (uri == null ||
        !uri.hasAuthority ||
        uri.host.isEmpty ||
        uri.scheme != 'https' ||
        uri.hasQuery ||
        uri.hasFragment ||
        uri.userInfo.isNotEmpty) {
      throw const AuthFailure(
        'Configure AUTH_API_URL as an HTTPS auth service URL.',
      );
    }
    return uri;
  }

  @override
  Future<Map<String, dynamic>> send(
    String method,
    String path, {
    Map<String, dynamic>? body,
    String? token,
  }) async {
    final prefix = baseUrl.path.replaceFirst(RegExp(r'/$'), '');
    final request = http.Request(method, baseUrl.replace(path: '$prefix$path'));
    request.followRedirects = false;
    request.headers['content-type'] = 'application/json';
    if (token != null) request.headers['authorization'] = 'Bearer $token';
    if (body != null) request.body = jsonEncode(body);
    try {
      final response = await http.Response.fromStream(
        await client.send(request).timeout(const Duration(seconds: 20)),
      ).timeout(const Duration(seconds: 20));
      final decoded = jsonDecode(response.body);
      if (decoded is! Map<String, dynamic>) throw const FormatException();
      if (response.statusCode < 200 || response.statusCode >= 300) {
        throw AuthFailure(
          decoded['error'] is String
              ? decoded['error'] as String
              : 'Authentication request failed',
          status: response.statusCode,
        );
      }
      return decoded;
    } on AuthFailure {
      rethrow;
    } catch (_) {
      throw const AuthFailure(
        'Authentication service unavailable. Please try again.',
      );
    }
  }
}
