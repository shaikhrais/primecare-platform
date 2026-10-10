import 'package:primecare_models/primecare_models.dart' show ApiResponse;
import 'base_api_transport.dart';

/// Owns injected transport. Authorization and response contracts remain server/domain concerns.
abstract class BaseTransportRepository<TClient extends BaseApiTransport> {
  final TClient client;
  BaseTransportRepository(this.client);
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

