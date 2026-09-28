import 'package:flutter_riverpod/legacy.dart';
import '../models/cto_verification_hub_model.dart';

class CtoVerificationHubNotifier extends StateNotifier<CtoVerificationHubModel> {
  CtoVerificationHubNotifier() : super(const CtoVerificationHubModel(isLoading: true));

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

final cto_verification_hubProvider = StateNotifierProvider<CtoVerificationHubNotifier, CtoVerificationHubModel>((ref) {
  return CtoVerificationHubNotifier()..loadData();
});
