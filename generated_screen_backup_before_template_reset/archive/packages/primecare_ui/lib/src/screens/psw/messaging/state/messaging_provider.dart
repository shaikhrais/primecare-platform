import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/messaging_model.dart';

class MessagingNotifier extends StateNotifier<MessagingModel> {
  MessagingNotifier() : super(const MessagingModel(isLoading: true));

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

final messagingProvider = StateNotifierProvider<MessagingNotifier, MessagingModel>((ref) {
  return MessagingNotifier()..loadData();
});
