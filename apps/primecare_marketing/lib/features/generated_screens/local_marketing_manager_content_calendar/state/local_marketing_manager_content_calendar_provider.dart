import 'package:flutter_riverpod/legacy.dart';
import '../models/local_marketing_manager_content_calendar_model.dart';

class LocalMarketingManagerContentCalendarNotifier extends StateNotifier<LocalMarketingManagerContentCalendarModel> {
  LocalMarketingManagerContentCalendarNotifier() : super(const LocalMarketingManagerContentCalendarModel(isLoading: true));

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

final local_marketing_manager_content_calendarProvider = StateNotifierProvider<LocalMarketingManagerContentCalendarNotifier, LocalMarketingManagerContentCalendarModel>((ref) {
  return LocalMarketingManagerContentCalendarNotifier()..loadData();
});
