import 'package:flutter_riverpod/legacy.dart';
import '../models/admin_refunds_model.dart';

class AdminRefundsNotifier extends StateNotifier<AdminRefundsModel> {
  AdminRefundsNotifier() : super(const AdminRefundsModel(isLoading: true));

  Future<void> loadData() async {
    state = state.copyWith(isLoading: true);
    try {
      // TODO: Call API service
      state = state.copyWith(isLoading: false, data: const <String, dynamic>{});
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }
}

final admin_refundsProvider = StateNotifierProvider<AdminRefundsNotifier, AdminRefundsModel>((ref) {
  return AdminRefundsNotifier()..loadData();
});
