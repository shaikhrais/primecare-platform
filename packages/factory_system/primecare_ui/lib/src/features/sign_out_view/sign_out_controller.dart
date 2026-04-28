import 'dart:async';
import 'package:primecare_ui/src/shared/primecare_adapters.dart';
import 'package:primecare_ui/src/features/features_model.dart';

final signOutControllerProvider =
    StateNotifierProvider<SignOutController, AsyncValue<SignOutViewModel>>((
      ref,
    ) {
      return SignOutController(ref);
    });

class SignOutController extends StateNotifier<AsyncValue<SignOutViewModel>> {
  final Ref ref;

  SignOutController(this.ref)
    : super(const AsyncValue.data(SignOutViewModel()));

  Future<void> signOut() async {
    state = const AsyncValue.loading();
    // Implementation for sign out logic
    state = const AsyncValue.data(SignOutViewModel());
  }
}
