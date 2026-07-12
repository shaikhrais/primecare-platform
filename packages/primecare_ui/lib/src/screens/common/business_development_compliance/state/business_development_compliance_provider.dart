import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/business_development_compliance_model.dart';

class BusinessDevelopmentComplianceNotifier extends StateNotifier<BusinessDevelopmentComplianceModel> {
  BusinessDevelopmentComplianceNotifier() : super(const BusinessDevelopmentComplianceModel(isLoading: true));

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

final business_development_complianceProvider = StateNotifierProvider<BusinessDevelopmentComplianceNotifier, BusinessDevelopmentComplianceModel>((ref) {
  return BusinessDevelopmentComplianceNotifier()..loadData();
});
