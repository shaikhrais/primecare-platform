import 'package:flutter_riverpod/flutter_riverpod.dart';
// Prisma Load Adapter

class MasterDashboardPageViewModel {
  final bool isLoading;
  final dynamic data;
  MasterDashboardPageViewModel({this.isLoading = false, this.data});
}

class MasterDashboardPageAdapter extends Notifier<MasterDashboardPageViewModel> {
  @override
  MasterDashboardPageViewModel build() {
    return MasterDashboardPageViewModel();
  }
  Future<void> loadData() async {
     // TODO: Prisma API binding
     state = MasterDashboardPageViewModel(isLoading: true, data: state.data);
     // Simulate fetch
     state = MasterDashboardPageViewModel(isLoading: false, data: {});
  }
}

final masterDashboardPageAdapterProvider = NotifierProvider<MasterDashboardPageAdapter, MasterDashboardPageViewModel>(() {
  return MasterDashboardPageAdapter();
});

// Styled with global Theme and CustomColors.
