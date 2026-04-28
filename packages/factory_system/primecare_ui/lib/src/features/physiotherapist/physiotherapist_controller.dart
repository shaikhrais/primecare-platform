import 'package:primecare_ui/src/shared/primecare_adapters.dart';
import 'package:primecare_ui/src/features/features_model.dart';

final physiotherapistControllerProvider =
    StateNotifierProvider<PhysiotherapistController, PhysiotherapistViewModel>((
      ref,
    ) {
      return PhysiotherapistController();
    });

class PhysiotherapistController
    extends StateNotifier<PhysiotherapistViewModel> {
  PhysiotherapistController() : super(PhysiotherapistViewModel.initial());
}
