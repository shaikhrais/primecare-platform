import 'base_entity.dart';

class UserModel extends BaseEntity<String> {
  final String firstName;
  final String lastName;
  final String email;
  final String role;
  final String status;
  final String office;

  UserModel({
    required super.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.role,
    required this.status,
    required this.office,
  });

  String get name => '$firstName $lastName';

  UserModel copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? role,
    String? status,
    String? office,
  }) {
    return UserModel(
      id: id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      role: role ?? this.role,
      status: status ?? this.status,
      office: office ?? this.office,
    );
  }
}
