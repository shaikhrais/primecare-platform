import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/regional_bdm_deal_tracker_model.dart';

class RegionalBdmDealTrackerNotifier extends StateNotifier<RegionalBdmDealTrackerModel> {
  RegionalBdmDealTrackerNotifier() : super(const RegionalBdmDealTrackerModel(isLoading: true));

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

final regional_bdm_deal_trackerProvider = StateNotifierProvider<RegionalBdmDealTrackerNotifier, RegionalBdmDealTrackerModel>((ref) {
  return RegionalBdmDealTrackerNotifier()..loadData();
});
