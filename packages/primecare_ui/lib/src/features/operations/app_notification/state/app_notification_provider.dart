import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/app_notification_model.dart';

class AppNotificationNotifier extends StateNotifier<AppNotificationModel> {
  AppNotificationNotifier() : super(const AppNotificationModel(isLoading: true));

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

final app_notificationProvider = StateNotifierProvider<AppNotificationNotifier, AppNotificationModel>((ref) {
  return AppNotificationNotifier()..loadData();
});
