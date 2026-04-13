import 'package:flutter_riverpod/flutter_riverpod.dart';
// Prisma Load Adapter

class ForgotPasswordScreenViewModel {
  final bool isLoading;
  final dynamic data;
  ForgotPasswordScreenViewModel({this.isLoading = false, this.data});
}

class ForgotPasswordScreenAdapter extends Notifier<ForgotPasswordScreenViewModel> {
  @override
  ForgotPasswordScreenViewModel build() {
    return ForgotPasswordScreenViewModel();
  }
  Future<void> loadData() async {
     // TODO: Prisma API binding
     state = ForgotPasswordScreenViewModel(isLoading: true, data: state.data);
     // Simulate fetch
     state = ForgotPasswordScreenViewModel(isLoading: false, data: {});
  }
}

final forgotPasswordScreenAdapterProvider = NotifierProvider<ForgotPasswordScreenAdapter, ForgotPasswordScreenViewModel>(() {
  return ForgotPasswordScreenAdapter();
});
