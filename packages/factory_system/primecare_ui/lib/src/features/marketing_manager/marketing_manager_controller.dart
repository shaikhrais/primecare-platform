import 'package:primecare_ui/src/shared/primecare_adapters.dart' hide Result;
import 'marketing_manager_model.dart';

final marketingManagerControllerProvider = StateNotifierProvider<MarketingManagerController, MarketingManagerViewModel>((ref) {
  return MarketingManagerController();
});

class MarketingManagerController extends StateNotifier<MarketingManagerViewModel> {
  MarketingManagerController() : super(MarketingManagerViewModel.initial());
}
