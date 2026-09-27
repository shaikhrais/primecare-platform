import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/caregiver_client_profile_model.dart';

class CaregiverClientProfileNotifier extends StateNotifier<CaregiverClientProfileModel> {
  CaregiverClientProfileNotifier() : super(const CaregiverClientProfileModel(isLoading: true));

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

final caregiver_client_profileProvider = StateNotifierProvider<CaregiverClientProfileNotifier, CaregiverClientProfileModel>((ref) {
  return CaregiverClientProfileNotifier()..loadData();
});
