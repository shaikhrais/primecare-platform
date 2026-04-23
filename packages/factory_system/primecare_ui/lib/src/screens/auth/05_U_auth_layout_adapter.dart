// Layer: 05_UI_PRESENTATION
import 'package:flutter_core/00_B_flutter_core.dart';
// Prisma Load Adapter

class AuthLayoutViewModel {
  final bool isLoading;
  final Map<String, dynamic>? data;
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
      state = AuthLayoutViewModel(isLoading: false, data: response.data as Map<String, dynamic>?);
    } catch (e) {
      // Fallback
      state = AuthLayoutViewModel(isLoading: false, data: <String, dynamic>{});
    }
  }
}

final authLayoutAdapterProvider =
    NotifierProvider<AuthLayoutAdapter, AuthLayoutViewModel>(() {
      return AuthLayoutAdapter();
    });
