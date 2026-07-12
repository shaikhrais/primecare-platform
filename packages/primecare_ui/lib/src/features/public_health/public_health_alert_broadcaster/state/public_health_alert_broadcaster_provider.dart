import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/public_health_alert_broadcaster_model.dart';

class PublicHealthAlertBroadcasterNotifier extends StateNotifier<PublicHealthAlertBroadcasterModel> {
  PublicHealthAlertBroadcasterNotifier() : super(const PublicHealthAlertBroadcasterModel(isLoading: true));

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

final public_health_alert_broadcasterProvider = StateNotifierProvider<PublicHealthAlertBroadcasterNotifier, PublicHealthAlertBroadcasterModel>((ref) {
  return PublicHealthAlertBroadcasterNotifier()..loadData();
});
