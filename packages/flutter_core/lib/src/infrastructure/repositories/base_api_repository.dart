import '../../network/api_client.dart';

/// Owns injected transport. Authorization and response contracts remain server/domain concerns.
abstract class BaseApiRepository {
  final ApiClient client;
  BaseApiRepository(this.client);
  Future<ApiResponse> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) => client.get(path, queryParameters: queryParameters);
  Future<ApiResponse> post(String path, {dynamic body}) =>
      client.post(path, body: body);
  Future<ApiResponse> put(String path, {dynamic body}) =>
      client.put(path, body: body);
  Future<ApiResponse> patch(String path, {dynamic body}) =>
      client.patch(path, body: body);
  Future<ApiResponse> delete(String path) => client.delete(path);
}

/// Default transport repository used by application services.
class ApiRepository extends BaseApiRepository {
  ApiRepository(super.client);
}
