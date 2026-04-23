
// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

/// Hardened error401PageView
class Error401pageview extends StatelessWidget {
  const Error401pageview({super.key});

  @override
  Widget build(BuildContext context) {
    return const PrimeCareResponsiveKpiGrid(
      children: [
        PrimeCareCard(child: Text('Operational Sector: error401PageView')),
      ],
    );
  }
}
