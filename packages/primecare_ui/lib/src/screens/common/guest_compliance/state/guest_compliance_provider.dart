import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/guest_compliance_model.dart';

class GuestComplianceNotifier extends StateNotifier<GuestComplianceModel> {
  GuestComplianceNotifier() : super(const GuestComplianceModel(isLoading: true));

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

final guest_complianceProvider = StateNotifierProvider<GuestComplianceNotifier, GuestComplianceModel>((ref) {
  return GuestComplianceNotifier()..loadData();
});
