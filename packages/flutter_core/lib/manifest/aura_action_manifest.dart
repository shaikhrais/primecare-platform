// Governance - Category: service | Purpose: Layer: 01_INFRASTRUCTURE Centralized service for mapping Aura anomalies to platform mitigation tasks. Decouples UI tr...
// Layer: 01_INFRASTRUCTURE
import 'package:primecare_ui_foundation/primecare_ui_foundation.dart' show PrimeElevatedButton, PrimeTextButton;
import 'package:google_fonts/google_fonts.dart';
import 'package:primecare_ui_foundation/primecare_ui_foundation.dart' show PrimeText;
import 'package:flutter_core/flutter_core.dart';

/// Centralized service for mapping Aura anomalies to platform mitigation tasks.
/// Decouples UI triggers from concrete navigation and API logic.
class AuraActionManifest {
  static void handleMitigation(BuildContext context, AuraEvent event) {
    final metadata = event.metadata ?? {};
    final type = metadata['type'] as String? ?? 'unknown';

    switch (type) {
      case 'latency':
        _showMitigationDialog(
          context,
          'Traffic Optimization',
          'Aura recommends enabling regional edge caching to mitigate the detected 450ms latency spike.',
        );
        break;
      case 'memory':
        _showMitigationDialog(
          context,
          'Memory Reclamation',
          'Aura identifies a leak in the real-time websocket buffer. Initiating garbage collection for orphaned streams.',
        );
        break;
      case 'api_health':
        _showMitigationDialog(
          context,
          'Endpoint Failover',
          'Aura detects degraded performance in the secondary API gateway. Switching traffic to the high-availability node.',
        );
        break;
      case 'understaffing':
        // Deep link to Staffing Efficiency Office
        Navigator.of(
          context,
        ).pushNamed('/offices/corporate/roles/coo/staffing-efficiency');
        break;
      case 'ledger_discrepancy':
        // Deep link to Ledger Audit
        Navigator.of(
          context,
        ).pushNamed('/offices/corporate/roles/cfo/financial-overview');
        break;
      case 'predictive_staffing':
        // Action Chain: Navigate -> Show Suggestion
        _executeActionChain(context, [
          () => Navigator.of(
            context,
          ).pushNamed('/offices/corporate/roles/coo/staffing-efficiency'),
          () => _showMitigationDialog(
            context,
            'Anticipated Gap Mitigation',
            'Aura predicts a staffing deficit. Initiating automated shift posting for the holiday weekend?',
          ),
        ]);
        break;
      default:
        _showDefaultAction(context, event.title);
    }
  }

  static void _executeActionChain(
    BuildContext context,
    List<VoidCallback> actions,
  ) {
    for (final action in actions) {
      action();
    }
  }

  static void _showMitigationDialog(
    BuildContext context,
    String title,
    String description,
  ) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1E293B),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: const BorderSide(color: Colors.white10),
        ),
        title: Row(
          children: [
            const Icon(LucideIcons.sparkles, color: Color(0xFF818CF8)),
            const SizedBox(width: 12),
            PrimeText(
              title,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        content: PrimeText(
          description,
          style: GoogleFonts.inter(color: Colors.white70),
        ),
        actions: [
          PrimeTextButton(
            onPressed: () => Navigator.pop(context),
            child: PrimeText(
              'DISMISS',
              style: GoogleFonts.inter(color: Colors.white38),
            ),
          ),
          PrimeElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: PrimeElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF818CF8),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const PrimeText('EXECUTE MITIGATION'),
          ),
        ],
      ),
    );
  }

  static void _showDefaultAction(BuildContext context, String action) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: PrimeText('Aura is preparing mitigation for: $action'),
        backgroundColor: const Color(0xFF6366F1),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
