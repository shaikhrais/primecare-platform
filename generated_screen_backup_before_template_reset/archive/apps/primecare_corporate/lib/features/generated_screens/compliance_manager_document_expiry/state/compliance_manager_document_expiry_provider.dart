import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/compliance_manager_document_expiry_model.dart';

class ComplianceManagerDocumentExpiryNotifier extends StateNotifier<ComplianceManagerDocumentExpiryModel> {
  ComplianceManagerDocumentExpiryNotifier() : super(const ComplianceManagerDocumentExpiryModel(isLoading: true));

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

final compliance_manager_document_expiryProvider = StateNotifierProvider<ComplianceManagerDocumentExpiryNotifier, ComplianceManagerDocumentExpiryModel>((ref) {
  return ComplianceManagerDocumentExpiryNotifier()..loadData();
});
