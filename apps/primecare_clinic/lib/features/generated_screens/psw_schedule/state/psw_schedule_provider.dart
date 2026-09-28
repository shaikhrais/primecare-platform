import 'package:flutter_riverpod/legacy.dart';
import '../models/psw_schedule_model.dart';

class PswScheduleNotifier extends StateNotifier<PswScheduleModel> {
  PswScheduleNotifier() : super(const PswScheduleModel(isLoading: true));

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

final psw_scheduleProvider = StateNotifierProvider<PswScheduleNotifier, PswScheduleModel>((ref) {
  return PswScheduleNotifier()..loadData();
});
