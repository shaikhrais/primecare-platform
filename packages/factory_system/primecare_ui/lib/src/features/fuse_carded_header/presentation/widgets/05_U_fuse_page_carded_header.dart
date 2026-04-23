// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

/// Hardened fuse_page_carded_header
class FusePageCardedHeader extends StatelessWidget {
  const FusePageCardedHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return ClinicalGlassPanel(
      title: 'fuse_page_carded_header',
      child: const PrimeCareCard(child: Text('Operational Sector: fuse_page_carded_header')),
    );
  }
}
