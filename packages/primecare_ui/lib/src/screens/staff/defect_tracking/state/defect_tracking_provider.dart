import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/defect_tracking_model.dart';

class DefectTrackingNotifier extends StateNotifier<DefectTrackingModel> {
  DefectTrackingNotifier() : super(const DefectTrackingModel(isLoading: true));

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

final defect_trackingProvider = StateNotifierProvider<DefectTrackingNotifier, DefectTrackingModel>((ref) {
  return DefectTrackingNotifier()..loadData();
});
