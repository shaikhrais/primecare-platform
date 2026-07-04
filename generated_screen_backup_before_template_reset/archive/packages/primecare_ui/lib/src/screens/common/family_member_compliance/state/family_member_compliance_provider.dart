import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/family_member_compliance_model.dart';

class FamilyMemberComplianceNotifier extends StateNotifier<FamilyMemberComplianceModel> {
  FamilyMemberComplianceNotifier() : super(const FamilyMemberComplianceModel(isLoading: true));

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

final family_member_complianceProvider = StateNotifierProvider<FamilyMemberComplianceNotifier, FamilyMemberComplianceModel>((ref) {
  return FamilyMemberComplianceNotifier()..loadData();
});
