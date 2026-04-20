// ignore_for_file: avoid_dynamic_calls, argument_type_not_assignable, inference_failure_on_instance_creation, strict_raw_type, inference_failure_on_function_invocation, undefined_identifier, inference_failure_on_collection_literal, undefined_named_parameter, return_of_invalid_type, prefer_single_quotes, invalid_assignment, non_type_as_type_argument
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

class UserManagementNotifier extends AsyncNotifier<List<UserModel>> {
  @override
  Future<List<UserModel>> build() async {
    // TODO: Connect to actual primecare-api user.service.ts endpoint.
    // For now, simulating network delay and returning initial set to prove AsyncNotifier architecture
    await Future<void>.delayed(const Duration(milliseconds: 800));
    return [
      UserModel(
        id: '1',
        name: 'Mohammed',
        email: 'itpro.mohammed@gmail.com',
        role: 'SYSTEM_ADMIN_TIER_1',
        status: 'Active',
        office: 'Global',
      ),
      UserModel(
        id: '2',
        name: 'Sarah CEO',
        email: 'ceo@primecare.com',
        role: 'FINANCE_DIRECTOR_TIER_3',
        status: 'Active',
        office: 'Global',
      ),
      UserModel(
        id: '3',
        name: 'Alex Clinical',
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
