import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/billing_invoices_model.dart';

class BillingInvoicesNotifier extends StateNotifier<BillingInvoicesModel> {
  BillingInvoicesNotifier() : super(const BillingInvoicesModel(isLoading: true));

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

final billing_invoicesProvider = StateNotifierProvider<BillingInvoicesNotifier, BillingInvoicesModel>((ref) {
  return BillingInvoicesNotifier()..loadData();
});
