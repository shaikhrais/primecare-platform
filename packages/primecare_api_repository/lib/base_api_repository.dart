/// Owns injected transport. Authorization and response contracts remain server/domain concerns.
abstract class BaseApiRepositoryBase<C, R> {
  final C client;
  final Future<R> Function(String, {Map<String, dynamic>? queryParameters}) _get;
  final Future<R> Function(String, {dynamic body}) _post, _put, _patch;
  final Future<R> Function(String) _delete;

  BaseApiRepositoryBase(this.client, {
    required Future<R> Function(String, {Map<String, dynamic>? queryParameters}) get,
    required Future<R> Function(String, {dynamic body}) post,
    required Future<R> Function(String, {dynamic body}) put,
    required Future<R> Function(String, {dynamic body}) patch,
    required Future<R> Function(String) delete,
  }) : _get = get, _post = post, _put = put, _patch = patch, _delete = delete;

  Future<R> get(String path, {Map<String, dynamic>? queryParameters}) =>
      _get(path, queryParameters: queryParameters);
  Future<R> post(String path, {dynamic body}) => _post(path, body: body);
  Future<R> put(String path, {dynamic body}) => _put(path, body: body);
  Future<R> patch(String path, {dynamic body}) => _patch(path, body: body);
  Future<R> delete(String path) => _delete(path);
}
