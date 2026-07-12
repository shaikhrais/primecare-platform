import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/chiropractic_progress_tracking_model.dart';

class ChiropracticProgressTrackingNotifier extends StateNotifier<ChiropracticProgressTrackingModel> {
  ChiropracticProgressTrackingNotifier() : super(const ChiropracticProgressTrackingModel(isLoading: true));

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

final chiropractic_progress_trackingProvider = StateNotifierProvider<ChiropracticProgressTrackingNotifier, ChiropracticProgressTrackingModel>((ref) {
  return ChiropracticProgressTrackingNotifier()..loadData();
});
