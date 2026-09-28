import 'package:primecare_ui/primecare_ui.dart';
import 'auth_experience.dart';

/// Shared presentation; authentication policy remains in the controllers.
class ForgotPasswordView extends GovernedScreen {
  const ForgotPasswordView({super.key});
  @override
  String get featureId => 'auth.forgot_password';
  @override
  String get requiredRole => 'Public';
  @override
  Widget buildGovernedView(BuildContext context, WidgetRef ref) =>
      const PrimeAuthExperience(page: AuthPage.forgot);
}
