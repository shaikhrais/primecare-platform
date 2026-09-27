import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/home_care_plan_model.dart';

class HomeCarePlanNotifier extends StateNotifier<HomeCarePlanModel> {
  HomeCarePlanNotifier() : super(const HomeCarePlanModel(isLoading: true));

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

final home_care_planProvider = StateNotifierProvider<HomeCarePlanNotifier, HomeCarePlanModel>((ref) {
  return HomeCarePlanNotifier()..loadData();
});
