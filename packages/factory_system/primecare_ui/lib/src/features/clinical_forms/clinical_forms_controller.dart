import 'package:primecare_ui/src/shared/primecare_adapters.dart' hide Result;
import 'clinical_forms_model.dart';

final clinicalFormsControllerProvider = StateNotifierProvider<ClinicalFormsController, ClinicalFormsViewModel>((ref) {
  return ClinicalFormsController();
});

class ClinicalFormsController extends StateNotifier<ClinicalFormsViewModel> {
  ClinicalFormsController() : super(ClinicalFormsViewModel.initial());

  void selectForm(String form) {
    state = state.copyWith(selectedForm: form);
  }

  Future<void> submitForm(Map<String, dynamic> data) async {
    state = state.copyWith(isSubmitting: true);
    await Future.delayed(const Duration(seconds: 1));
    state = state.copyWith(isSubmitting: false);
  }
}
