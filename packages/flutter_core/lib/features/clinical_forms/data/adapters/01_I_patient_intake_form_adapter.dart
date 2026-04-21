// Layer: 01_INFRASTRUCTURE
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/02_M_patient_intake_form_view_model.dart';
import '../mappers/03_D_patient_intake_form_mapper.dart';

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
