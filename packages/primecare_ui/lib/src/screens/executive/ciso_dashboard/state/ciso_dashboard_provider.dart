import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/ciso_dashboard_model.dart';

class CisoDashboardNotifier extends StateNotifier<CisoDashboardModel> {
  CisoDashboardNotifier() : super(const CisoDashboardModel(isLoading: true));

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

final ciso_dashboardProvider = StateNotifierProvider<CisoDashboardNotifier, CisoDashboardModel>((ref) {
  return CisoDashboardNotifier()..loadData();
});
