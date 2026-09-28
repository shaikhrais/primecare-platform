import 'package:primecare_ui/primecare_ui.dart';
import '../../auth_experience.dart';

/// Shared presentation; authentication policy remains in the controllers.
class ConsentScreen extends GovernedScreen {
  final String redirectUri;
  const ConsentScreen({super.key, required this.redirectUri});
  @override
  String get featureId => 'auth.consent';
  @override
  String get requiredRole => 'Public';
  @override
  Widget buildGovernedView(BuildContext context, WidgetRef ref) =>
      const PrimeAuthExperience(page: AuthPage.consent);
}
