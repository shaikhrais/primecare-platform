import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/regional_bdm_leads_model.dart';

class RegionalBdmLeadsNotifier extends StateNotifier<RegionalBdmLeadsModel> {
  RegionalBdmLeadsNotifier() : super(const RegionalBdmLeadsModel(isLoading: true));

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

final regional_bdm_leadsProvider = StateNotifierProvider<RegionalBdmLeadsNotifier, RegionalBdmLeadsModel>((ref) {
  return RegionalBdmLeadsNotifier()..loadData();
});
