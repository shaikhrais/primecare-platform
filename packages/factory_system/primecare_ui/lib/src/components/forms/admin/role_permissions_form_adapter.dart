import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_core/flutter_core.dart';
// Prisma Load Adapter

class RolePermissionsFormViewModel {
  final bool isLoading;
  final dynamic data;
  RolePermissionsFormViewModel({this.isLoading = false, this.data});
}

class RolePermissionsFormAdapter
    extends Notifier<RolePermissionsFormViewModel> {
  @override
  RolePermissionsFormViewModel build() {
    return RolePermissionsFormViewModel();
  }

  Future<void> loadData() async {
        state = RolePermissionsFormViewModel(isLoading: true, data: state.data);
    try {
      final client = ref.read(apiClientProvider);
      final response = await client.get('/api/v1/role-permissions-form-adapter');
      state = RolePermissionsFormViewModel(isLoading: false, data: response ?? {});
    } catch (e) {
      // Fallback
      state = RolePermissionsFormViewModel(isLoading: false, data: {});
    }
  }
}

final rolePermissionsFormAdapterProvider =
    NotifierProvider<RolePermissionsFormAdapter, RolePermissionsFormViewModel>(
      () {
        return RolePermissionsFormAdapter();
      },
    );
