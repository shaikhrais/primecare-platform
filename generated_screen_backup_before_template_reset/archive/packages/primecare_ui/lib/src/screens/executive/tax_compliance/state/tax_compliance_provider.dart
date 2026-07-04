import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/tax_compliance_model.dart';

class TaxComplianceNotifier extends StateNotifier<TaxComplianceModel> {
  TaxComplianceNotifier() : super(const TaxComplianceModel(isLoading: true));

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

final tax_complianceProvider = StateNotifierProvider<TaxComplianceNotifier, TaxComplianceModel>((ref) {
  return TaxComplianceNotifier()..loadData();
});
