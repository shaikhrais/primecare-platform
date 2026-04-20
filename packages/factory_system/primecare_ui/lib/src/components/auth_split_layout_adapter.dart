import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_core/flutter_core.dart';
// Prisma Load Adapter

class AuthSplitLayoutViewModel {
  final bool isLoading;
  final dynamic data;
  AuthSplitLayoutViewModel({this.isLoading = false, this.data});
}

class AuthSplitLayoutAdapter extends Notifier<AuthSplitLayoutViewModel> {
  @override
  AuthSplitLayoutViewModel build() {
    return AuthSplitLayoutViewModel();
  }

  Future<void> loadData() async {
        state = AuthSplitLayoutViewModel(isLoading: true, data: state.data);
    try {
      final client = ref.read(apiClientProvider);
      final response = await client.get('/api/v1/auth-split-layout-adapter');
      state = AuthSplitLayoutViewModel(isLoading: false, data: response);
    } catch (e) {
      // Fallback
      state = AuthSplitLayoutViewModel(isLoading: false, data: {});
    }
  }
}

final authSplitLayoutAdapterProvider =
    NotifierProvider<AuthSplitLayoutAdapter, AuthSplitLayoutViewModel>(() {
      return AuthSplitLayoutAdapter();
    });
