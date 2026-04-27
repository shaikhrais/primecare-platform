import 'package:primecare_ui/src/shared/primecare_adapters.dart' hide Result, StateNotifierProvider, AsyncValue;

import 'sign_in_model.dart';

final signInControllerProvider = StateNotifierProvider<SignInController, AsyncValue<SignInViewModel>>((ref) {
  return SignInController(ref);
});

class SignInController extends StateNotifier<AsyncValue<SignInViewModel>> {
  final Ref ref;
  
  SignInController(this.ref) : super(const AsyncValue.data(SignInViewModel()));
  
  Future<void> signIn(String email, String password) async {
    state = const AsyncValue.loading();
    // Implementation for sign in logic
    state = const AsyncValue.data(SignInViewModel());
  }
}
