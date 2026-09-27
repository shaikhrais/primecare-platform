import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/intake_coordinator_new_client_intake_model.dart';

class IntakeCoordinatorNewClientIntakeNotifier extends StateNotifier<IntakeCoordinatorNewClientIntakeModel> {
  IntakeCoordinatorNewClientIntakeNotifier() : super(const IntakeCoordinatorNewClientIntakeModel(isLoading: true));

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

final intake_coordinator_new_client_intakeProvider = StateNotifierProvider<IntakeCoordinatorNewClientIntakeNotifier, IntakeCoordinatorNewClientIntakeModel>((ref) {
  return IntakeCoordinatorNewClientIntakeNotifier()..loadData();
});
