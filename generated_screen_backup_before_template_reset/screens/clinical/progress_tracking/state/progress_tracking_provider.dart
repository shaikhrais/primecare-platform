import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/progress_tracking_model.dart';

class ProgressTrackingNotifier extends StateNotifier<ProgressTrackingModel> {
  ProgressTrackingNotifier() : super(const ProgressTrackingModel(isLoading: true));

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

final progress_trackingProvider = StateNotifierProvider<ProgressTrackingNotifier, ProgressTrackingModel>((ref) {
  return ProgressTrackingNotifier()..loadData();
});
