import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/cfo_accounts_payable_model.dart';

class CfoAccountsPayableNotifier extends StateNotifier<CfoAccountsPayableModel> {
  CfoAccountsPayableNotifier() : super(const CfoAccountsPayableModel(isLoading: true));

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

final cfo_accounts_payableProvider = StateNotifierProvider<CfoAccountsPayableNotifier, CfoAccountsPayableModel>((ref) {
  return CfoAccountsPayableNotifier()..loadData();
});
