import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/cfo_payroll_model.dart';

class CfoPayrollNotifier extends StateNotifier<CfoPayrollModel> {
  CfoPayrollNotifier() : super(const CfoPayrollModel(isLoading: true));

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

final cfo_payrollProvider = StateNotifierProvider<CfoPayrollNotifier, CfoPayrollModel>((ref) {
  return CfoPayrollNotifier()..loadData();
});
