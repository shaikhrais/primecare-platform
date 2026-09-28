import 'package:flutter_riverpod/legacy.dart';
import '../models/admin_claims_model.dart';

class AdminClaimsNotifier extends StateNotifier<AdminClaimsModel> {
  AdminClaimsNotifier() : super(const AdminClaimsModel(isLoading: true));

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

final admin_claimsProvider = StateNotifierProvider<AdminClaimsNotifier, AdminClaimsModel>((ref) {
  return AdminClaimsNotifier()..loadData();
});
