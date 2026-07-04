import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/psw_help_support_model.dart';

class PswHelpSupportNotifier extends StateNotifier<PswHelpSupportModel> {
  PswHelpSupportNotifier() : super(const PswHelpSupportModel(isLoading: true));

  Future<void> loadData() async {
    state = state.copyWith(isLoading: true);
    try {
      // TODO: Call API service
      state = state.copyWith(isLoading: false, data: const {});
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }
}

final psw_help_supportProvider = StateNotifierProvider<PswHelpSupportNotifier, PswHelpSupportModel>((ref) {
  return PswHelpSupportNotifier()..loadData();
});
