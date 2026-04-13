import 'package:flutter_riverpod/flutter_riverpod.dart';
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
     // TODO: Prisma API binding
     state = SignupScreenViewModel(isLoading: true, data: state.data);
     // Simulate fetch
     state = SignupScreenViewModel(isLoading: false, data: {});
  }
}

final signupScreenAdapterProvider = NotifierProvider<SignupScreenAdapter, SignupScreenViewModel>(() {
  return SignupScreenAdapter();
});
