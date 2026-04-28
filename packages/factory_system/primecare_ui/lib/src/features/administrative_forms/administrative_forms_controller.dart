import 'dart:async';
import 'package:primecare_ui/src/shared/primecare_adapters.dart';
import 'package:primecare_ui/src/features/features_model.dart';

final administrativeFormsControllerProvider =
    StateNotifierProvider<
      AdministrativeFormsController,
      AdministrativeFormsViewModel
    >((ref) {
      return AdministrativeFormsController();
    });

class AdministrativeFormsController
    extends StateNotifier<AdministrativeFormsViewModel> {
  AdministrativeFormsController()
    : super(AdministrativeFormsViewModel.initial());

  void selectForm(String form) {
    state = state.copyWith(selectedForm: form);
  }

  Future<void> approveForm(String formId) async {
    state = state.copyWith(isSubmitting: true);
    await Future<void>.delayed(const Duration(seconds: 1));
    state = state.copyWith(isSubmitting: false);
  }
}
