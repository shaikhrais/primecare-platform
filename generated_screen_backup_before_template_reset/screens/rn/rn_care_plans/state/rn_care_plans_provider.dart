import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/rn_care_plans_model.dart';

class RnCarePlansNotifier extends StateNotifier<RnCarePlansModel> {
  RnCarePlansNotifier() : super(const RnCarePlansModel(isLoading: true));

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

final rn_care_plansProvider = StateNotifierProvider<RnCarePlansNotifier, RnCarePlansModel>((ref) {
  return RnCarePlansNotifier()..loadData();
});
