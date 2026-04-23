// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

/// Hardened sign_out_page_view
class SignOutPageView extends StatelessWidget {
  const SignOutPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return ClinicalGlassPanel(
      title: 'sign_out_page_view',
      child: const PrimeCareCard(child: Text('Operational Sector: sign_out_page_view')),
    );
  }
}
