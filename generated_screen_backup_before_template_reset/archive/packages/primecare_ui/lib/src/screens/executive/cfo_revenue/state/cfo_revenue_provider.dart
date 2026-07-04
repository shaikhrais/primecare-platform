import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/cfo_revenue_model.dart';

class CfoRevenueNotifier extends StateNotifier<CfoRevenueModel> {
  CfoRevenueNotifier() : super(const CfoRevenueModel(isLoading: true));

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

final cfo_revenueProvider = StateNotifierProvider<CfoRevenueNotifier, CfoRevenueModel>((ref) {
  return CfoRevenueNotifier()..loadData();
});
