import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/regional_manager_usa_dashboard_model.dart';

class RegionalManagerUsaDashboardNotifier extends StateNotifier<RegionalManagerUsaDashboardModel> {
  RegionalManagerUsaDashboardNotifier() : super(const RegionalManagerUsaDashboardModel(isLoading: true));

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

final regional_manager_usa_dashboardProvider = StateNotifierProvider<RegionalManagerUsaDashboardNotifier, RegionalManagerUsaDashboardModel>((ref) {
  return RegionalManagerUsaDashboardNotifier()..loadData();
});
