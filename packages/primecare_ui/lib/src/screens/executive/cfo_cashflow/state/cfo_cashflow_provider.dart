import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/cfo_cashflow_model.dart';

class CfoCashflowNotifier extends StateNotifier<CfoCashflowModel> {
  CfoCashflowNotifier() : super(const CfoCashflowModel(isLoading: true));

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

final cfo_cashflowProvider = StateNotifierProvider<CfoCashflowNotifier, CfoCashflowModel>((ref) {
  return CfoCashflowNotifier()..loadData();
});
