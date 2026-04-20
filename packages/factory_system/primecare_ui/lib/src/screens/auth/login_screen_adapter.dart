import 'package:primecare_core/flutter_core.dart';
// Prisma Load Adapter

class LoginScreenViewModel {
  final bool isLoading;
  final dynamic data;
  LoginScreenViewModel({this.isLoading = false, this.data});
}

class LoginScreenAdapter extends Notifier<LoginScreenViewModel> {
  @override
  LoginScreenViewModel build() {
    return LoginScreenViewModel();
  }

  Future<void> loadData() async {
        state = LoginScreenViewModel(isLoading: true, data: state.data);
    try {
      final client = ref.read(apiClientProvider);
      final response = await client.get('/api/v1/login-screen-adapter');
      state = LoginScreenViewModel(isLoading: false, data: response);
    } catch (e) {
      // Fallback
      state = LoginScreenViewModel(isLoading: false, data: {});
    }
  }
}

final loginScreenAdapterProvider =
    NotifierProvider<LoginScreenAdapter, LoginScreenViewModel>(() {
      return LoginScreenAdapter();
    });
