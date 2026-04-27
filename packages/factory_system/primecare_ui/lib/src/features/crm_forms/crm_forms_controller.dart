import 'package:primecare_ui/src/shared/primecare_adapters.dart' hide Result;
import 'crm_forms_model.dart';

final crmFormsControllerProvider = StateNotifierProvider<CrmFormsController, CrmFormsViewModel>((ref) {
  return CrmFormsController();
});

class CrmFormsController extends StateNotifier<CrmFormsViewModel> {
  CrmFormsController() : super(CrmFormsViewModel.initial());

  void selectForm(String form) {
    state = CrmFormsViewModel(
      availableForms: state.availableForms,
      selectedForm: form,
    );
  }
}
