import 'base_entity.dart';

/// Token-free identity shared by API response writers and UI session readers.
class AuthSession extends BaseEntity<String> {
  final String role;
  const AuthSession(String userId, this.role) : super(id: userId);
  String get userId => id;
  factory AuthSession.fromJson(Map<String, dynamic> data) {
    final id = data['userId'];
    final role = data['roles'] ?? data['role'];
    if (data['status'] != 'authenticated' ||
        id is! String ||
        id.isEmpty ||
        role is! String ||
        role.isEmpty) {
      throw const FormatException('Invalid authentication response');
    }
    return AuthSession(id, role);
  }
  Map<String, Object?> toJson() => {
    'userId': userId,
    'roles': role,
    'status': 'authenticated',
  };

  /// Login exposes the new token once; the identity itself never retains it.
  Map<String, Object?> toLoginJson(String token) => {
    'userId': userId,
    'role': role,
    'token': token,
    'status': 'authenticated',
  };
}
