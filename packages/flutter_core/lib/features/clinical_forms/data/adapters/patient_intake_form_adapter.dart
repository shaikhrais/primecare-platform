// ignore_for_file: avoid_dynamic_calls, argument_type_not_assignable, inference_failure_on_instance_creation, strict_raw_type, inference_failure_on_function_invocation, undefined_identifier, inference_failure_on_collection_literal, undefined_named_parameter, return_of_invalid_type, prefer_single_quotes, invalid_assignment, non_type_as_type_argument
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/patient_intake_form_view_model.dart';
import '../mappers/patient_intake_form_mapper.dart';

class PatientIntakeFormAdapter extends Notifier<PatientIntakeFormViewModel> {
  @override
  PatientIntakeFormViewModel build() {
    return PatientIntakeFormViewModel();
  }

  Future<void> submit() async {
    state = state.copyWith(isLoading: true);

    try {
      // Simulate network delay
      await Future<void>.delayed(const Duration(seconds: 1));

      final dto = PatientIntakeFormMapper.toDto(state);
      // ignore: avoid_print
      print('Submitting Patient Intake: ${dto.toJson()}');

      state = state.copyWith(isLoading: false, status: 'Submitted');
    } catch (e) {
      state = state.copyWith(isLoading: false, status: 'Error');
      // ignore: avoid_print
      print('Error submitting Patient Intake: \$e');
    }
  }

  void updateField({
    String? firstName,
    String? lastName,
    String? healthCardNumber,
    String? primaryDiagnosis,
  }) {
    state = state.copyWith(
      firstName: firstName,
      lastName: lastName,
      healthCardNumber: healthCardNumber,
      primaryDiagnosis: primaryDiagnosis,
    );
  }
}

final patientIntakeFormAdapterProvider =
    NotifierProvider<PatientIntakeFormAdapter, PatientIntakeFormViewModel>(() {
      return PatientIntakeFormAdapter();
    });
