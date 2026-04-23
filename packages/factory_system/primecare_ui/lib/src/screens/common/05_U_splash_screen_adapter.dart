// Layer: 05_UI_PRESENTATION
import 'package:flutter_core/00_B_flutter_core.dart';
// Prisma Load Adapter

class SplashScreenViewModel {
  final bool isLoading;
  final Map<String, dynamic>? data;
  SplashScreenViewModel({this.isLoading = false, this.data});
}

class SplashScreenAdapter extends Notifier<SplashScreenViewModel> {
  @override
  SplashScreenViewModel build() {
    return SplashScreenViewModel();
  }

  Future<void> loadData() async {
        state = SplashScreenViewModel(isLoading: true, data: state.data);
    try {
      final client = ref.read(apiClientProvider);
      final response = await client.get('/api/v1/splash-screen-adapter');
      state = SplashScreenViewModel(isLoading: false, data: response.data as Map<String, dynamic>?);
    } catch (e) {
      // Fallback
      state = SplashScreenViewModel(isLoading: false, data: <String, dynamic>{});
    }
  }
}

final splashScreenAdapterProvider =
    NotifierProvider<SplashScreenAdapter, SplashScreenViewModel>(() {
      return SplashScreenAdapter();
    });
