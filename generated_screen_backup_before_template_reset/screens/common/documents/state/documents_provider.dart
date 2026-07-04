import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/documents_model.dart';

class DocumentsNotifier extends StateNotifier<DocumentsModel> {
  DocumentsNotifier() : super(const DocumentsModel(isLoading: true));

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

final documentsProvider = StateNotifierProvider<DocumentsNotifier, DocumentsModel>((ref) {
  return DocumentsNotifier()..loadData();
});
