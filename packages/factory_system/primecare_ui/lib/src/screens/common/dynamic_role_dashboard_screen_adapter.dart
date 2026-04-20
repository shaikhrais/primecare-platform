import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_core/flutter_core.dart';
// Prisma Load Adapter

class DynamicRoleDashboardScreenViewModel {
  final bool isLoading;
  final dynamic data;
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
      state = DynamicRoleDashboardScreenViewModel(isLoading: false, data: response);
    } catch (e) {
      // Fallback
      state = DynamicRoleDashboardScreenViewModel(isLoading: false, data: {});
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
