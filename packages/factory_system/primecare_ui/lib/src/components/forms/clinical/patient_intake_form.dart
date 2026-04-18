import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_core/primecare_core.dart';
import 'package:primecare_core/flutter_core.dart';
import '../../layouts/responsive_grid_layout.dart';
import '../base_form.dart';

// --- State Model ---
class PatientIntakeData {
  final String firstName;
  final String lastName;
  final String details;

  PatientIntakeData({
    this.firstName = '',
    this.lastName = '',
    this.details = '',
  });

  PatientIntakeData copyWith({
    String? firstName,
    String? lastName,
    String? details,
  }) {
    return PatientIntakeData(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      details: details ?? this.details,
    );
  }
}

// --- Notifier / ViewModel ---
class PatientIntakeNotifier extends AsyncNotifier<PatientIntakeData> {
  @override
  FutureOr<PatientIntakeData> build() {
    return PatientIntakeData();
  }

  void updateData({String? firstName, String? lastName, String? details}) {
    final current = state.value ?? PatientIntakeData();
    state = AsyncData(
      current.copyWith(
        firstName: firstName,
        lastName: lastName,
        details: details,
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
        // Connect safely to the database-driven clinical endpoint
        await ref.read(apiClientProvider).post('/api/v1/clinical/patient-intake', body: {
          'firstName': currentData.firstName,
          'lastName': currentData.lastName,
          'details': currentData.details,
        });

        ref
            .read(executionGateProvider)
            .passGate(
              ExecutionGateCategory.domainApi,
              'Patient intake submitted successfully',
            );
        return true;
      },
      onError: (e, st) {
        ref
            .read(executionGateProvider)
            .failGate(
              ExecutionGateCategory.domainApi,
              'Patient intake submission failed',
              error: e,
              stackTrace: st,
            );
        return false; // Safe fallback
      },
    );

    // 3. Fold operation (No named arguments!)
    result.fold(
      (success) {
        if (success) {
          state = AsyncData(PatientIntakeData()); // Reset on success
        } else {
          state = AsyncError(
            'Failed to submit patient intake.',
            StackTrace.current,
          );
        }
      },
      (failure) {
        state = AsyncError(failure.toString(), StackTrace.current);
      },
    );
  }
}

final patientIntakeProvider =
    AsyncNotifierProvider<PatientIntakeNotifier, PatientIntakeData>(
      () => PatientIntakeNotifier(),
    );

// --- UI Component ---
class PatientIntakeForm extends ConsumerStatefulWidget {
  final VoidCallback? onSuccess;

  const PatientIntakeForm({super.key, this.onSuccess});

  @override
  ConsumerState<PatientIntakeForm> createState() => _PatientIntakeFormState();
}

class _PatientIntakeFormState extends ConsumerState<PatientIntakeForm> {
  final _formKey = GlobalKey<FormState>();

  void _submit() {
    final notifier = ref.read(patientIntakeProvider.notifier);
    notifier.submit().then((_) {
      if (ref.read(patientIntakeProvider).hasValue) {
        widget.onSuccess?.call();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final asyncState = ref.watch(patientIntakeProvider);
    final theme = Theme.of(context);
    final layout = ref.watch(layoutProvider);

    // Dynamic span allocation based on current grid threshold
    final int halfSpan = (layout.totalColumns / 2).ceil();
    final int fullSpan = layout.totalColumns;

    return BaseForm(
      formKey: _formKey,
      title: 'Patient Intake',
      subtitle: 'Complete the assessment details mapping to the adaptive grid.',
      onSubmit: _submit,
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
                    .read(patientIntakeProvider.notifier)
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
                    .read(patientIntakeProvider.notifier)
                    .updateData(lastName: val),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Required' : null,
              ),
            ),
            ResponsiveGridCol(
              span: fullSpan,
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Assessment Details',
                  labelStyle: TextStyle(color: theme.colorScheme.primary),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      12 * layout.scaleFactor,
                    ),
                  ),
                  alignLabelWithHint: true,
                ),
                maxLines: 4,
                initialValue: asyncState.value?.details,
                onChanged: (val) => ref
                    .read(patientIntakeProvider.notifier)
                    .updateData(details: val),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Required' : null,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
