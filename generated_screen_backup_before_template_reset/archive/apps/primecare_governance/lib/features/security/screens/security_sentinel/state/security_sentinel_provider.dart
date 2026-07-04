import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/security_sentinel_model.dart';

class SecuritySentinelNotifier extends StateNotifier<SecuritySentinelModel> {
  SecuritySentinelNotifier() : super(const SecuritySentinelModel(isLoading: true));

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

final security_sentinelProvider = StateNotifierProvider<SecuritySentinelNotifier, SecuritySentinelModel>((ref) {
  return SecuritySentinelNotifier()..loadData();
});
