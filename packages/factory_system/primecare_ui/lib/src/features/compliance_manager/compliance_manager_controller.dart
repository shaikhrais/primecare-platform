import 'package:primecare_ui/src/shared/primecare_adapters.dart' hide Result;
import 'compliance_manager_model.dart';

final complianceManagerControllerProvider = StateNotifierProvider<ComplianceManagerController, ComplianceManagerViewModel>((ref) {
  return ComplianceManagerController();
});

class ComplianceManagerController extends StateNotifier<ComplianceManagerViewModel> {
  ComplianceManagerController() : super(ComplianceManagerViewModel.initial());
}
