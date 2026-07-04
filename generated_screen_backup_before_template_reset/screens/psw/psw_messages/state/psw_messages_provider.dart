import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/psw_messages_model.dart';

class PswMessagesNotifier extends StateNotifier<PswMessagesModel> {
  PswMessagesNotifier() : super(const PswMessagesModel(isLoading: true));

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

final psw_messagesProvider = StateNotifierProvider<PswMessagesNotifier, PswMessagesModel>((ref) {
  return PswMessagesNotifier()..loadData();
});
