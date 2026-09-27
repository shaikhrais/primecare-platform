import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/psw_notifications_model.dart';

class PswNotificationsNotifier extends StateNotifier<PswNotificationsModel> {
  PswNotificationsNotifier() : super(const PswNotificationsModel(isLoading: true));

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

final psw_notificationsProvider = StateNotifierProvider<PswNotificationsNotifier, PswNotificationsModel>((ref) {
  return PswNotificationsNotifier()..loadData();
});
