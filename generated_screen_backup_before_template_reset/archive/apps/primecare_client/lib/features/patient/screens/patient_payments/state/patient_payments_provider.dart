import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/patient_payments_model.dart';

class PatientPaymentsNotifier extends StateNotifier<PatientPaymentsModel> {
  PatientPaymentsNotifier() : super(const PatientPaymentsModel(isLoading: true));

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

final patient_paymentsProvider = StateNotifierProvider<PatientPaymentsNotifier, PatientPaymentsModel>((ref) {
  return PatientPaymentsNotifier()..loadData();
});
