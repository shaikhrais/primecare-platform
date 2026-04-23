// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

/// Hardened fuse_page_carded_sidebar
class FusePageCardedSidebar extends StatelessWidget {
  const FusePageCardedSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return ClinicalGlassPanel(
      title: 'fuse_page_carded_sidebar',
      child: const PrimeCareCard(child: Text('Operational Sector: fuse_page_carded_sidebar')),
    );
  }
}
