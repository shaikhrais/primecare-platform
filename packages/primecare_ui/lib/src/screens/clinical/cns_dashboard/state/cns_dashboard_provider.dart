import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/cns_dashboard_model.dart';

class CnsDashboardNotifier extends StateNotifier<CnsDashboardModel> {
  CnsDashboardNotifier() : super(const CnsDashboardModel(isLoading: true));

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

final cns_dashboardProvider = StateNotifierProvider<CnsDashboardNotifier, CnsDashboardModel>((ref) {
  return CnsDashboardNotifier()..loadData();
});
