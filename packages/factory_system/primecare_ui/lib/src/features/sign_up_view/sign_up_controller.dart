import 'package:primecare_ui/src/shared/primecare_adapters.dart' hide Result, StateNotifierProvider, AsyncValue;

import 'sign_up_model.dart';

final signUpControllerProvider = StateNotifierProvider<SignUpController, AsyncValue<SignUpViewModel>>((ref) {
  return SignUpController(ref);
});

class SignUpController extends StateNotifier<AsyncValue<SignUpViewModel>> {
  final Ref ref;
  
  SignUpController(this.ref) : super(const AsyncValue.data(SignUpViewModel()));
  
  Future<void> signUp(String email, String password) async {
    state = const AsyncValue.loading();
    // Implementation for sign up logic
    state = const AsyncValue.data(SignUpViewModel());
  }
}
