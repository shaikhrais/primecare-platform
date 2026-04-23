
// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

/// Hardened error404PageView
class Error404pageview extends StatelessWidget {
  const Error404pageview({super.key});

  @override
  Widget build(BuildContext context) {
    return const PrimeCareResponsiveKpiGrid(
      children: [
        PrimeCareCard(child: Text('Operational Sector: error404PageView')),
      ],
    );
  }
}
