import 'package:primecare_ui/src/shared/primecare_adapters.dart'
    hide FranchiseOwnerViewModel;
import 'package:primecare_ui/src/features/features_model.dart';

final franchiseOwnerControllerProvider =
    StateNotifierProvider<FranchiseOwnerController, FranchiseOwnerViewModel>((
      ref,
    ) {
      return FranchiseOwnerController();
    });

class FranchiseOwnerController extends StateNotifier<FranchiseOwnerViewModel> {
  FranchiseOwnerController() : super(FranchiseOwnerViewModel.initial());
}
