import 'package:flutter_riverpod/legacy.dart';
import '../models/intake_coordinator_new_intakes_model.dart';

class IntakeCoordinatorNewIntakesNotifier extends StateNotifier<IntakeCoordinatorNewIntakesModel> {
  IntakeCoordinatorNewIntakesNotifier() : super(const IntakeCoordinatorNewIntakesModel(isLoading: true));

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

final intake_coordinator_new_intakesProvider = StateNotifierProvider<IntakeCoordinatorNewIntakesNotifier, IntakeCoordinatorNewIntakesModel>((ref) {
  return IntakeCoordinatorNewIntakesNotifier()..loadData();
});
