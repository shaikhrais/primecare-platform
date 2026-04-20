import 'package:primecare_core/flutter_core.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:primecare_core/primecare_core.dart';

import '../../layouts/responsive_grid_layout.dart';
import '../base_form.dart';
import 'package:dio/dio.dart';

// --- State Model ---
class PatientIntakeData {
  final String firstName;
  final String lastName;
  final String email;
  final DateTime? dateOfBirth;
  final String gender;
  final String details;
  final bool? isEmailAvailable;

  PatientIntakeData({
    this.firstName = '',
    this.lastName = '',
    this.email = '',
    this.dateOfBirth,
    this.gender = 'Other',
    this.details = '',
    this.isEmailAvailable,
  });

  PatientIntakeData copyWith({
    String? firstName,
    String? lastName,
    String? email,
    DateTime? dateOfBirth,
    String? gender,
    String? details,
    bool? isEmailAvailable,
  }) {
    return PatientIntakeData(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
      details: details ?? this.details,
      isEmailAvailable: isEmailAvailable ?? this.isEmailAvailable,
    );
  }
}

// --- Notifier / ViewModel ---
class PatientIntakeNotifier extends AsyncNotifier<PatientIntakeData> {
  @override
  FutureOr<PatientIntakeData> build() {
    return PatientIntakeData();
  }

  void updateData({
    String? firstName,
    String? lastName,
    String? email,
    DateTime? dateOfBirth,
    String? gender,
    String? details,
    bool? isEmailAvailable,
  }) {
    final current = state.value ?? PatientIntakeData();
    state = AsyncData(
      current.copyWith(
        firstName: firstName,
        lastName: lastName,
        email: email,
        dateOfBirth: dateOfBirth,
        gender: gender,
        details: details,
        isEmailAvailable: isEmailAvailable,
      ),
    );

    if (email != null && email.contains('@')) {
      _debounceEmailCheck(email);
    }
  }

  Timer? _emailDebounce;
  void _debounceEmailCheck(String email) {
    _emailDebounce?.cancel();
    _emailDebounce = Timer(const Duration(milliseconds: 500), () async {
      final result = await Result.guardFuture<Response>(
        () => ref.read(apiClientProvider).get('/v1/clinical/check-email', query: {'email': email}),
      );
      
      result.fold(
        (_) => updateData(isEmailAvailable: null),
        (response) {
          final data = (response as Response).data as Map<String, dynamic>;
          updateData(isEmailAvailable: data['available'] as bool?);
        },
      );
    });
  }

  Future<void> submit() async {
    final currentData = state.value;
    if (currentData == null) return;

    final isOnline = ref.read(isOnlineProvider);
    if (!isOnline) {
      state = AsyncError(
        'Device is currently offline. Please check your connection.',
        StackTrace.current,
      );
      return;
    }

    state = const AsyncLoading();

    final result = await Result.guardFuture<bool>(
      () async {
        await ref.read(apiClientProvider).post(
          '/v1/clinical/patient-intake',
          body: {
            'firstName': currentData.firstName,
            'lastName': currentData.lastName,
            'email': currentData.email,
            'dateOfBirth': currentData.dateOfBirth?.toIso8601String(),
            'gender': currentData.gender,
            'medicalHistory': currentData.details,
          },
        );
        return true;
      },
    );

    result.fold(
      (error) {
        state = AsyncError(error, StackTrace.current);
      },
      (success) {
        state = AsyncData(PatientIntakeData()); // Reset on success
      },
    );
  }
}

final patientIntakeProvider =
    AsyncNotifierProvider<PatientIntakeNotifier, PatientIntakeData>(
        PatientIntakeNotifier.new);

// --- Component ---
class PatientIntakeForm extends ConsumerStatefulWidget {
  final VoidCallback? onSuccess;

  const PatientIntakeForm({super.key, this.onSuccess});

  @override
  ConsumerState<PatientIntakeForm> createState() => _PatientIntakeFormState();
}

class _PatientIntakeFormState extends ConsumerState<PatientIntakeForm> {
  final _formKey = GlobalKey<FormState>();

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      ref.read(patientIntakeProvider.notifier).submit().then((_) {
        if (mounted && ref.read(patientIntakeProvider).hasValue) {
          widget.onSuccess?.call();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final asyncState = ref.watch(patientIntakeProvider);
    final currentData = asyncState.value ?? PatientIntakeData();
    final theme = Theme.of(context);
    final layout = ref.watch(layoutProvider);

    final int halfSpan = (layout.totalColumns / 2).ceil();
    final int fullSpan = layout.totalColumns;

    return BaseForm(
      formKey: _formKey,
      title: 'Patient Intake',
      subtitle: 'Perform a comprehensive clinical intake for new patients.',
      onSubmit: _submit,
      submitText: 'Complete Intake',
      isLoading: asyncState.isLoading,
      isEnabled: currentData.firstName.isNotEmpty && 
                 currentData.lastName.isNotEmpty && 
                 currentData.email.isNotEmpty && 
                 currentData.isEmailAvailable == true,
      children: [
        if (asyncState.hasError)
          Padding(
            padding: EdgeInsets.only(bottom: 16.0 * layout.scaleFactor),
            child: Text(
              asyncState.error.toString(),
              style: TextStyle(color: theme.colorScheme.error),
            ),
          ),
        ResponsiveGridRow(
          spacing: 16 * layout.scaleFactor,
          runSpacing: 16 * layout.scaleFactor,
          children: [
            ResponsiveGridCol(
              span: layout.tier == ResolutionTier.mob ? fullSpan : halfSpan,
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'First Name',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                initialValue: currentData.firstName,
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
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                initialValue: currentData.lastName,
                onChanged: (val) => ref
                    .read(patientIntakeProvider.notifier)
                    .updateData(lastName: val),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Required' : null,
              ),
            ),
            ResponsiveGridCol(
              span: layout.tier == ResolutionTier.mob ? fullSpan : halfSpan,
              child: InkWell(
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: currentData.dateOfBirth ??
                        DateTime.now()
                            .subtract(const Duration(days: 365 * 30)),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (picked != null) {
                    ref
                        .read(patientIntakeProvider.notifier)
                        .updateData(dateOfBirth: picked);
                  }
                },
                child: IgnorePointer(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Date of Birth',
                      suffixIcon: const Icon(Icons.calendar_today),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    controller: TextEditingController(
                      text: currentData.dateOfBirth
                              ?.toLocal()
                              .toString()
                              .split(' ')[0] ??
                          '',
                    ),
                    validator: (value) =>
                        (currentData.dateOfBirth == null) ? 'Required' : null,
                  ),
                ),
              ),
            ),
            ResponsiveGridCol(
              span: layout.tier == ResolutionTier.mob ? fullSpan : halfSpan,
              child: DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Gender',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                initialValue: currentData.gender,
                items: ['Male', 'Female', 'Non-binary', 'Other']
                    .map((label) => DropdownMenuItem(
                          value: label,
                          child: Text(label),
                        ))
                    .toList(),
                onChanged: (val) => ref
                    .read(patientIntakeProvider.notifier)
                    .updateData(gender: val),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Required' : null,
              ),
            ),
            ResponsiveGridCol(
              span: fullSpan,
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Primary Email',
                  prefixIcon: const Icon(Icons.email),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  suffixIcon: currentData.isEmailAvailable == null
                      ? null
                      : currentData.isEmailAvailable!
                          ? const Icon(Icons.check_circle, color: Colors.green)
                          : const Icon(Icons.error, color: Colors.red),
                  helperText: currentData.isEmailAvailable == false
                      ? 'Email already registered'
                      : null,
                  helperStyle: const TextStyle(color: Colors.red),
                ),
                keyboardType: TextInputType.emailAddress,
                initialValue: currentData.email,
                onChanged: (val) => ref
                    .read(patientIntakeProvider.notifier)
                    .updateData(email: val),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Required';
                  if (!value.contains('@')) return 'Invalid email';
                  if (currentData.isEmailAvailable == false) return 'Email unavailable';
                  return null;
                },
              ),
            ),
            ResponsiveGridCol(
              span: fullSpan,
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Medical History',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                maxLines: 5,
                initialValue: currentData.details,
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
