import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/informed_consent_tracker_model.dart';

class InformedConsentTrackerNotifier extends StateNotifier<InformedConsentTrackerModel> {
  InformedConsentTrackerNotifier() : super(const InformedConsentTrackerModel(isLoading: true));

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

final informed_consent_trackerProvider = StateNotifierProvider<InformedConsentTrackerNotifier, InformedConsentTrackerModel>((ref) {
  return InformedConsentTrackerNotifier()..loadData();
});
