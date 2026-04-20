import 'package:primecare_core/flutter_core.dart';
// Prisma Load Adapter

class SignupScreenViewModel {
  final bool isLoading;
  final dynamic data;
  SignupScreenViewModel({this.isLoading = false, this.data});
}

class SignupScreenAdapter extends Notifier<SignupScreenViewModel> {
  @override
  SignupScreenViewModel build() {
    return SignupScreenViewModel();
  }

  Future<void> loadData() async {
        state = SignupScreenViewModel(isLoading: true, data: state.data);
    try {
      final client = ref.read(apiClientProvider);
      final response = await client.get('/api/v1/signup-screen-adapter');
      state = SignupScreenViewModel(isLoading: false, data: response);
    } catch (e) {
      // Fallback
      state = SignupScreenViewModel(isLoading: false, data: {});
    }
  }
}

final signupScreenAdapterProvider =
    NotifierProvider<SignupScreenAdapter, SignupScreenViewModel>(() {
      return SignupScreenAdapter();
    });
