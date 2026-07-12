import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/payroll_model.dart';

class PayrollNotifier extends StateNotifier<PayrollModel> {
  PayrollNotifier() : super(const PayrollModel(isLoading: true));

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

final payrollProvider = StateNotifierProvider<PayrollNotifier, PayrollModel>((ref) {
  return PayrollNotifier()..loadData();
});
