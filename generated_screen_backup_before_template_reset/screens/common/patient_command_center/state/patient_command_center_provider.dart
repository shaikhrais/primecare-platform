import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/patient_command_center_model.dart';

class PatientCommandCenterNotifier extends StateNotifier<PatientCommandCenterModel> {
  PatientCommandCenterNotifier() : super(const PatientCommandCenterModel(isLoading: true));

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

final patient_command_centerProvider = StateNotifierProvider<PatientCommandCenterNotifier, PatientCommandCenterModel>((ref) {
  return PatientCommandCenterNotifier()..loadData();
});
