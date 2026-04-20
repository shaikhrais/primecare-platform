import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_core/flutter_core.dart';
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
        state = AdminLayoutViewModel(isLoading: true, data: state.data);
    try {
      final client = ref.read(apiClientProvider);
      final response = await client.get('/api/v1/admin-layout-adapter');
      state = AdminLayoutViewModel(isLoading: false, data: response);
    } catch (e) {
      // Fallback
      state = AdminLayoutViewModel(isLoading: false, data: {});
    }
  }
}

final adminLayoutAdapterProvider =
    NotifierProvider<AdminLayoutAdapter, AdminLayoutViewModel>(() {
      return AdminLayoutAdapter();
    });
