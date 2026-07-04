import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/secure_message_center_model.dart';

class SecureMessageCenterNotifier extends StateNotifier<SecureMessageCenterModel> {
  SecureMessageCenterNotifier() : super(const SecureMessageCenterModel(isLoading: true));

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

final secure_message_centerProvider = StateNotifierProvider<SecureMessageCenterNotifier, SecureMessageCenterModel>((ref) {
  return SecureMessageCenterNotifier()..loadData();
});
