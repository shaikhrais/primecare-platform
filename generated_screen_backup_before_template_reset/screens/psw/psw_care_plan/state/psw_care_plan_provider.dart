import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/psw_care_plan_model.dart';

class PswCarePlanNotifier extends StateNotifier<PswCarePlanModel> {
  PswCarePlanNotifier() : super(const PswCarePlanModel(isLoading: true));

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

final psw_care_planProvider = StateNotifierProvider<PswCarePlanNotifier, PswCarePlanModel>((ref) {
  return PswCarePlanNotifier()..loadData();
});
