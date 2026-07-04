import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/family_profile_model.dart';

class FamilyProfileNotifier extends StateNotifier<FamilyProfileModel> {
  FamilyProfileNotifier() : super(const FamilyProfileModel(isLoading: true));

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

final family_profileProvider = StateNotifierProvider<FamilyProfileNotifier, FamilyProfileModel>((ref) {
  return FamilyProfileNotifier()..loadData();
});
