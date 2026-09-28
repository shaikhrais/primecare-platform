import 'package:flutter_riverpod/legacy.dart';
import '../models/security_hub_model.dart';

class SecurityHubNotifier extends StateNotifier<SecurityHubModel> {
  SecurityHubNotifier() : super(const SecurityHubModel(isLoading: true));

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

final security_hubProvider = StateNotifierProvider<SecurityHubNotifier, SecurityHubModel>((ref) {
  return SecurityHubNotifier()..loadData();
});
