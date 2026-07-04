import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/message_archiveer_model.dart';

class MessageArchiveerNotifier extends StateNotifier<MessageArchiveerModel> {
  MessageArchiveerNotifier() : super(const MessageArchiveerModel(isLoading: true));

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

final message_archiveerProvider = StateNotifierProvider<MessageArchiveerNotifier, MessageArchiveerModel>((ref) {
  return MessageArchiveerNotifier()..loadData();
});
