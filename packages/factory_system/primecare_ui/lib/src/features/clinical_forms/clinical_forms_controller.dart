import 'dart:async';
import 'package:primecare_ui/src/shared/primecare_adapters.dart';
import 'package:primecare_ui/src/features/features_model.dart';

final clinicalFormsControllerProvider =
    StateNotifierProvider<ClinicalFormsController, ClinicalFormsViewModel>((
      ref,
    ) {
      return ClinicalFormsController();
    });

class ClinicalFormsController extends StateNotifier<ClinicalFormsViewModel> {
  ClinicalFormsController() : super(ClinicalFormsViewModel.initial());

  void selectForm(String form) {
    state = state.copyWith(selectedForm: form);
  }

  Future<void> submitForm(Map<String, dynamic> data) async {
    state = state.copyWith(isSubmitting: true);
    await Future<void>.delayed(const Duration(seconds: 1));
    state = state.copyWith(isSubmitting: false);
  }
}
