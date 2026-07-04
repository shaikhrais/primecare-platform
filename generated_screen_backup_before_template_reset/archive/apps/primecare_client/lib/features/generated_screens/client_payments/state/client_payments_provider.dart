import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/client_payments_model.dart';

class ClientPaymentsNotifier extends StateNotifier<ClientPaymentsModel> {
  ClientPaymentsNotifier() : super(const ClientPaymentsModel(isLoading: true));

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

final client_paymentsProvider = StateNotifierProvider<ClientPaymentsNotifier, ClientPaymentsModel>((ref) {
  return ClientPaymentsNotifier()..loadData();
});
