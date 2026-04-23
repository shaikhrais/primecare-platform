// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

/// Hardened sign_up_page_title
class SignUpPageTitle extends StatelessWidget {
  const SignUpPageTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return ClinicalGlassPanel(
      title: 'sign_up_page_title',
      child: const PrimeCareCard(child: Text('Operational Sector: sign_up_page_title')),
    );
  }
}
