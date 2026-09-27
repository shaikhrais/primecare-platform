import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/hsw_care_plans_model.dart';

class HswCarePlansNotifier extends StateNotifier<HswCarePlansModel> {
  HswCarePlansNotifier() : super(const HswCarePlansModel(isLoading: true));

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

final hsw_care_plansProvider = StateNotifierProvider<HswCarePlansNotifier, HswCarePlansModel>((ref) {
  return HswCarePlansNotifier()..loadData();
});
