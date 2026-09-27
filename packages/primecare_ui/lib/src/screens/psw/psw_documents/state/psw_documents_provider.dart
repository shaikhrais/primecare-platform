import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/psw_documents_model.dart';

class PswDocumentsNotifier extends StateNotifier<PswDocumentsModel> {
  PswDocumentsNotifier() : super(const PswDocumentsModel(isLoading: true));

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

final psw_documentsProvider = StateNotifierProvider<PswDocumentsNotifier, PswDocumentsModel>((ref) {
  return PswDocumentsNotifier()..loadData();
});
