import 'package:flutter_riverpod/flutter_riverpod.dart';
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
     // TODO: Prisma API binding
     state = SplashScreenViewModel(isLoading: true, data: state.data);
     // Simulate fetch
     state = SplashScreenViewModel(isLoading: false, data: {});
  }
}

final splashScreenAdapterProvider = NotifierProvider<SplashScreenAdapter, SplashScreenViewModel>(() {
  return SplashScreenAdapter();
});
