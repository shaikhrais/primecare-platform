import 'package:flutter_riverpod/legacy.dart';
import '../models/ceo_organization_map_model.dart';

class CeoOrganizationMapNotifier extends StateNotifier<CeoOrganizationMapModel> {
  CeoOrganizationMapNotifier() : super(const CeoOrganizationMapModel(isLoading: true));

  Future<void> loadData() async {
    state = state.copyWith(isLoading: true);
    try {
      // TODO: Call API service
      state = state.copyWith(isLoading: false, data: const <String, dynamic>{});
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }
}

final ceo_organization_mapProvider = StateNotifierProvider<CeoOrganizationMapNotifier, CeoOrganizationMapModel>((ref) {
  return CeoOrganizationMapNotifier()..loadData();
});
