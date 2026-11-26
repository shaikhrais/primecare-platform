import '../src/infrastructure/repositories/base_api_repository.dart';
import '../src/network/api_client.dart';

class PlatformAdministrationFailure implements Exception {
  final int status;
  const PlatformAdministrationFailure(this.status);
}

Map<String, dynamic> _object(dynamic value) {
  if (value is! Map) throw const FormatException('Invalid administration response');
  return Map<String, dynamic>.from(value);
}
String _text(dynamic value) {
  if (value is! String || value.isEmpty || value.length > 200 ||
      RegExp(r'[\x00-\x1f\x7f]').hasMatch(value)) {
    throw const FormatException('Invalid administration field');
  }
  return value;
}
String _id(dynamic value) {
  final text = _text(value);
  if (!RegExp(r'^[A-Za-z0-9][A-Za-z0-9_-]{0,199}$').hasMatch(text)) {
    throw const FormatException('Invalid administration identity');
  }
  return text;
}
List<T> _list<T>(dynamic value, T Function(dynamic) parse) {
  if (value is! List || value.length > 100) throw const FormatException('Invalid administration list');
  return List.unmodifiable(value.map(parse));
}

class PlatformTenant {
  final String id, name;
  PlatformTenant(dynamic value)
      : id = _id(_object(value)['id']), name = _text(_object(value)['name']);
}
class PlatformMaster {
  final String id, type, code, label, status;
  final int version;
  PlatformMaster(dynamic value)
      : id = _id(_object(value)['id']), type = _text(_object(value)['type']),
        code = _text(_object(value)['code']), label = _text(_object(value)['label']),
        status = _text(_object(value)['status']), version = _version(_object(value)['version']);
  static int _version(dynamic value) {
    if (value is! int || value < 1) throw const FormatException('Invalid master version');
    return value;
  }
  bool same(PlatformMaster other) => id == other.id && type == other.type &&
      code == other.code && label == other.label && status == other.status && version == other.version;
}
class PlatformAdministrationIndex {
  final List<PlatformTenant> tenants;
  final List<String> types;
  PlatformAdministrationIndex(dynamic value, String actor)
      : tenants = _list(_object(value)['tenants'], PlatformTenant.new),
        types = _list(_object(value)['masterTypes'], _text) {
    if (_object(_object(value)['identity'])['userId'] != actor ||
        tenants.map((t) => t.id).toSet().length != tenants.length ||
        types.toSet().length != types.length) {
      throw const FormatException('Administration identity mismatch');
    }
  }
}

/// Inherits the injected API transport. No database, cache or role override.
class PlatformMasterRepository extends BaseApiRepository {
  PlatformMasterRepository(super.client, {required this.actor, required String token}) : _token = token;
  final String actor;
  final String _token;
  static const endpoint = '/v1/governance/platform';
  Map<String, dynamic> _response(ApiResponse response, int expected) {
    if (response.statusCode != expected) throw PlatformAdministrationFailure(response.statusCode);
    return _object(response.data);
  }
  Future<PlatformAdministrationIndex> index() async =>
      PlatformAdministrationIndex(_response(await client.getForSession(endpoint, _token), 200), actor);
  String _path(PlatformAdministrationIndex index, String tenant) {
    if (!index.tenants.any((item) => item.id == tenant)) {
      throw const PlatformAdministrationFailure(403);
    }
    return '$endpoint/tenants/${Uri.encodeComponent(tenant)}/masters';
  }
  Future<List<PlatformMaster>> records(PlatformAdministrationIndex index, String tenant) async {
    final data = _response(await client.getForSession(_path(index, tenant), _token), 200);
    final records = _list(data['records'], PlatformMaster.new);
    if (records.map((r) => r.id).toSet().length != records.length ||
        records.any((r) => !index.types.contains(r.type) || !['active', 'inactive'].contains(r.status))) {
      throw const FormatException('Invalid master collection');
    }
    return records;
  }
  Map<String, String> command(PlatformAdministrationIndex index, String type, String code, String label) {
    if (!index.types.contains(type) || !RegExp(r'^[a-z][a-z0-9_-]{1,63}$').hasMatch(code) ||
        label.trim().isEmpty || label.length > 150 || RegExp(r'[\x00-\x1f\x7f]').hasMatch(label)) {
      throw const PlatformAdministrationFailure(400);
    }
    return Map.unmodifiable({'type': type, 'code': code, 'label': label.trim()});
  }
  Future<PlatformMaster> create(PlatformAdministrationIndex index, String tenant,
      Map<String, String> fields, String key) async {
    final path = _path(index, tenant);
    if (!RegExp(r'^[A-Za-z0-9_-]{16,100}$').hasMatch(key)) throw const PlatformAdministrationFailure(400);
    final valid = command(index, fields['type'] ?? '', fields['code'] ?? '', fields['label'] ?? '');
    if (fields.length != valid.length) throw const PlatformAdministrationFailure(400);
    final response = await client.post(path, body: valid,
      headers: {'Idempotency-Key': key, 'Authorization': 'Bearer $_token', 'Cache-Control': 'no-store'});
    final record = PlatformMaster(_response(response, 201)['record']);
    if (record.type != valid['type'] || record.code != valid['code'] || record.label != valid['label'] ||
        record.status != 'active' || record.version != 1) {
      throw const FormatException('Master receipt mismatch');
    }
    return record;
  }
}
