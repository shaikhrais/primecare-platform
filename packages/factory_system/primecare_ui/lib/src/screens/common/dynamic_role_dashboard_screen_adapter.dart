import 'package:flutter_riverpod/flutter_riverpod.dart';
// Prisma Load Adapter

class DynamicRoleDashboardScreenViewModel {
  final bool isLoading;
  final dynamic data;
  DynamicRoleDashboardScreenViewModel({this.isLoading = false, this.data});
}

class DynamicRoleDashboardScreenAdapter extends Notifier<DynamicRoleDashboardScreenViewModel> {
  @override
  DynamicRoleDashboardScreenViewModel build() {
    return DynamicRoleDashboardScreenViewModel();
  }
  Future<void> loadData() async {
     // TODO: Prisma API binding
     state = DynamicRoleDashboardScreenViewModel(isLoading: true, data: state.data);
     // Simulate fetch
     state = DynamicRoleDashboardScreenViewModel(isLoading: false, data: {});
  }
}

final dynamicRoleDashboardScreenAdapterProvider = NotifierProvider<DynamicRoleDashboardScreenAdapter, DynamicRoleDashboardScreenViewModel>(() {
  return DynamicRoleDashboardScreenAdapter();
});

// Styled with global Theme and CustomColors.
