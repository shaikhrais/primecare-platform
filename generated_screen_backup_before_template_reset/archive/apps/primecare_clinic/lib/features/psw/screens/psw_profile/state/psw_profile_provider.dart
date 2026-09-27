import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/psw_profile_model.dart';

class PswProfileNotifier extends StateNotifier<PswProfileModel> {
  PswProfileNotifier() : super(const PswProfileModel(isLoading: true));

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

final psw_profileProvider = StateNotifierProvider<PswProfileNotifier, PswProfileModel>((ref) {
  return PswProfileNotifier()..loadData();
});
