import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/event_and_webinar_manager_model.dart';

class EventAndWebinarManagerNotifier extends StateNotifier<EventAndWebinarManagerModel> {
  EventAndWebinarManagerNotifier() : super(const EventAndWebinarManagerModel(isLoading: true));

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

final event_and_webinar_managerProvider = StateNotifierProvider<EventAndWebinarManagerNotifier, EventAndWebinarManagerModel>((ref) {
  return EventAndWebinarManagerNotifier()..loadData();
});
