import 'package:primecare_ui/src/shared/primecare_adapters.dart';
import 'package:primecare_ui/src/features/features_model.dart';

final financialFormsControllerProvider =
    StateNotifierProvider<FinancialFormsController, FinancialFormsViewModel>((
      ref,
    ) {
      return FinancialFormsController();
    });

class FinancialFormsController extends StateNotifier<FinancialFormsViewModel> {
  FinancialFormsController() : super(FinancialFormsViewModel.initial());

  void selectForm(String form) {
    state = FinancialFormsViewModel(
      availableForms: state.availableForms,
      selectedForm: form,
    );
  }
}
