import 'package:primecare_ui/primecare_ui.dart';
import 'auth_experience.dart';

/// Shared presentation; authentication policy remains in the controllers.
class ResetPasswordView extends GovernedScreen {
  const ResetPasswordView({super.key});
  @override
  String get featureId => 'auth.reset_password';
  @override
  String get requiredRole => 'Public';
  @override
  Widget buildGovernedView(BuildContext context, WidgetRef ref) =>
      const PrimeAuthExperience(page: AuthPage.reset);
}
