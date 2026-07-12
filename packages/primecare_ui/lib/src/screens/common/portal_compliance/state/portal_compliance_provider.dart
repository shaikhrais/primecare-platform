import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/portal_compliance_model.dart';

class PortalComplianceNotifier extends StateNotifier<PortalComplianceModel> {
  PortalComplianceNotifier() : super(const PortalComplianceModel(isLoading: true));

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

final portal_complianceProvider = StateNotifierProvider<PortalComplianceNotifier, PortalComplianceModel>((ref) {
  return PortalComplianceNotifier()..loadData();
});
