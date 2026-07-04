import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/territory_sales_manager_compliance_model.dart';

class TerritorySalesManagerComplianceNotifier extends StateNotifier<TerritorySalesManagerComplianceModel> {
  TerritorySalesManagerComplianceNotifier() : super(const TerritorySalesManagerComplianceModel(isLoading: true));

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

final territory_sales_manager_complianceProvider = StateNotifierProvider<TerritorySalesManagerComplianceNotifier, TerritorySalesManagerComplianceModel>((ref) {
  return TerritorySalesManagerComplianceNotifier()..loadData();
});
