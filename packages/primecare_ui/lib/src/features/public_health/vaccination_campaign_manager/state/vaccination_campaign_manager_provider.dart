import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/vaccination_campaign_manager_model.dart';

class VaccinationCampaignManagerNotifier extends StateNotifier<VaccinationCampaignManagerModel> {
  VaccinationCampaignManagerNotifier() : super(const VaccinationCampaignManagerModel(isLoading: true));

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

final vaccination_campaign_managerProvider = StateNotifierProvider<VaccinationCampaignManagerNotifier, VaccinationCampaignManagerModel>((ref) {
  return VaccinationCampaignManagerNotifier()..loadData();
});
