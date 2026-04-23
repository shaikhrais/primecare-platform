// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

/// Hardened sign_in_page_title
class SignInPageTitle extends StatelessWidget {
  const SignInPageTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return ClinicalGlassPanel(
      title: 'sign_in_page_title',
      child: const PrimeCareCard(child: Text('Operational Sector: sign_in_page_title')),
    );
  }
}
