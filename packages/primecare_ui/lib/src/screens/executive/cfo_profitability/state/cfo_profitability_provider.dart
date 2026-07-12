import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/cfo_profitability_model.dart';

class CfoProfitabilityNotifier extends StateNotifier<CfoProfitabilityModel> {
  CfoProfitabilityNotifier() : super(const CfoProfitabilityModel(isLoading: true));

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

final cfo_profitabilityProvider = StateNotifierProvider<CfoProfitabilityNotifier, CfoProfitabilityModel>((ref) {
  return CfoProfitabilityNotifier()..loadData();
});
