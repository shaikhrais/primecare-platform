import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/care_plan_model.dart';

class CarePlanNotifier extends StateNotifier<CarePlanModel> {
  CarePlanNotifier() : super(const CarePlanModel(isLoading: true));

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

final care_planProvider = StateNotifierProvider<CarePlanNotifier, CarePlanModel>((ref) {
  return CarePlanNotifier()..loadData();
});
