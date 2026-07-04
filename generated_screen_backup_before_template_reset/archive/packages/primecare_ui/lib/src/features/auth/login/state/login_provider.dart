import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/login_model.dart';

class LoginNotifier extends StateNotifier<LoginModel> {
  LoginNotifier() : super(const LoginModel(isLoading: true));

  Future<void> loadData() async {
    state = state.copyWith(isLoading: true);
    try {
      // TODO: Call API service
      state = state.copyWith(isLoading: false, data: const {});
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }
}

final loginProvider = StateNotifierProvider<LoginNotifier, LoginModel>((ref) {
  return LoginNotifier()..loadData();
});
