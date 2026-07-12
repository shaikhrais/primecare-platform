import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/shareholder_compliance_model.dart';

class ShareholderComplianceNotifier extends StateNotifier<ShareholderComplianceModel> {
  ShareholderComplianceNotifier() : super(const ShareholderComplianceModel(isLoading: true));

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

final shareholder_complianceProvider = StateNotifierProvider<ShareholderComplianceNotifier, ShareholderComplianceModel>((ref) {
  return ShareholderComplianceNotifier()..loadData();
});
