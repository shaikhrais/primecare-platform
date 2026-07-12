import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/hr_director_credential_expiry_model.dart';

class HrDirectorCredentialExpiryNotifier extends StateNotifier<HrDirectorCredentialExpiryModel> {
  HrDirectorCredentialExpiryNotifier() : super(const HrDirectorCredentialExpiryModel(isLoading: true));

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

final hr_director_credential_expiryProvider = StateNotifierProvider<HrDirectorCredentialExpiryNotifier, HrDirectorCredentialExpiryModel>((ref) {
  return HrDirectorCredentialExpiryNotifier()..loadData();
});
