import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/business_development_dashboard_model.dart';

class BusinessDevelopmentDashboardNotifier extends StateNotifier<BusinessDevelopmentDashboardModel> {
  BusinessDevelopmentDashboardNotifier() : super(const BusinessDevelopmentDashboardModel(isLoading: true));

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

final business_development_dashboardProvider = StateNotifierProvider<BusinessDevelopmentDashboardNotifier, BusinessDevelopmentDashboardModel>((ref) {
  return BusinessDevelopmentDashboardNotifier()..loadData();
});
