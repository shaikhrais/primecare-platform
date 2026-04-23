// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

/// Hardened fuse_page_simple
class FusePageSimple extends StatelessWidget {
  const FusePageSimple({super.key});

  @override
  Widget build(BuildContext context) {
    return ClinicalGlassPanel(
      title: 'fuse_page_simple',
      child: const PrimeCareCard(child: Text('Operational Sector: fuse_page_simple')),
    );
  }
}
