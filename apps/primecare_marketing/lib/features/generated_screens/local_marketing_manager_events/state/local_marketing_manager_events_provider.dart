import 'package:flutter_riverpod/legacy.dart';
import '../models/local_marketing_manager_events_model.dart';

class LocalMarketingManagerEventsNotifier extends StateNotifier<LocalMarketingManagerEventsModel> {
  LocalMarketingManagerEventsNotifier() : super(const LocalMarketingManagerEventsModel(isLoading: true));

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

final local_marketing_manager_eventsProvider = StateNotifierProvider<LocalMarketingManagerEventsNotifier, LocalMarketingManagerEventsModel>((ref) {
  return LocalMarketingManagerEventsNotifier()..loadData();
});
