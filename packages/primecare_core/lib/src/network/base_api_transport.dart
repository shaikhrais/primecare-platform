import 'package:primecare_models/primecare_models.dart' show ApiResponse;

/// Platform-independent transport boundary; concrete adapters own authentication.
abstract class BaseApiTransport {
  Future<ApiResponse> get(String path, {Map<String, dynamic>? queryParameters});
  Future<ApiResponse> post(String path, {dynamic body});
  Future<ApiResponse> put(String path, {dynamic body});
  Future<ApiResponse> patch(String path, {dynamic body});
  Future<ApiResponse> delete(String path);
}
