import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/ceo_dashboard_model.dart';

class CeoDashboardNotifier extends StateNotifier<CeoDashboardModel> {
  CeoDashboardNotifier() : super(const CeoDashboardModel(isLoading: true));

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

final ceo_dashboardProvider = StateNotifierProvider<CeoDashboardNotifier, CeoDashboardModel>((ref) {
  return CeoDashboardNotifier()..loadData();
});
