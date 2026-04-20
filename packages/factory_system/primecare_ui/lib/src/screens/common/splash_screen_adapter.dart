import 'package:primecare_core/flutter_core.dart';
// Prisma Load Adapter

class SplashScreenViewModel {
  final bool isLoading;
  final dynamic data;
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
      state = SplashScreenViewModel(isLoading: false, data: response);
    } catch (e) {
      // Fallback
      state = SplashScreenViewModel(isLoading: false, data: {});
    }
  }
}

final splashScreenAdapterProvider =
    NotifierProvider<SplashScreenAdapter, SplashScreenViewModel>(() {
      return SplashScreenAdapter();
    });
