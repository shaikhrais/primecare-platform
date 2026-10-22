import 'dart:async';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'communication_core.dart';

/// Supplied by the registered contract loader, never by a screen or message.
/// This declaration does not register an endpoint or grant a permission.
final class CommunicationRouteBinding {
  CommunicationRouteBinding({required this.path, required this.method, this.includeAction = true}) {
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
  final bool includeAction;
}

/// Common dispatch checks for every authenticated communication adapter.
abstract base class CommunicationTransportBase implements CommunicationTransport {
  CommunicationTransportBase(Map<String, CommunicationRouteBinding> bindings)
      : bindings = Map.unmodifiable(bindings);

  final Map<String, CommunicationRouteBinding> bindings;
  static const actions = {
    'message': {'create', 'send', 'read', 'mark_read', 'inbox'},
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
    if (binding.method == 'GET' && !{'read', 'open', 'inbox'}.contains(action)) {
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
  DioCommunicationTransport(this.dio, super.bindings, {
    required this.maxPictureBytes,
  }) {
    if (maxPictureBytes < 1) throw ArgumentError('Configured picture byte limit required');
  }
  final Dio dio;
  final int maxPictureBytes;

  @override
  Future<Map<String, Object?>> dispatch(CommunicationRouteBinding binding,
      String channel, Map<String, Object?> request) async {
    final binary = channel == 'picture' && request['action'] == 'open';
    Object? body = request;
    if (channel == 'picture' && request['action'] == 'upload') {
      final bytes = request['bytes'];
      final mediaType = request['mediaType'];
      if (bytes is! Uint8List || bytes.isEmpty || bytes.length > maxPictureBytes ||
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
      queryParameters: binding.method == 'GET' ? {
        for (final entry in request.entries)
          if (binding.includeAction || entry.key != 'action') entry.key: entry.value,
      } : null,
      options: Options(method: binding.method, followRedirects: false,
        responseType: binary ? ResponseType.stream : ResponseType.json,
        validateStatus: (status) => status != null && status >= 200 && status < 300),
    );
    // Also check explicitly: custom adapters/interceptors may bypass validation.
    final status = response.statusCode;
    final value = response.data;
    if (binary && value is ResponseBody) {
      final iterator = StreamIterator<Uint8List>(value.stream);
      try {
        final mediaType = response.headers.value('content-type')?.split(';').first.trim().toLowerCase();
        final declared = response.headers.value('content-length');
        final length = declared == null ? null : int.tryParse(declared);
        if (status == null || status < 200 || status >= 300 ||
            !{'image/png', 'image/jpeg'}.contains(mediaType) ||
            declared != null && (length == null || length < 1 || length > maxPictureBytes)) {
          throw StateError('Picture response unavailable');
        }
        final builder = BytesBuilder(copy: true);
        while (await iterator.moveNext()) {
          if (builder.length + iterator.current.length > maxPictureBytes) {
            throw StateError('Picture response exceeds configured limit');
          }
          builder.add(iterator.current);
        }
        final bytes = builder.takeBytes();
        final png = bytes.length >= 8 &&
            List.generate(8, (i) => bytes[i]).join(',') == '137,80,78,71,13,10,26,10';
        final jpeg = bytes.length >= 3 && bytes[0] == 255 && bytes[1] == 216 && bytes[2] == 255;
        if (bytes.isEmpty || length != null && bytes.length != length ||
            !(mediaType == 'image/png' && png || mediaType == 'image/jpeg' && jpeg)) {
          throw StateError('Picture response is not the expected bounded raster');
        }
        return Map.unmodifiable({'bytes': bytes, 'mediaType': mediaType});
      } finally {
        await iterator.cancel();
      }
    }
    if (binary || status == null || status < 200 || status >= 300 || value is! Map ||
        value.keys.any((key) => key is! String)) {
      throw StateError('Communication response did not acknowledge the request');
    }
    return Map<String, Object?>.unmodifiable(value.cast<String, Object?>());
  }
}
