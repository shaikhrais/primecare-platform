import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/rn_messaging_model.dart';

class RnMessagingNotifier extends StateNotifier<RnMessagingModel> {
  RnMessagingNotifier() : super(const RnMessagingModel(isLoading: true));

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

final rn_messagingProvider = StateNotifierProvider<RnMessagingNotifier, RnMessagingModel>((ref) {
  return RnMessagingNotifier()..loadData();
});
