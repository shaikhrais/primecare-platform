// Layer: 05_UI_PRESENTATION
import 'package:flutter_core/00_B_flutter_core.dart';
// Prisma Load Adapter

class SignupScreenViewModel {
  final bool isLoading;
  final Map<String, dynamic>? data;
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
      state = SignupScreenViewModel(
        isLoading: false,
        data: response.data as Map<String, dynamic>?,
      );
    } catch (e) {
      // Fallback
      state = SignupScreenViewModel(
        isLoading: false,
        data: <String, dynamic>{},
      );
    }
  }
}

final signupScreenAdapterProvider =
    NotifierProvider<SignupScreenAdapter, SignupScreenViewModel>(() {
      return SignupScreenAdapter();
    });
