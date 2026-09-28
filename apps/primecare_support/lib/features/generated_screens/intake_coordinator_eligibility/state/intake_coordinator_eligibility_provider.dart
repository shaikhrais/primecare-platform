import 'package:flutter_riverpod/legacy.dart';
import '../models/intake_coordinator_eligibility_model.dart';

class IntakeCoordinatorEligibilityNotifier extends StateNotifier<IntakeCoordinatorEligibilityModel> {
  IntakeCoordinatorEligibilityNotifier() : super(const IntakeCoordinatorEligibilityModel(isLoading: true));

  Future<void> loadData() async {
    state = state.copyWith(isLoading: true);
    try {
      // TODO: Call API service
      state = state.copyWith(isLoading: false, data: const <String, dynamic>{});
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }
}

final intake_coordinator_eligibilityProvider = StateNotifierProvider<IntakeCoordinatorEligibilityNotifier, IntakeCoordinatorEligibilityModel>((ref) {
  return IntakeCoordinatorEligibilityNotifier()..loadData();
});
