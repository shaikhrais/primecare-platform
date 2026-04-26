// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

/// Hardened fuse_page_simple_header
class FusePageSimpleHeader extends StatelessWidget {
  FusePageSimpleHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return ClinicalGlassPanel(
      title: LocaleKeys.dashboards_common_labels_fuse_page_simple_header.tr(),
      child: PrimeCareCard(
        child: Text(
          LocaleKeys
              .dashboards_common_labels_operational_sector__fuse_page_simple_header
              .tr(),
        ),
      ),
    );
  }
}
