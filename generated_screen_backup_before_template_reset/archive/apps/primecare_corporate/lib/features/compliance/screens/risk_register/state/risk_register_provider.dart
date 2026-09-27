import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/risk_register_model.dart';

class RiskRegisterNotifier extends StateNotifier<RiskRegisterModel> {
  RiskRegisterNotifier() : super(const RiskRegisterModel(isLoading: true));

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

final risk_registerProvider = StateNotifierProvider<RiskRegisterNotifier, RiskRegisterModel>((ref) {
  return RiskRegisterNotifier()..loadData();
});
