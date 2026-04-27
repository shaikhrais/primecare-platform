import 'package:primecare_ui/src/shared/primecare_adapters.dart' hide Result;
import 'common_forms_model.dart';

final commonFormsControllerProvider = StateNotifierProvider<CommonFormsController, CommonFormsViewModel>((ref) {
  return CommonFormsController();
});

class CommonFormsController extends StateNotifier<CommonFormsViewModel> {
  CommonFormsController() : super(CommonFormsViewModel.initial());

  void selectForm(String form) {
    state = CommonFormsViewModel(
      availableForms: state.availableForms,
      selectedForm: form,
    );
  }
}
