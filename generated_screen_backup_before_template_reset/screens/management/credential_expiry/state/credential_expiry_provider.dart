import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/credential_expiry_model.dart';

class CredentialExpiryNotifier extends StateNotifier<CredentialExpiryModel> {
  CredentialExpiryNotifier() : super(const CredentialExpiryModel(isLoading: true));

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

final credential_expiryProvider = StateNotifierProvider<CredentialExpiryNotifier, CredentialExpiryModel>((ref) {
  return CredentialExpiryNotifier()..loadData();
});
