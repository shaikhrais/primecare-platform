// Layer: 03_DATA_DOMAIN_LOGIC
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserModel {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String role;
  final String status;
  final String office;

  UserModel({
    required this.id,
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

class UserManagementNotifier extends AsyncNotifier<List<UserModel>> {
  @override
  Future<List<UserModel>> build() async {
    // NOTE: Connect to actual primecare-api user.service.ts endpoint.
    // For now, simulating network delay and returning initial set to prove AsyncNotifier architecture
    await Future<void>.delayed(const Duration(milliseconds: 800));
    return [
      UserModel(
        id: '1',
        firstName: 'Mohammed',
        lastName: 'Admin',
        email: 'itpro.mohammed@gmail.com',
        role: 'SYSTEM_ADMIN_TIER_1',
        status: 'Active',
        office: 'Global',
      ),
      UserModel(
        id: '2',
        firstName: 'Sarah',
        lastName: 'CEO',
        email: 'ceo@primecare.com',
        role: 'FINANCE_DIRECTOR_TIER_3',
        status: 'Active',
        office: 'Global',
      ),
      UserModel(
        id: '3',
        firstName: 'Alex',
        lastName: 'Clinical',
        email: 'clinician@primecare.com',
        role: 'PSW_HUB_MANAGER_TIER_4',
        status: 'Inactive',
        office: 'Toronto West',
      ),
    ];
  }

  Future<void> reload() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => build());
  }

  Future<void> addUser(UserModel user) async {
    final previousState = state;
    // Optimistic insert
    state = AsyncData([...state.value ?? [], user]);
    try {
      // Simulate API call
      await Future<void>.delayed(const Duration(milliseconds: 500));
      // In real implementation we would send this to the backend
    } catch (e, st) {
      state = previousState;
      state = AsyncError(e, st);
    }
  }

  Future<void> updateUser(String id, UserModel updatedUser) async {
    final previousState = state;
    state = AsyncData([
      for (final user in state.value ?? <UserModel>[])
        if (user.id == id) updatedUser else user,
    ]);
    try {
      await Future<void>.delayed(const Duration(milliseconds: 500));
    } catch (e, st) {
      state = previousState;
      state = AsyncError(e, st);
    }
  }

  Future<void> toggleStatus(String id) async {
    final previousState = state;
    state = AsyncData([
      for (final user in state.value ?? <UserModel>[])
        if (user.id == id)
          user.copyWith(status: user.status == 'Active' ? 'Inactive' : 'Active')
        else
          user,
    ]);
    try {
      await Future<void>.delayed(const Duration(milliseconds: 500));
    } catch (e, st) {
      state = previousState;
      state = AsyncError(e, st);
    }
  }

  Future<void> deleteUser(String id) async {
    final previousState = state;
    state = AsyncData(
      (state.value ?? <UserModel>[]).where((user) => user.id != id).toList(),
    );
    try {
      await Future<void>.delayed(const Duration(milliseconds: 500));
    } catch (e, st) {
      state = previousState;
      state = AsyncError(e, st);
    }
  }
}

final userManagementProvider =
    AsyncNotifierProvider<UserManagementNotifier, List<UserModel>>(() {
      return UserManagementNotifier();
    });
