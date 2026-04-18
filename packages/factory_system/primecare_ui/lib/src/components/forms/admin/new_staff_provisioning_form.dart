import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_core/primecare_core.dart';
import 'package:primecare_core/flutter_core.dart';
import '../../layouts/responsive_grid_layout.dart';
import '../base_form.dart';

// --- State Model ---
class StaffProvisionData {
  final String firstName;
  final String lastName;
  final String email;
  final String role;
  final String department;
  final String additionalNotes;

  StaffProvisionData({
    this.firstName = '',
    this.lastName = '',
    this.email = '',
    this.role = 'Nurse',
    this.department = 'General',
    this.additionalNotes = '',
  });

  StaffProvisionData copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? role,
    String? department,
    String? additionalNotes,
  }) {
    return StaffProvisionData(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      role: role ?? this.role,
      department: department ?? this.department,
      additionalNotes: additionalNotes ?? this.additionalNotes,
    );
  }
}

// --- Notifier / ViewModel ---
class StaffProvisioningNotifier extends AsyncNotifier<StaffProvisionData> {
  @override
  FutureOr<StaffProvisionData> build() {
    return StaffProvisionData();
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

  Future<void> submit() async {
    final currentData = state.value;
    if (currentData == null) return;

    // 1. Connectivity Check Resilience
    final isOnline = ref.read(isOnlineProvider);
    if (!isOnline) {
      state = AsyncError(
        'Device is currently offline. Please check your connection.',
        StackTrace.current,
      );
      return;
    }

    state = const AsyncLoading();

    // 2. Network Telemetry wrapper
    final result = await Result.guardFuture<bool>(
      () async {
        // Connect safely to the database-driven admin endpoint
        await ref.read(apiClientProvider).post(
          '/api/v1/admin/provision-staff',
          body: {
            'firstName': currentData.firstName,
            'lastName': currentData.lastName,
            'email': currentData.email,
            'role': currentData.role,
            'department': currentData.department,
            'additionalNotes': currentData.additionalNotes,
          },
        );

        ref
            .read(executionGateProvider)
            .passGate(
              ExecutionGateCategory.domainApi,
              'Staff member provisioned successfully',
              metadata: {
                'role': currentData.role,
                'dept': currentData.department,
              },
            );
        return true;
      },
      onError: (e, st) {
        ref
            .read(executionGateProvider)
            .failGate(
              ExecutionGateCategory.domainApi,
              'Staff provisioning failed',
              error: e,
              stackTrace: st,
            );
        return false; // Safe fallback
      },
    );

    // 3. Fold operation
    result.fold(
      (success) {
        if (success) {
          state = AsyncData(StaffProvisionData()); // Reset on success
        } else {
          state = AsyncError('Failed to provision staff.', StackTrace.current);
        }
      },
      (failure) {
        state = AsyncError(failure.toString(), StackTrace.current);
      },
    );
  }
}

final staffProvisioningProvider =
    AsyncNotifierProvider<StaffProvisioningNotifier, StaffProvisionData>(
      () => StaffProvisioningNotifier(),
    );

// --- UI Component ---
class NewStaffProvisioningForm extends ConsumerStatefulWidget {
  final VoidCallback? onSuccess;

  const NewStaffProvisioningForm({super.key, this.onSuccess});

  @override
  ConsumerState<NewStaffProvisioningForm> createState() =>
      _NewStaffProvisioningFormState();
}

class _NewStaffProvisioningFormState
    extends ConsumerState<NewStaffProvisioningForm> {
  final _formKey = GlobalKey<FormState>();

  void _submit() {
    final notifier = ref.read(staffProvisioningProvider.notifier);
    notifier.submit().then((_) {
      if (ref.read(staffProvisioningProvider).hasValue) {
        widget.onSuccess?.call();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final asyncState = ref.watch(staffProvisioningProvider);
    final theme = Theme.of(context);
    final layout = ref.watch(layoutProvider);

    // Dynamic span allocation based on current grid threshold
    final int halfSpan = (layout.totalColumns / 2).ceil();
    final int thirdSpan = (layout.totalColumns / 3).ceil();
    final int twoThirdsSpan = layout.totalColumns - thirdSpan;
    final int fullSpan = layout.totalColumns;

    return BaseForm(
      formKey: _formKey,
      title: 'Provision New Staff',
      subtitle: 'Onboard a new staff member and assign their role.',
      onSubmit: _submit,
      submitText: 'Provision Staff',
      isLoading: asyncState.isLoading,
      children: [
        if (asyncState.hasError)
          Padding(
            padding: EdgeInsets.only(bottom: 16.0 * layout.scaleFactor),
            child: Text(
              asyncState.error.toString(),
              style: TextStyle(color: theme.colorScheme.error),
            ),
          ),

        // Form layout mapped directly against PrimeCare's Adaptive Grid V2
        ResponsiveGridRow(
          spacing: 16 * layout.scaleFactor,
          runSpacing: 16 * layout.scaleFactor,
          children: [
            ResponsiveGridCol(
              span: layout.tier == ResolutionTier.mob ? fullSpan : halfSpan,
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'First Name',
                  labelStyle: TextStyle(color: theme.colorScheme.primary),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      12 * layout.scaleFactor,
                    ),
                  ),
                ),
                initialValue: asyncState.value?.firstName,
                onChanged: (val) => ref
                    .read(staffProvisioningProvider.notifier)
                    .updateData(firstName: val),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Required' : null,
              ),
            ),
            ResponsiveGridCol(
              span: layout.tier == ResolutionTier.mob ? fullSpan : halfSpan,
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Last Name',
                  labelStyle: TextStyle(color: theme.colorScheme.primary),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      12 * layout.scaleFactor,
                    ),
                  ),
                ),
                initialValue: asyncState.value?.lastName,
                onChanged: (val) => ref
                    .read(staffProvisioningProvider.notifier)
                    .updateData(lastName: val),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Required' : null,
              ),
            ),
            ResponsiveGridCol(
              span: fullSpan,
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Corporate Email',
                  labelStyle: TextStyle(color: theme.colorScheme.primary),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      12 * layout.scaleFactor,
                    ),
                  ),
                  prefixIcon: const Icon(Icons.email),
                ),
                keyboardType: TextInputType.emailAddress,
                initialValue: asyncState.value?.email,
                onChanged: (val) => ref
                    .read(staffProvisioningProvider.notifier)
                    .updateData(email: val),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Required';
                  if (!value.contains('@primecare.com'))
                    return 'Must be a valid @primecare.com email';
                  return null;
                },
              ),
            ),
            ResponsiveGridCol(
              span: layout.tier == ResolutionTier.mob ? fullSpan : thirdSpan,
              child: DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Role',
                  labelStyle: TextStyle(color: theme.colorScheme.primary),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      12 * layout.scaleFactor,
                    ),
                  ),
                ),
                initialValue: asyncState.value?.role,
                items: const [
                  DropdownMenuItem(value: 'Doctor', child: Text('Doctor')),
                  DropdownMenuItem(value: 'Nurse', child: Text('Nurse')),
                  DropdownMenuItem(value: 'PSW', child: Text('PSW')),
                  DropdownMenuItem(value: 'Admin', child: Text('Admin')),
                ],
                onChanged: (val) => ref
                    .read(staffProvisioningProvider.notifier)
                    .updateData(role: val),
              ),
            ),
            ResponsiveGridCol(
              span: layout.tier == ResolutionTier.mob
                  ? fullSpan
                  : twoThirdsSpan,
              child: DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Department',
                  labelStyle: TextStyle(color: theme.colorScheme.primary),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      12 * layout.scaleFactor,
                    ),
                  ),
                ),
                initialValue: asyncState.value?.department,
                items: const [
                  DropdownMenuItem(value: 'General', child: Text('General')),
                  DropdownMenuItem(
                    value: 'Cardiology',
                    child: Text('Cardiology'),
                  ),
                  DropdownMenuItem(
                    value: 'Neurology',
                    child: Text('Neurology'),
                  ),
                  DropdownMenuItem(
                    value: 'Emergency',
                    child: Text('Emergency'),
                  ),
                ],
                onChanged: (val) => ref
                    .read(staffProvisioningProvider.notifier)
                    .updateData(department: val),
              ),
            ),
            ResponsiveGridCol(
              span: fullSpan,
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Additional Notes / Clearances',
                  labelStyle: TextStyle(color: theme.colorScheme.primary),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      12 * layout.scaleFactor,
                    ),
                  ),
                  alignLabelWithHint: true,
                ),
                maxLines: 3,
                initialValue: asyncState.value?.additionalNotes,
                onChanged: (val) => ref
                    .read(staffProvisioningProvider.notifier)
                    .updateData(additionalNotes: val),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
