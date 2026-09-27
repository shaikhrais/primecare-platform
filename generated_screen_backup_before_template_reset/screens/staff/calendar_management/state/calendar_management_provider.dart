import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/calendar_management_model.dart';

class CalendarManagementNotifier extends StateNotifier<CalendarManagementModel> {
  CalendarManagementNotifier() : super(const CalendarManagementModel(isLoading: true));

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

final calendar_managementProvider = StateNotifierProvider<CalendarManagementNotifier, CalendarManagementModel>((ref) {
  return CalendarManagementNotifier()..loadData();
});
