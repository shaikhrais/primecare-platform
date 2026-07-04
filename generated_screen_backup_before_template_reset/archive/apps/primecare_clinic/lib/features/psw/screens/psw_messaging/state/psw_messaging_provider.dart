import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/psw_messaging_model.dart';

class PswMessagingNotifier extends StateNotifier<PswMessagingModel> {
  PswMessagingNotifier() : super(const PswMessagingModel(isLoading: true));

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

final psw_messagingProvider = StateNotifierProvider<PswMessagingNotifier, PswMessagingModel>((ref) {
  return PswMessagingNotifier()..loadData();
});
