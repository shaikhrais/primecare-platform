import 'package:flutter_riverpod/legacy.dart';
import '../models/family_member_care_updates_model.dart';

class FamilyMemberCareUpdatesNotifier extends StateNotifier<FamilyMemberCareUpdatesModel> {
  FamilyMemberCareUpdatesNotifier() : super(const FamilyMemberCareUpdatesModel(isLoading: true));

  Future<void> loadData() async {
    state = state.copyWith(isLoading: true);
    try {
      // TODO: Call API service
      state = state.copyWith(isLoading: false, data: const <String, dynamic>{});
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }
}

final family_member_care_updatesProvider = StateNotifierProvider<FamilyMemberCareUpdatesNotifier, FamilyMemberCareUpdatesModel>((ref) {
  return FamilyMemberCareUpdatesNotifier()..loadData();
});
