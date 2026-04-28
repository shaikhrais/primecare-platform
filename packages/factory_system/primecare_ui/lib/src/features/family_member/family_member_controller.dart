import 'package:primecare_ui/src/shared/primecare_adapters.dart';
import 'package:primecare_ui/src/features/features_model.dart';

final familyMemberControllerProvider =
    StateNotifierProvider<FamilyMemberController, FamilyMemberViewModel>((ref) {
      return FamilyMemberController();
    });

class FamilyMemberController extends StateNotifier<FamilyMemberViewModel> {
  FamilyMemberController() : super(FamilyMemberViewModel.initial());
}
