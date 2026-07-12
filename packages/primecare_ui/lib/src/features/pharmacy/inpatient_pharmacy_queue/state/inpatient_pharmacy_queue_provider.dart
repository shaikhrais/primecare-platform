import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/inpatient_pharmacy_queue_model.dart';

class InpatientPharmacyQueueNotifier extends StateNotifier<InpatientPharmacyQueueModel> {
  InpatientPharmacyQueueNotifier() : super(const InpatientPharmacyQueueModel(isLoading: true));

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

final inpatient_pharmacy_queueProvider = StateNotifierProvider<InpatientPharmacyQueueNotifier, InpatientPharmacyQueueModel>((ref) {
  return InpatientPharmacyQueueNotifier()..loadData();
});
