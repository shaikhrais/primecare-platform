import 'base_api_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../network/api_client.dart';

final ownNotificationsRepositoryProvider = Provider<OwnNotificationsRepository>(
  (ref) => OwnNotificationsRepository(ref.read(apiClientProvider)),
);

/// Uses the existing authenticated_self_record_owner notification read contract.
/// The server binds user_id to the active bearer actor; no caller owner overrides.
abstract interface class OwnNotificationsRepository {
  factory OwnNotificationsRepository(ApiClient client) =
      _OwnNotificationsRepository;
  Future<ApiResponse> load();
}

class _OwnNotificationsRepository extends BaseApiRepository
    implements OwnNotificationsRepository {
  _OwnNotificationsRepository(super.client);

  Future<ApiResponse> load() async {
    final response = await get('/v1/auth/me/notifications');
    if (!response.isSuccess) return response;
    final body = response.data;
    if (body is! Map ||
        body['notifications'] is! List ||
        body['pagination'] is! Map) {
      return _invalid();
    }
    final records = body['notifications'] as List;
    final pagination = body['pagination'] as Map;
    final limit = pagination['limit'],
        offset = pagination['offset'],
        total = pagination['total'];
    if (limit is! int ||
        limit < 1 ||
        limit > 100 ||
        offset is! int ||
        offset < 0 ||
        total is! int ||
        total < 0 ||
        pagination['hasMore'] is! bool ||
        records.length > limit) {
      return _invalid();
    }
    const fields = {'id', 'title', 'message', 'type', 'is_read', 'created_at'};
    final projected = <Map<String, dynamic>>[];
    for (final row in records) {
      if (row is! Map ||
          row.keys.toSet().difference(fields).isNotEmpty ||
          row.keys.toSet().length != fields.length ||
          row['id'] is! String ||
          !RegExp(
            r'^[A-Za-z0-9][A-Za-z0-9_-]{0,199}$',
          ).hasMatch(row['id'] as String) ||
          row['title'] is! String ||
          row['message'] is! String ||
          row['type'] is! String ||
          row['is_read'] is! bool ||
          row['created_at'] is! String ||
          !_validTimestamp(row['created_at'] as String)) {
        return _invalid();
      }
      projected.add(Map<String, dynamic>.from(row));
    }
    // The screen consumes a collection rather than the canonical paging envelope.
    return ApiResponse(data: projected, statusCode: response.statusCode);
  }

  bool _validTimestamp(String value) {
    if (!RegExp(
      r'^\d{4}-\d{2}-\d{2}T(?:[01]\d|2[0-3]):[0-5]\d:[0-5]\d(?:\.\d+)?(?:Z|[+-](?:[01]\d|2[0-3]):[0-5]\d)$',
    ).hasMatch(value))
      return false;
    final parts = value.substring(0, 10).split('-').map(int.parse).toList();
    final calendar = DateTime.utc(parts[0], parts[1], parts[2]);
    return calendar.year == parts[0] &&
        calendar.month == parts[1] &&
        calendar.day == parts[2] &&
        DateTime.tryParse(value) != null;
  }

  ApiResponse _invalid() => ApiResponse(
    data: <String, dynamic>{},
    statusCode: 503,
    error: 'Notification response is unavailable.',
  );
}
