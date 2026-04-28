import 'package:primecare_ui/src/shared/primecare_adapters.dart';
import 'package:primecare_ui/src/features/features_model.dart';

final chiropractorControllerProvider =
    StateNotifierProvider<ChiropractorController, ChiropractorViewModel>((ref) {
      return ChiropractorController();
    });

class ChiropractorController extends StateNotifier<ChiropractorViewModel> {
  ChiropractorController() : super(ChiropractorViewModel.initial());
}
