import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'communication_core.dart';

/// Supplied by the registered contract loader, never by a screen or message.
/// This declaration does not register an endpoint or grant a permission.
final class CommunicationRouteBinding {
  CommunicationRouteBinding({required this.path, required this.method}) {
    final uri = Uri.tryParse(path);
    if (uri == null || uri.hasScheme || uri.hasAuthority ||
        uri.hasQuery || uri.hasFragment || !path.startsWith('/v1/') ||
        path.contains('\\') || path.contains('%') ||
        path.contains('//') || uri.normalizePath().path != path ||
        !{'GET', 'POST'}.contains(method)) {
      throw ArgumentError('A canonical registered relative API contract is required');
    }
  }
  final String path;
  final String method;
}

/// Common dispatch checks for every authenticated communication adapter.
abstract base class CommunicationTransportBase implements CommunicationTransport {
  CommunicationTransportBase(Map<String, CommunicationRouteBinding> bindings)
      : bindings = Map.unmodifiable(bindings);

  final Map<String, CommunicationRouteBinding> bindings;
  static const actions = {
    'message': {'create', 'send', 'read', 'mark_read'},
    'picture': {'upload', 'open'},
    'audio': {'invite', 'accept', 'decline', 'end', 'expire', 'signal'},
    'email': {'queue', 'deliver', 'read'},
  };

  @override
  Future<Map<String, Object?>> execute(
    String channel, Map<String, Object?> request,
  ) async {
    final action = request['action'];
    if (!(actions[channel]?.contains(action) ?? false) ||
        request.keys.any({'actor', 'actorId', 'tenantId', 'roles'}.contains)) {
      throw ArgumentError('Invalid communication command or identity override');
    }
    final binding = bindings['$channel.$action'];
    if (binding == null) throw StateError('Communication contract is not bound');
    if (binding.method == 'GET' && !{'read', 'open'}.contains(action)) {
      throw StateError('A mutating communication command requires POST');
    }
    return dispatch(binding, channel, Map.unmodifiable(request));
  }

  Future<Map<String, Object?>> dispatch(CommunicationRouteBinding binding,
      String channel, Map<String, Object?> request);
}

/// Reuses an authenticated Dio instance, including its session interceptors.
/// No demo cache, retries, redirect following, or identity headers are added.
final class DioCommunicationTransport extends CommunicationTransportBase {
  DioCommunicationTransport(this.dio, super.bindings);
  final Dio dio;

  @override
  Future<Map<String, Object?>> dispatch(CommunicationRouteBinding binding,
      String channel, Map<String, Object?> request) async {
    Object? body = request;
    if (channel == 'picture' && request['action'] == 'upload') {
      final bytes = request['bytes'];
      final mediaType = request['mediaType'];
      if (bytes is! Uint8List || bytes.isEmpty ||
          !{'image/jpeg', 'image/png'}.contains(mediaType)) {
        throw ArgumentError('A nonempty JPEG or PNG upload is required');
      }
      body = FormData.fromMap({
        for (final entry in request.entries)
          if (entry.key != 'bytes') entry.key: entry.value,
        'file': MultipartFile.fromBytes(Uint8List.fromList(bytes),
          filename: mediaType == 'image/png' ? 'picture.png' : 'picture.jpg',
          contentType: DioMediaType.parse(mediaType as String)),
      });
    }
    final response = await dio.request<Object?>(binding.path,
      data: binding.method == 'GET' ? null : body,
      queryParameters: binding.method == 'GET' ? request : null,
      options: Options(method: binding.method, followRedirects: false,
        validateStatus: (status) => status != null && status >= 200 && status < 300),
    );
    // Also check explicitly: custom adapters/interceptors may bypass validation.
    final status = response.statusCode;
    final value = response.data;
    if (status == null || status < 200 || status >= 300 || value is! Map ||
        value.keys.any((key) => key is! String)) {
      throw StateError('Communication response did not acknowledge the request');
    }
    return Map<String, Object?>.unmodifiable(value.cast<String, Object?>());
  }
}
