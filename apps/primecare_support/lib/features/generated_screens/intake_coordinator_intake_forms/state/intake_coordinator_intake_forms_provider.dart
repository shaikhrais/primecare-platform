import 'package:flutter_riverpod/legacy.dart';
import '../models/intake_coordinator_intake_forms_model.dart';

class IntakeCoordinatorIntakeFormsNotifier extends StateNotifier<IntakeCoordinatorIntakeFormsModel> {
  IntakeCoordinatorIntakeFormsNotifier() : super(const IntakeCoordinatorIntakeFormsModel(isLoading: true));

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

final intake_coordinator_intake_formsProvider = StateNotifierProvider<IntakeCoordinatorIntakeFormsNotifier, IntakeCoordinatorIntakeFormsModel>((ref) {
  return IntakeCoordinatorIntakeFormsNotifier()..loadData();
});
