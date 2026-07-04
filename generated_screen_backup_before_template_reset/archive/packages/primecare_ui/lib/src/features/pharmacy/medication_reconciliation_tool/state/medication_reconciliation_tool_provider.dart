import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/medication_reconciliation_tool_model.dart';

class MedicationReconciliationToolNotifier extends StateNotifier<MedicationReconciliationToolModel> {
  MedicationReconciliationToolNotifier() : super(const MedicationReconciliationToolModel(isLoading: true));

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

final medication_reconciliation_toolProvider = StateNotifierProvider<MedicationReconciliationToolNotifier, MedicationReconciliationToolModel>((ref) {
  return MedicationReconciliationToolNotifier()..loadData();
});
