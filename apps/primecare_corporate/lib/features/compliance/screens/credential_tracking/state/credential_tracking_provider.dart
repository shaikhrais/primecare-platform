import 'package:flutter_riverpod/legacy.dart';
import '../models/credential_tracking_model.dart';

class CredentialTrackingNotifier extends StateNotifier<CredentialTrackingModel> {
  CredentialTrackingNotifier() : super(const CredentialTrackingModel(isLoading: true));

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

final credential_trackingProvider = StateNotifierProvider<CredentialTrackingNotifier, CredentialTrackingModel>((ref) {
  return CredentialTrackingNotifier()..loadData();
});
