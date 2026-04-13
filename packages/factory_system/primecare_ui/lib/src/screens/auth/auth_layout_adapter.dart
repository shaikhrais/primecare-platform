import 'package:flutter_riverpod/flutter_riverpod.dart';
// Prisma Load Adapter

class AuthLayoutViewModel {
  final bool isLoading;
  final dynamic data;
  AuthLayoutViewModel({this.isLoading = false, this.data});
}

class AuthLayoutAdapter extends Notifier<AuthLayoutViewModel> {
  @override
  AuthLayoutViewModel build() {
    return AuthLayoutViewModel();
  }
  Future<void> loadData() async {
     // TODO: Prisma API binding
     state = AuthLayoutViewModel(isLoading: true, data: state.data);
     // Simulate fetch
     state = AuthLayoutViewModel(isLoading: false, data: {});
  }
}

final authLayoutAdapterProvider = NotifierProvider<AuthLayoutAdapter, AuthLayoutViewModel>(() {
  return AuthLayoutAdapter();
});
