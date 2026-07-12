import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/patient_billing_model.dart';

class PatientBillingNotifier extends StateNotifier<PatientBillingModel> {
  PatientBillingNotifier() : super(const PatientBillingModel(isLoading: true));

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

final patient_billingProvider = StateNotifierProvider<PatientBillingNotifier, PatientBillingModel>((ref) {
  return PatientBillingNotifier()..loadData();
});
