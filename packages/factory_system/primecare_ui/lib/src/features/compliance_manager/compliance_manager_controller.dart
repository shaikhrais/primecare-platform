import 'package:primecare_ui/src/shared/primecare_adapters.dart';
import 'package:primecare_ui/src/features/features_model.dart';

final complianceManagerControllerProvider =
    StateNotifierProvider<
      ComplianceManagerController,
      ComplianceManagerViewModel
    >((ref) {
      return ComplianceManagerController();
    });

class ComplianceManagerController
    extends StateNotifier<ComplianceManagerViewModel> {
  ComplianceManagerController() : super(ComplianceManagerViewModel.initial());
}
