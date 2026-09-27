import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/document_expiry_model.dart';

class DocumentExpiryNotifier extends StateNotifier<DocumentExpiryModel> {
  DocumentExpiryNotifier() : super(const DocumentExpiryModel(isLoading: true));

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

final document_expiryProvider = StateNotifierProvider<DocumentExpiryNotifier, DocumentExpiryModel>((ref) {
  return DocumentExpiryNotifier()..loadData();
});
