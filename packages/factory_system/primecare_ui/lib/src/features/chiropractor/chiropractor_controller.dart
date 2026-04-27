import 'package:primecare_ui/src/shared/primecare_adapters.dart' hide Result;
import 'chiropractor_model.dart';

final chiropractorControllerProvider = StateNotifierProvider<ChiropractorController, ChiropractorViewModel>((ref) {
  return ChiropractorController();
});

class ChiropractorController extends StateNotifier<ChiropractorViewModel> {
  ChiropractorController() : super(ChiropractorViewModel.initial());
}
