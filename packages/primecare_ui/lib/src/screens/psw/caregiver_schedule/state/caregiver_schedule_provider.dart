import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/caregiver_schedule_model.dart';

class CaregiverScheduleNotifier extends StateNotifier<CaregiverScheduleModel> {
  CaregiverScheduleNotifier() : super(const CaregiverScheduleModel(isLoading: true));

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

final caregiver_scheduleProvider = StateNotifierProvider<CaregiverScheduleNotifier, CaregiverScheduleModel>((ref) {
  return CaregiverScheduleNotifier()..loadData();
});
