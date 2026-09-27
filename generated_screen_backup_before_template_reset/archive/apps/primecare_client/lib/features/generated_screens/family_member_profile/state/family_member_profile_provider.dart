import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/family_member_profile_model.dart';

class FamilyMemberProfileNotifier extends StateNotifier<FamilyMemberProfileModel> {
  FamilyMemberProfileNotifier() : super(const FamilyMemberProfileModel(isLoading: true));

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

final family_member_profileProvider = StateNotifierProvider<FamilyMemberProfileNotifier, FamilyMemberProfileModel>((ref) {
  return FamilyMemberProfileNotifier()..loadData();
});
