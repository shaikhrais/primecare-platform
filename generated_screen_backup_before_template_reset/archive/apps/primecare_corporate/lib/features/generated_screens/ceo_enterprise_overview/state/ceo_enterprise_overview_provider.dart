import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/ceo_enterprise_overview_model.dart';

class CeoEnterpriseOverviewNotifier extends StateNotifier<CeoEnterpriseOverviewModel> {
  CeoEnterpriseOverviewNotifier() : super(const CeoEnterpriseOverviewModel(isLoading: true));

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

final ceo_enterprise_overviewProvider = StateNotifierProvider<CeoEnterpriseOverviewNotifier, CeoEnterpriseOverviewModel>((ref) {
  return CeoEnterpriseOverviewNotifier()..loadData();
});
