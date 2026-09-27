import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/intake_coordinator_documents_model.dart';

class IntakeCoordinatorDocumentsNotifier extends StateNotifier<IntakeCoordinatorDocumentsModel> {
  IntakeCoordinatorDocumentsNotifier() : super(const IntakeCoordinatorDocumentsModel(isLoading: true));

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

final intake_coordinator_documentsProvider = StateNotifierProvider<IntakeCoordinatorDocumentsNotifier, IntakeCoordinatorDocumentsModel>((ref) {
  return IntakeCoordinatorDocumentsNotifier()..loadData();
});
