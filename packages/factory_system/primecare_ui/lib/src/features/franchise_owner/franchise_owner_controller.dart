import 'package:primecare_ui/src/shared/primecare_adapters.dart' hide Result;
import 'franchise_owner_model.dart';

final franchiseOwnerControllerProvider = StateNotifierProvider<FranchiseOwnerController, FranchiseOwnerViewModel>((ref) {
  return FranchiseOwnerController();
});

class FranchiseOwnerController extends StateNotifier<FranchiseOwnerViewModel> {
  FranchiseOwnerController() : super(FranchiseOwnerViewModel.initial());
}
