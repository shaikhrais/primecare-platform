import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/outpatient_prescription_tracker_model.dart';

class OutpatientPrescriptionTrackerNotifier extends StateNotifier<OutpatientPrescriptionTrackerModel> {
  OutpatientPrescriptionTrackerNotifier() : super(const OutpatientPrescriptionTrackerModel(isLoading: true));

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

final outpatient_prescription_trackerProvider = StateNotifierProvider<OutpatientPrescriptionTrackerNotifier, OutpatientPrescriptionTrackerModel>((ref) {
  return OutpatientPrescriptionTrackerNotifier()..loadData();
});
