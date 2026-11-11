import 'package:primecare_ui/primecare_ui.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:primecare_governance/governance/models/governance_report.dart';

class GovernanceSeverityFixture extends StatefulWidget {
 final AuditSeverity severity; const GovernanceSeverityFixture(this.severity,{super.key});
 @override State<GovernanceSeverityFixture> createState()=>_GovernanceSeverityFixtureState();
}
class _GovernanceSeverityFixtureState extends State<GovernanceSeverityFixture> {
 @override Widget build(BuildContext context)=>_buildSeverityBadge(context,severity);
 AuditSeverity get severity=>widget.severity;
  Widget _buildSeverityBadge(BuildContext context, AuditSeverity severity) {
    Color color;
    switch (severity) {
      case AuditSeverity.critical:
        color = PrimeActionPalette.of(context, PrimeActionTone.error).accent;
        break;
      case AuditSeverity.high:
        color = PrimeActionPalette.of(context, PrimeActionTone.warning).accent;
        break;
      case AuditSeverity.medium:
        color = PrimeActionPalette.of(context, PrimeActionTone.warning).accent;
        break;
      case AuditSeverity.low:
        color = PrimeActionPalette.of(context, PrimeActionTone.primary).accent;
        break;
      case AuditSeverity.info:
        color = PrimeActionPalette.of(context, PrimeActionTone.primary).accent;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: PrimeActionPalette.tintSurface(context, color),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: PrimeText(
        severity.name.toUpperCase(),
        style: TextStyle(
          color: PrimeActionPalette.onTint(context, color),
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class GovernanceReadinessFixture extends StatefulWidget {
 final GovernanceReport report; const GovernanceReadinessFixture(this.report,{super.key});
 @override State<GovernanceReadinessFixture> createState()=>_GovernanceReadinessFixtureState();
}
class _GovernanceReadinessFixtureState extends State<GovernanceReadinessFixture> {
 @override Widget build(BuildContext context)=>_buildReadinessPanel(report);
 GovernanceReport get report=>widget.report;
  Widget _buildReadinessPanel(GovernanceReport report) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [PrimeActionPalette.of(context, PrimeActionTone.primary).accent, PrimeActionPalette.of(context, PrimeActionTone.primary).accent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PrimeText(
                  'Production Readiness Status',
                  style: TextStyle(
                    color: PrimeActionPalette.of(context, PrimeActionTone.primary).onAccent,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                PrimeText(
                  '${report.productionReadyScreens} screens meet all production quality gates. ${report.blockedScreens} screens are currently blocked by critical or high-severity issues.',
                  style: TextStyle(
                    color: PrimeActionPalette.of(context, PrimeActionTone.primary).onAccent,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 32),
          PrimeCircularProgressIndicator(
            value: report.totalScreens > 0
                ? report.productionReadyScreens / report.totalScreens
                : 0,
            backgroundColor: PrimeActionPalette.of(context, PrimeActionTone.primary).onAccent.withValues(alpha: 0.2),
            valueColor: AlwaysStoppedAnimation<Color>(PrimeActionPalette.of(context, PrimeActionTone.primary).onAccent),
            strokeWidth: 8,
          ),
        ],
      ),
    );
  }
}
