import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/resolution_tracking_model.dart';

class ResolutionTrackingNotifier extends StateNotifier<ResolutionTrackingModel> {
  ResolutionTrackingNotifier() : super(const ResolutionTrackingModel(isLoading: true));

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

final resolution_trackingProvider = StateNotifierProvider<ResolutionTrackingNotifier, ResolutionTrackingModel>((ref) {
  return ResolutionTrackingNotifier()..loadData();
});
