import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/cfo_tax_model.dart';

class CfoTaxNotifier extends StateNotifier<CfoTaxModel> {
  CfoTaxNotifier() : super(const CfoTaxModel(isLoading: true));

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

final cfo_taxProvider = StateNotifierProvider<CfoTaxNotifier, CfoTaxModel>((ref) {
  return CfoTaxNotifier()..loadData();
});
