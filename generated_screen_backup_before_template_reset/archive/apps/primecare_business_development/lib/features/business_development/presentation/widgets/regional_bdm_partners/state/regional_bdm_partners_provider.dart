import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/regional_bdm_partners_model.dart';

class RegionalBdmPartnersNotifier extends StateNotifier<RegionalBdmPartnersModel> {
  RegionalBdmPartnersNotifier() : super(const RegionalBdmPartnersModel(isLoading: true));

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

final regional_bdm_partnersProvider = StateNotifierProvider<RegionalBdmPartnersNotifier, RegionalBdmPartnersModel>((ref) {
  return RegionalBdmPartnersNotifier()..loadData();
});
