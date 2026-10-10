import 'base_entity.dart';

/// Secret-free account contract shared by the Admin workflow and presentation.
class AdminUser extends BaseEntity<String> {
  final String email;
  final String role;
  final String status;
  const AdminUser({required String id, required this.email, required this.role, required this.status}) : super(id: id);
  factory AdminUser.fromJson(Map<String, dynamic> data) {
    if (data['id'] is! String || (data['id'] as String).isEmpty || data['email'] is! String || data['role'] is! String || !['active','inactive'].contains(data['status'])) {
      throw const FormatException('Invalid admin account response');
    }
    return AdminUser(id: data['id'] as String, email: data['email'] as String, role: data['role'] as String, status: data['status'] as String);
  }
}
