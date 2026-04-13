import 'package:flutter_riverpod/flutter_riverpod.dart';
// Prisma Load Adapter

class RolePermissionsFormViewModel {
  final bool isLoading;
  final dynamic data;
  RolePermissionsFormViewModel({this.isLoading = false, this.data});
}

class RolePermissionsFormAdapter extends Notifier<RolePermissionsFormViewModel> {
  @override
  RolePermissionsFormViewModel build() {
    return RolePermissionsFormViewModel();
  }
  Future<void> loadData() async {
     // TODO: Prisma API binding
     state = RolePermissionsFormViewModel(isLoading: true, data: state.data);
     // Simulate fetch
     state = RolePermissionsFormViewModel(isLoading: false, data: {});
  }
}

final rolePermissionsFormAdapterProvider = NotifierProvider<RolePermissionsFormAdapter, RolePermissionsFormViewModel>(() {
  return RolePermissionsFormAdapter();
});
