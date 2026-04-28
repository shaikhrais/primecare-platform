import 'dart:async';
import 'package:primecare_ui/src/shared/primecare_adapters.dart';
import 'package:primecare_ui/src/features/features_model.dart';

final hrFormsControllerProvider =
    StateNotifierProvider<HrFormsController, HrFormsViewModel>((ref) {
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
    await Future<void>.delayed(const Duration(seconds: 1));
    state = state.copyWith(isSubmitting: false);
  }
}
