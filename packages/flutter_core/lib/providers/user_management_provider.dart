import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserModel {
  final String id;
  final String name;
  final String email;
  final String role;
  final String status;
  final String office;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.status,
    required this.office,
  });

  UserModel copyWith({
    String? name,
    String? email,
    String? role,
    String? status,
    String? office,
  }) {
    return UserModel(
      id: id,
      name: name ?? this.name,
      email: email ?? this.email,
      role: role ?? this.role,
      status: status ?? this.status,
      office: office ?? this.office,
    );
  }
}

class UserManagementNotifier extends Notifier<List<UserModel>> {
  @override
  List<UserModel> build() {
    return [
      UserModel(
        id: '1',
        name: 'Mohammed',
        email: 'itpro.mohammed@gmail.com',
        role: 'Super Admin',
        status: 'Active',
        office: 'Global',
      ),
      UserModel(
        id: '2',
        name: 'Sarah CEO',
        email: 'ceo@primecare.com',
        role: 'CEO',
        status: 'Active',
        office: 'Global',
      ),
      UserModel(
        id: '3',
        name: 'Alex Clinical',
        email: 'clinician@primecare.com',
        role: 'PSW',
        status: 'Inactive',
        office: 'Toronto West',
      ),
    ];
  }

  void addUser(UserModel user) {
    state = [...state, user];
  }

  void updateUser(String id, UserModel updatedUser) {
    state = [
      for (final user in state)
        if (user.id == id) updatedUser else user,
    ];
  }

  void toggleStatus(String id) {
    state = [
      for (final user in state)
        if (user.id == id)
          user.copyWith(
              status: user.status == 'Active' ? 'Inactive' : 'Active')
        else
          user,
    ];
  }

  void deleteUser(String id) {
    state = state.where((user) => user.id != id).toList();
  }
}

final userManagementProvider =
    NotifierProvider<UserManagementNotifier, List<UserModel>>(() {
  return UserManagementNotifier();
});
