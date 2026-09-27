import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/invoice_management_model.dart';

class InvoiceManagementNotifier extends StateNotifier<InvoiceManagementModel> {
  InvoiceManagementNotifier() : super(const InvoiceManagementModel(isLoading: true));

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

final invoice_managementProvider = StateNotifierProvider<InvoiceManagementNotifier, InvoiceManagementModel>((ref) {
  return InvoiceManagementNotifier()..loadData();
});
