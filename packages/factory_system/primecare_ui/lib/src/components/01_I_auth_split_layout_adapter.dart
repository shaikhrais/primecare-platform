// Layer: 01_INFRASTRUCTURE
import 'package:primecare_core/00_B_flutter_core.dart';
// Prisma Load Adapter

class AuthSplitLayoutViewModel {
  final bool isLoading;
  final Map<String, dynamic>? data;
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
      state = AuthSplitLayoutViewModel(isLoading: false, data: response.data as Map<String, dynamic>?);
    } catch (e) {
      // Fallback
      state = AuthSplitLayoutViewModel(isLoading: false, data: <String, dynamic>{});
    }
  }
}

final authSplitLayoutAdapterProvider =
    NotifierProvider<AuthSplitLayoutAdapter, AuthSplitLayoutViewModel>(() {
      return AuthSplitLayoutAdapter();
    });
