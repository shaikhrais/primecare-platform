import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_core/flutter_core.dart';
// Prisma Load Adapter

class AuthLayoutViewModel {
  final bool isLoading;
  final dynamic data;
  AuthLayoutViewModel({this.isLoading = false, this.data});
}

class AuthLayoutAdapter extends Notifier<AuthLayoutViewModel> {
  @override
  AuthLayoutViewModel build() {
    return AuthLayoutViewModel();
  }

  Future<void> loadData() async {
        state = AuthLayoutViewModel(isLoading: true, data: state.data);
    try {
      final client = ref.read(apiClientProvider);
      final response = await client.get('/api/v1/auth-layout-adapter');
      state = AuthLayoutViewModel(isLoading: false, data: response ?? {});
    } catch (e) {
      // Fallback
      state = AuthLayoutViewModel(isLoading: false, data: {});
    }
  }
}

final authLayoutAdapterProvider =
    NotifierProvider<AuthLayoutAdapter, AuthLayoutViewModel>(() {
      return AuthLayoutAdapter();
    });
