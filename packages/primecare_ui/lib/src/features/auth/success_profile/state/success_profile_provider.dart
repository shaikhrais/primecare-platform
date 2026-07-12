import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/success_profile_model.dart';

class SuccessProfileNotifier extends StateNotifier<SuccessProfileModel> {
  SuccessProfileNotifier() : super(const SuccessProfileModel(isLoading: true));

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

final success_profileProvider = StateNotifierProvider<SuccessProfileNotifier, SuccessProfileModel>((ref) {
  return SuccessProfileNotifier()..loadData();
});
