import 'package:flutter_riverpod/flutter_riverpod.dart';
// Prisma Load Adapter

class AuthSplitLayoutViewModel {
  final bool isLoading;
  final dynamic data;
  AuthSplitLayoutViewModel({this.isLoading = false, this.data});
}

class AuthSplitLayoutAdapter extends Notifier<AuthSplitLayoutViewModel> {
  @override
  AuthSplitLayoutViewModel build() {
    return AuthSplitLayoutViewModel();
  }
  Future<void> loadData() async {
     // TODO: Prisma API binding
     state = AuthSplitLayoutViewModel(isLoading: true, data: state.data);
     // Simulate fetch
     state = AuthSplitLayoutViewModel(isLoading: false, data: {});
  }
}

final authSplitLayoutAdapterProvider = NotifierProvider<AuthSplitLayoutAdapter, AuthSplitLayoutViewModel>(() {
  return AuthSplitLayoutAdapter();
});
