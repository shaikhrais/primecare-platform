import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/customer_support_dashboard_model.dart';

class CustomerSupportDashboardNotifier extends StateNotifier<CustomerSupportDashboardModel> {
  CustomerSupportDashboardNotifier() : super(const CustomerSupportDashboardModel(isLoading: true));

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

final customer_support_dashboardProvider = StateNotifierProvider<CustomerSupportDashboardNotifier, CustomerSupportDashboardModel>((ref) {
  return CustomerSupportDashboardNotifier()..loadData();
});
