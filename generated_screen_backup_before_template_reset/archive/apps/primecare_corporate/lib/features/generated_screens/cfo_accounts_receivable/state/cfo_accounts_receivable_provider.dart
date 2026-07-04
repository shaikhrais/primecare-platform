import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/cfo_accounts_receivable_model.dart';

class CfoAccountsReceivableNotifier extends StateNotifier<CfoAccountsReceivableModel> {
  CfoAccountsReceivableNotifier() : super(const CfoAccountsReceivableModel(isLoading: true));

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

final cfo_accounts_receivableProvider = StateNotifierProvider<CfoAccountsReceivableNotifier, CfoAccountsReceivableModel>((ref) {
  return CfoAccountsReceivableNotifier()..loadData();
});
