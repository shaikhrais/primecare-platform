import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/applicant_tracking_model.dart';

class ApplicantTrackingNotifier extends StateNotifier<ApplicantTrackingModel> {
  ApplicantTrackingNotifier() : super(const ApplicantTrackingModel(isLoading: true));

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

final applicant_trackingProvider = StateNotifierProvider<ApplicantTrackingNotifier, ApplicantTrackingModel>((ref) {
  return ApplicantTrackingNotifier()..loadData();
});
