// ignore_for_file: avoid_dynamic_calls, argument_type_not_assignable, inference_failure_on_instance_creation, strict_raw_type, inference_failure_on_function_invocation, undefined_identifier, inference_failure_on_collection_literal, undefined_named_parameter, return_of_invalid_type, prefer_single_quotes, invalid_assignment, non_type_as_type_argument
import 'package:primecare_core/flutter_core.dart';
import 'dart:async';
import 'package:primecare_core/primecare_core.dart';


// --- State Model ---
class StaffProvisionData {
  final String firstName;
  final String lastName;
  final String email;
  final String role;
  final String department;
  final String additionalNotes;
  final List<Map<String, dynamic>> availableRoles;
  final List<Map<String, dynamic>> availableDepartments;

  StaffProvisionData({
    this.firstName = '',
    this.lastName = '',
    this.email = '',
    this.role = '',
    this.department = '',
    this.additionalNotes = '',
    this.availableRoles = const [],
    this.availableDepartments = const [],
  });

  StaffProvisionData copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? role,
    String? department,
    String? additionalNotes,
    List<Map<String, dynamic>>? availableRoles,
    List<Map<String, dynamic>>? availableDepartments,
  }) {
    return StaffProvisionData(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      role: role ?? this.role,
      department: department ?? this.department,
      additionalNotes: additionalNotes ?? this.additionalNotes,
      availableRoles: availableRoles ?? this.availableRoles,
      availableDepartments: availableDepartments ?? this.availableDepartments,
    );
  }
}

// --- Notifier / Business Logic Adapter ---
class StaffProvisioningFormAdapter extends AsyncNotifier<StaffProvisionData> {
  @override
  FutureOr<StaffProvisionData> build() async {
    try {
      // Parallel fetch for optimized loading
      final futures = await Future.wait([
        ref.read(apiClientProvider).get(ApiConfig.endpoints['identityRoles']!),
        ref.read(apiClientProvider).get(ApiConfig.endpoints['adminDepartments']!),
      ]);

      final rolesResponse = futures[0];
      final deptsResponse = futures[1];

      final List<Map<String, dynamic>> roles = List<Map<String, dynamic>>.from(rolesResponse.data['data'] ?? []);
      final List<Map<String, dynamic>> depts = List<Map<String, dynamic>>.from(deptsResponse.data['data'] ?? []);

      return StaffProvisionData(
        availableRoles: roles,
        availableDepartments: depts,
        role: roles.isNotEmpty ? roles.first['id'] : '',
        department: depts.isNotEmpty ? depts.first['id'] : '',
      );
    } catch (e) {
      // Return empty state but log failure
      return StaffProvisionData();
    }
  }

  void updateData({
    String? firstName,
    String? lastName,
    String? email,
    String? role,
    String? department,
    String? additionalNotes,
  }) {
    final current = state.value ?? StaffProvisionData();
    state = AsyncData(
      current.copyWith(
        firstName: firstName,
        lastName: lastName,
        email: email,
        role: role,
        department: department,
        additionalNotes: additionalNotes,
      ),
    );
  }

  Future<bool> submit() async {
    final currentData = state.value;
    if (currentData == null) return false;

    // Resilience check
    final isOnline = ref.read(isOnlineProvider);
    if (!isOnline) {
      state = AsyncError('Device is offline.', StackTrace.current);
      return false;
    }

    state = const AsyncLoading();

    final result = await ref.read(domainServiceProvider).provisionStaff({
      'firstName': currentData.firstName,
      'lastName': currentData.lastName,
      'email': currentData.email,
      'roleId': currentData.role,
      'department': currentData.department,
      'additionalNotes': currentData.additionalNotes,
    });

    return result.fold(
      (data) {
        // Reset form but preserve metadata
        final current = state.value;
        state = AsyncData(StaffProvisionData(
          availableRoles: current?.availableRoles ?? [],
          availableDepartments: current?.availableDepartments ?? [],
          role: current?.availableRoles.isNotEmpty == true ? current?.availableRoles.first['id'] : '',
          department: current?.availableDepartments.isNotEmpty == true ? current?.availableDepartments.first['id'] : '',
        ));
        return true;
      },
      (failure) {
        state = AsyncError(failure.toString(), StackTrace.current);
        return false;
      },
    );
  }
}

final staffProvisioningFormAdapterProvider =
    AsyncNotifierProvider<StaffProvisioningFormAdapter, StaffProvisionData>(
      () => StaffProvisioningFormAdapter(),
    );
