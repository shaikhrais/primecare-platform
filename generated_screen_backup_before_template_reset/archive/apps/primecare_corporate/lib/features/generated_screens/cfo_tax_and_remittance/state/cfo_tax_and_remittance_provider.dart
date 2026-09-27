import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/cfo_tax_and_remittance_model.dart';

class CfoTaxAndRemittanceNotifier extends StateNotifier<CfoTaxAndRemittanceModel> {
  CfoTaxAndRemittanceNotifier() : super(const CfoTaxAndRemittanceModel(isLoading: true));

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

final cfo_tax_and_remittanceProvider = StateNotifierProvider<CfoTaxAndRemittanceNotifier, CfoTaxAndRemittanceModel>((ref) {
  return CfoTaxAndRemittanceNotifier()..loadData();
});
