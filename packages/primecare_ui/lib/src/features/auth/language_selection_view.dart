import 'package:primecare_ui/primecare_ui.dart';
import 'auth_experience.dart';

/// Shared presentation; authentication policy remains in the controllers.
class LanguageSelectionView extends GovernedScreen {
  const LanguageSelectionView({super.key});
  @override
  String get featureId => 'auth.language_selection';
  @override
  String get requiredRole => 'Public';
  @override
  Widget buildGovernedView(BuildContext context, WidgetRef ref) =>
      const PrimeAuthExperience(page: AuthPage.language);
}
