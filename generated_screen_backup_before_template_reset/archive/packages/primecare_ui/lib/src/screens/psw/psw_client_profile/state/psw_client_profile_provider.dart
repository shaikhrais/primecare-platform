import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/psw_client_profile_model.dart';

class PswClientProfileNotifier extends StateNotifier<PswClientProfileModel> {
  PswClientProfileNotifier() : super(const PswClientProfileModel(isLoading: true));

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

final psw_client_profileProvider = StateNotifierProvider<PswClientProfileNotifier, PswClientProfileModel>((ref) {
  return PswClientProfileNotifier()..loadData();
});
