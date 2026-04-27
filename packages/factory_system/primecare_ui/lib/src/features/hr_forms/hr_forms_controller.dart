import 'package:primecare_ui/src/shared/primecare_adapters.dart' hide Result;
import 'hr_forms_model.dart';

final hrFormsControllerProvider = StateNotifierProvider<HrFormsController, HrFormsViewModel>((ref) {
  return HrFormsController();
});

class HrFormsController extends StateNotifier<HrFormsViewModel> {
  HrFormsController() : super(HrFormsViewModel.initial());

  void selectForm(String form) {
    state = state.copyWith(selectedForm: form);
  }

  Future<void> submitForm(Map<String, dynamic> data) async {
    state = state.copyWith(isSubmitting: true);
    // Simulation of form submission
    await Future.delayed(const Duration(seconds: 1));
    state = state.copyWith(isSubmitting: false);
  }
}
