import 'package:primecare_ui/primecare_ui.dart';
import 'package:primecare_ui/src/localization/admin_reality_filter_catalog.dart';

class PurposePaletteFixture extends StatefulWidget {
  final String status;
  const PurposePaletteFixture(this.status, {super.key});
  @override
  State<PurposePaletteFixture> createState() => _PurposePaletteFixtureState();
}
class _PurposePaletteFixtureState extends State<PurposePaletteFixture> {
  String _filterText(String key) => adminRealityFilterCatalog['en']![key]!;
  @override
  Widget build(BuildContext context) => _buildPurposeStatusPill(widget.status);
  Widget _buildPurposeStatusPill(String status) {
    Color bg = PrimeActionPalette.of(context, PrimeActionTone.muted).surface;
    Color border = PrimeActionPalette.of(context, PrimeActionTone.muted).accent.withValues(alpha: 0.3);
    Color text = PrimeActionPalette.of(context, PrimeActionTone.muted).onSurface;

    switch (status) {
      case 'CLEAR_PURPOSE':
        bg = PrimeActionPalette.of(context, PrimeActionTone.success).surface;
        border = PrimeActionPalette.of(context, PrimeActionTone.success).accent.withValues(alpha: 0.3);
        text = PrimeActionPalette.of(context, PrimeActionTone.success).onSurface;
        break;
      case 'UNCLEAR_PURPOSE':
        bg = PrimeActionPalette.of(context, PrimeActionTone.warning).surface;
        border = PrimeActionPalette.of(context, PrimeActionTone.warning).accent.withValues(alpha: 0.3);
        text = PrimeActionPalette.of(context, PrimeActionTone.warning).onSurface;
        break;
      case 'DUPLICATE_PURPOSE':
        bg = PrimeActionPalette.of(context, PrimeActionTone.secondary).surface;
        border = PrimeActionPalette.of(context, PrimeActionTone.secondary).accent.withValues(alpha: 0.3);
        text = PrimeActionPalette.of(context, PrimeActionTone.secondary).onSurface;
        break;
      case 'NO_USER_VALUE':
      default:
        bg = PrimeActionPalette.of(context, PrimeActionTone.error).surface;
        border = PrimeActionPalette.of(context, PrimeActionTone.error).accent.withValues(alpha: 0.3);
        text = PrimeActionPalette.of(context, PrimeActionTone.error).onSurface;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(context.theme.radiusDefault),
        border: Border.all(color: border),
      ),
      child: Text(
        ['CLEAR_PURPOSE', 'UNCLEAR_PURPOSE', 'DUPLICATE_PURPOSE', 'NO_USER_VALUE'].contains(status)
            ? _filterText('status.$status')
            : status,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          fontSize: context.theme.scaleFont(8),
          fontWeight: FontWeight.bold,
          color: text,
        ),
      ),
    );
  }
}

class HealthPaletteFixture extends StatefulWidget {
  final bool ready;
  const HealthPaletteFixture(this.ready, {super.key});
  @override
  State<HealthPaletteFixture> createState() => _HealthPaletteFixtureState();
}
class _HealthPaletteFixtureState extends State<HealthPaletteFixture> {
  @override
  Widget build(BuildContext context) => _buildStatusPill(widget.ready);
  Widget _buildStatusPill(bool isReady) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: isReady ? PrimeActionPalette.of(context, PrimeActionTone.success).surface : PrimeActionPalette.of(context, PrimeActionTone.warning).surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isReady ? PrimeActionPalette.of(context, PrimeActionTone.success).accent.withValues(alpha: 0.3) : PrimeActionPalette.of(context, PrimeActionTone.warning).accent.withValues(alpha: 0.3),
        ),
      ),
      child: Text(
        isReady ? 'PRODUCTION' : 'DEVELOPMENT',
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: isReady ? PrimeActionPalette.of(context, PrimeActionTone.success).onSurface : PrimeActionPalette.of(context, PrimeActionTone.warning).onSurface,
        ),
      ),
    );
  }
}
