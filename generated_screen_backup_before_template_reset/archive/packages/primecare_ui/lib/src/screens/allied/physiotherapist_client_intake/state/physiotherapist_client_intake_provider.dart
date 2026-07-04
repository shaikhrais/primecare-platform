import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/physiotherapist_client_intake_model.dart';

class PhysiotherapistClientIntakeNotifier extends StateNotifier<PhysiotherapistClientIntakeModel> {
  PhysiotherapistClientIntakeNotifier() : super(const PhysiotherapistClientIntakeModel(isLoading: true));

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

final physiotherapist_client_intakeProvider = StateNotifierProvider<PhysiotherapistClientIntakeNotifier, PhysiotherapistClientIntakeModel>((ref) {
  return PhysiotherapistClientIntakeNotifier()..loadData();
});
