import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/patient_messages_model.dart';

class PatientMessagesNotifier extends StateNotifier<PatientMessagesModel> {
  PatientMessagesNotifier() : super(const PatientMessagesModel(isLoading: true));

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

final patient_messagesProvider = StateNotifierProvider<PatientMessagesNotifier, PatientMessagesModel>((ref) {
  return PatientMessagesNotifier()..loadData();
});
