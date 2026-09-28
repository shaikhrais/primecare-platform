import 'package:flutter_riverpod/legacy.dart';
import '../models/family_member_loved_one_schedule_model.dart';

class FamilyMemberLovedOneScheduleNotifier extends StateNotifier<FamilyMemberLovedOneScheduleModel> {
  FamilyMemberLovedOneScheduleNotifier() : super(const FamilyMemberLovedOneScheduleModel(isLoading: true));

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

final family_member_loved_one_scheduleProvider = StateNotifierProvider<FamilyMemberLovedOneScheduleNotifier, FamilyMemberLovedOneScheduleModel>((ref) {
  return FamilyMemberLovedOneScheduleNotifier()..loadData();
});
