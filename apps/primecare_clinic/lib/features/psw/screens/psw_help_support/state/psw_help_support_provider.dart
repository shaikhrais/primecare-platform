import 'package:flutter_riverpod/legacy.dart';
import '../models/psw_help_support_model.dart';

class PswHelpSupportNotifier extends StateNotifier<PswHelpSupportModel> {
  PswHelpSupportNotifier() : super(const PswHelpSupportModel(isLoading: true));

  Future<void> loadData() async {
    if (!mounted) return;
    state = state.copyWith(isLoading: true);
    try {
      // API794 is not mounted to this legacy provider. Fail closed instead of
      // publishing an empty result as a successful Help read.
      if (!mounted) return;
      state = state.copyWith(isLoading: false,
        errorMessage: 'Help reader unavailable: registered host binding required.');
    } catch (e) {
      if (!mounted) return;
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }
}

final psw_help_supportProvider = StateNotifierProvider<PswHelpSupportNotifier, PswHelpSupportModel>((ref) {
  return PswHelpSupportNotifier()..loadData();
});
