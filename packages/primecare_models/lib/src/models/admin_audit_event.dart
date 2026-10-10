import 'base_entity.dart';

/// Audit projection contains only public account fields, never credentials.
class AdminAuditEvent extends BaseEntity<String> {
  final String actor, target, action;
  final DateTime createdAt;
  final Map<String, String> before, after;
  const AdminAuditEvent({required String id, required this.actor, required this.target, required this.action, required this.createdAt, required this.before, required this.after}) : super(id: id);
  factory AdminAuditEvent.fromJson(Map<String,dynamic> data) {
    Map<String,String> state(dynamic value) {
      if(value == null) return const {};
      if(value is! Map || value.keys.any((key) => !['email','role','status'].contains(key)) || value.values.any((v) => v is! String)) throw const FormatException('Invalid audit state');
      return Map<String,String>.unmodifiable(Map<String,String>.from(value));
    }
    final created = data['createdAt'] is String ? DateTime.tryParse(data['createdAt'] as String) : null;
    if(data['id'] is! String || data['actor'] is! String || data['target'] is! String || !['account_created','account_updated','sessions_revoked'].contains(data['action']) || created == null) throw const FormatException('Invalid audit event');
    return AdminAuditEvent(id:data['id'] as String,actor:data['actor'] as String,target:data['target'] as String,action:data['action'] as String,createdAt:created,before:state(data['before']),after:state(data['after']));
  }
}
