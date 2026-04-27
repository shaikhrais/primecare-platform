import 'package:primecare_ui/src/shared/primecare_adapters.dart' hide Result;
import 'administrative_forms_model.dart';

final administrativeFormsControllerProvider = StateNotifierProvider<AdministrativeFormsController, AdministrativeFormsViewModel>((ref) {
  return AdministrativeFormsController();
});

class AdministrativeFormsController extends StateNotifier<AdministrativeFormsViewModel> {
  AdministrativeFormsController() : super(AdministrativeFormsViewModel.initial());

  void selectForm(String form) {
    state = state.copyWith(selectedForm: form);
  }

  Future<void> approveForm(String formId) async {
    state = state.copyWith(isSubmitting: true);
    await Future.delayed(const Duration(seconds: 1));
    state = state.copyWith(isSubmitting: false);
  }
}
