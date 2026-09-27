import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/patient_documents_model.dart';

class PatientDocumentsNotifier extends StateNotifier<PatientDocumentsModel> {
  PatientDocumentsNotifier() : super(const PatientDocumentsModel(isLoading: true));

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

final patient_documentsProvider = StateNotifierProvider<PatientDocumentsNotifier, PatientDocumentsModel>((ref) {
  return PatientDocumentsNotifier()..loadData();
});
