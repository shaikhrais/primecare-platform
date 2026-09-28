import 'package:flutter_riverpod/legacy.dart';
import '../models/family_loved_one_schedule_model.dart';

class FamilyLovedOneScheduleNotifier extends StateNotifier<FamilyLovedOneScheduleModel> {
  FamilyLovedOneScheduleNotifier() : super(const FamilyLovedOneScheduleModel(isLoading: true));

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

final family_loved_one_scheduleProvider = StateNotifierProvider<FamilyLovedOneScheduleNotifier, FamilyLovedOneScheduleModel>((ref) {
  return FamilyLovedOneScheduleNotifier()..loadData();
});
