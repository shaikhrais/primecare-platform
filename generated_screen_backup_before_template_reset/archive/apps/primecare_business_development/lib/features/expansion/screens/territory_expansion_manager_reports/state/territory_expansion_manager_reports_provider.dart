import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/territory_expansion_manager_reports_model.dart';

class TerritoryExpansionManagerReportsNotifier extends StateNotifier<TerritoryExpansionManagerReportsModel> {
  TerritoryExpansionManagerReportsNotifier() : super(const TerritoryExpansionManagerReportsModel(isLoading: true));

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

final territory_expansion_manager_reportsProvider = StateNotifierProvider<TerritoryExpansionManagerReportsNotifier, TerritoryExpansionManagerReportsModel>((ref) {
  return TerritoryExpansionManagerReportsNotifier()..loadData();
});
