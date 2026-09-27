import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/certification_tracking_model.dart';

class CertificationTrackingNotifier extends StateNotifier<CertificationTrackingModel> {
  CertificationTrackingNotifier() : super(const CertificationTrackingModel(isLoading: true));

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

final certification_trackingProvider = StateNotifierProvider<CertificationTrackingNotifier, CertificationTrackingModel>((ref) {
  return CertificationTrackingNotifier()..loadData();
});
