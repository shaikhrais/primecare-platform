import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/cfo_invoices_model.dart';

class CfoInvoicesNotifier extends StateNotifier<CfoInvoicesModel> {
  CfoInvoicesNotifier() : super(const CfoInvoicesModel(isLoading: true));

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

final cfo_invoicesProvider = StateNotifierProvider<CfoInvoicesNotifier, CfoInvoicesModel>((ref) {
  return CfoInvoicesNotifier()..loadData();
});
