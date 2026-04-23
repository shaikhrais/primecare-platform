// Layer: 05_UI_PRESENTATION
import 'package:flutter_core/00_B_flutter_core.dart';
// Prisma Load Adapter

class ForgotPasswordScreenViewModel {
  final bool isLoading;
  final Map<String, dynamic>? data;
  ForgotPasswordScreenViewModel({this.isLoading = false, this.data});
}

class ForgotPasswordScreenAdapter
    extends Notifier<ForgotPasswordScreenViewModel> {
  @override
  ForgotPasswordScreenViewModel build() {
    return ForgotPasswordScreenViewModel();
  }

  Future<void> loadData() async {
        state = ForgotPasswordScreenViewModel(isLoading: true, data: state.data);
    try {
      final client = ref.read(apiClientProvider);
      final response = await client.get('/api/v1/forgot-password-screen-adapter');
      state = ForgotPasswordScreenViewModel(isLoading: false, data: response.data as Map<String, dynamic>?);
    } catch (e) {
      // Fallback
      state = ForgotPasswordScreenViewModel(isLoading: false, data: <String, dynamic>{});
    }
  }
}

final forgotPasswordScreenAdapterProvider =
    NotifierProvider<
      ForgotPasswordScreenAdapter,
      ForgotPasswordScreenViewModel
    >(() {
      return ForgotPasswordScreenAdapter();
    });
