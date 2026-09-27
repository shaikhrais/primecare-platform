import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/vitals_tracking_model.dart';

class VitalsTrackingNotifier extends StateNotifier<VitalsTrackingModel> {
  VitalsTrackingNotifier() : super(const VitalsTrackingModel(isLoading: true));

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

final vitals_trackingProvider = StateNotifierProvider<VitalsTrackingNotifier, VitalsTrackingModel>((ref) {
  return VitalsTrackingNotifier()..loadData();
});
