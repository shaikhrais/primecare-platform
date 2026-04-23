// Layer: 05_UI_PRESENTATION
import 'package:flutter_core/00_B_flutter_core.dart';
// Prisma Load Adapter

class DynamicRoleDashboardScreenViewModel {
  final bool isLoading;
  final Map<String, dynamic>? data;
  DynamicRoleDashboardScreenViewModel({this.isLoading = false, this.data});
}

class DynamicRoleDashboardScreenAdapter
    extends Notifier<DynamicRoleDashboardScreenViewModel> {
  @override
  DynamicRoleDashboardScreenViewModel build() {
    return DynamicRoleDashboardScreenViewModel();
  }

  Future<void> loadData() async {
        state = DynamicRoleDashboardScreenViewModel(isLoading: true, data: state.data);
    try {
      final client = ref.read(apiClientProvider);
      final response = await client.get('/api/v1/dynamic-role-dashboard-screen-adapter');
      state = DynamicRoleDashboardScreenViewModel(isLoading: false, data: response.data as Map<String, dynamic>?);
    } catch (e) {
      // Fallback
      state = DynamicRoleDashboardScreenViewModel(isLoading: false, data: <String, dynamic>{});
    }
  }
}

final dynamicRoleDashboardScreenAdapterProvider =
    NotifierProvider<
      DynamicRoleDashboardScreenAdapter,
      DynamicRoleDashboardScreenViewModel
    >(() {
      return DynamicRoleDashboardScreenAdapter();
    });

// Styled with global Theme and CustomColors.
