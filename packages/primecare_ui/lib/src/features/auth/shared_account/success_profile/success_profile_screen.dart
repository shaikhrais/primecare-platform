import 'package:primecare_ui/primecare_ui.dart';
import '../../auth_experience.dart';

/// Shared presentation; authentication policy remains in the controllers.
class SuccessProfileScreen extends GovernedScreen {
  const SuccessProfileScreen({super.key});
  @override
  String get featureId => 'auth.success';
  @override
  String get requiredRole => 'Public';
  @override
  Widget buildGovernedView(BuildContext context, WidgetRef ref) =>
      const PrimeAuthExperience(page: AuthPage.success);
}
