import 'package:flutter_riverpod/flutter_riverpod.dart';
// Prisma Load Adapter

class AdminLayoutViewModel {
  final bool isLoading;
  final dynamic data;
  AdminLayoutViewModel({this.isLoading = false, this.data});
}

class AdminLayoutAdapter extends Notifier<AdminLayoutViewModel> {
  @override
  AdminLayoutViewModel build() {
    return AdminLayoutViewModel();
  }
  Future<void> loadData() async {
     // TODO: Prisma API binding
     state = AdminLayoutViewModel(isLoading: true, data: state.data);
     // Simulate fetch
     state = AdminLayoutViewModel(isLoading: false, data: {});
  }
}

final adminLayoutAdapterProvider = NotifierProvider<AdminLayoutAdapter, AdminLayoutViewModel>(() {
  return AdminLayoutAdapter();
});
