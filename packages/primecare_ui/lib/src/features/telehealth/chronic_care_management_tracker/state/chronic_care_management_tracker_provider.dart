import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/chronic_care_management_tracker_model.dart';

class ChronicCareManagementTrackerNotifier extends StateNotifier<ChronicCareManagementTrackerModel> {
  ChronicCareManagementTrackerNotifier() : super(const ChronicCareManagementTrackerModel(isLoading: true));

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

final chronic_care_management_trackerProvider = StateNotifierProvider<ChronicCareManagementTrackerNotifier, ChronicCareManagementTrackerModel>((ref) {
  return ChronicCareManagementTrackerNotifier()..loadData();
});
