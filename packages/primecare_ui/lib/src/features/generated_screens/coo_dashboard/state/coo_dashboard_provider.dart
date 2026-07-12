import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/coo_dashboard_model.dart';

class CooDashboardNotifier extends StateNotifier<CooDashboardModel> {
  CooDashboardNotifier() : super(const CooDashboardModel(isLoading: true));

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

final coo_dashboardProvider = StateNotifierProvider<CooDashboardNotifier, CooDashboardModel>((ref) {
  return CooDashboardNotifier()..loadData();
});
