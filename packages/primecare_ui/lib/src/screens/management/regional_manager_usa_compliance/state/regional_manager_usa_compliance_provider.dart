import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/regional_manager_usa_compliance_model.dart';

class RegionalManagerUsaComplianceNotifier extends StateNotifier<RegionalManagerUsaComplianceModel> {
  RegionalManagerUsaComplianceNotifier() : super(const RegionalManagerUsaComplianceModel(isLoading: true));

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

final regional_manager_usa_complianceProvider = StateNotifierProvider<RegionalManagerUsaComplianceNotifier, RegionalManagerUsaComplianceModel>((ref) {
  return RegionalManagerUsaComplianceNotifier()..loadData();
});
