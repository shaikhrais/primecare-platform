import 'package:flutter_riverpod/flutter_riverpod.dart';
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
    // TODO: Prisma API binding
    state = LoginScreenViewModel(isLoading: true, data: state.data);
    // Simulate fetch
    state = LoginScreenViewModel(isLoading: false, data: {});
  }
}

final loginScreenAdapterProvider =
    NotifierProvider<LoginScreenAdapter, LoginScreenViewModel>(() {
      return LoginScreenAdapter();
    });
