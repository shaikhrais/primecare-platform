import 'dart:ui';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:flutter_core/manifest/01_I_aura_action_manifest.dart';

class AuraBriefingPanel extends ConsumerWidget {
  const AuraBriefingPanel({super.key});

  static Future<void> show(BuildContext context) {
    return showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Aura Briefing',
      barrierColor: Colors.black.withValues(alpha: 0.1),
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (context, animation, secondaryAnimation) {
        return const AuraBriefingPanel();
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOutQuint)),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final layout = ref.watch(layoutProvider);
    final scale = layout.scaleFactor;
    final pulseState = ref.watch(auraPulseProvider);
    final activeAnomaly = ref.watch(auraActiveAnomalyProvider);
    
    // In a real scenario, we'd fetch a list of recent insights from a service.
    // For now, we'll use the active anomaly if it exists, plus some simulated platform status.
    
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        width: 420 * scale,
        height: double.infinity,
        margin: EdgeInsets.all(16 * scale),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24 * scale),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
              blurRadius: 40 * scale,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24 * scale),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
            child: Container(
              color: PrimeCareColors.white.withValues(alpha: 0.8),
              child: Material(
                color: Colors.transparent,
                child: Column(
                  children: [
                    _buildHeader(context, scale, pulseState.value),
                    Expanded(
                      child: _buildContent(context, ref, scale, activeAnomaly),
                    ),
                    _buildFooter(scale),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, double scale, AuraEvent? pulse) {
    return Container(
      padding: EdgeInsets.fromLTRB(24 * scale, 32 * scale, 24 * scale, 24 * scale),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: PrimeCareColors.slate200.withValues(alpha: 0.5),
            width: 1,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Intelligence Briefing',
                style: TextStyle(
                  fontSize: 22 * scale,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.5,
                  color: const Color(0xFF1E3A8A),
                ),
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(LucideIcons.x, size: 20 * scale),
                color: PrimeCareColors.slate400,
                style: IconButton.styleFrom(
                  backgroundColor: PrimeCareColors.slate100,
                  padding: EdgeInsets.all(8 * scale),
                ),
              ),
            ],
          ),
          SizedBox(height: 8 * scale),
          Row(
            children: [
              _buildStatusIndicator(scale, pulse?.impact ?? InsightImpact.info),
              SizedBox(width: 8 * scale),
              Text(
                'SYSTEM STATUS: ${pulse?.impact.name.toUpperCase() ?? "STABLE"}',
                style: TextStyle(
                  fontSize: 10 * scale,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.0,
                  color: _getImpactColor(pulse?.impact ?? InsightImpact.info),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusIndicator(double scale, InsightImpact impact) {
    final color = _getImpactColor(impact);
    return Container(
      width: 8 * scale,
      height: 8 * scale,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.4),
            blurRadius: 4 * scale,
            spreadRadius: 2 * scale,
          ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context, WidgetRef ref, double scale, AuraEvent? activeAnomaly) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 24 * scale, vertical: 24 * scale),
      children: [
        _buildSectionTitle(scale, 'ACTIVE INSIGHTS'),
        if (activeAnomaly != null) ...[
          SizedBox(height: 16 * scale),
          AuraInsightCard(event: activeAnomaly),
          SizedBox(height: 12 * scale),
          PrimeCareButton(
            label: _getActionLabel(activeAnomaly.type),
            type: PrimeCareButtonType.primary,
            icon: LucideIcons.externalLink,
            onPressed: () => _handleInsightAction(context, ref, activeAnomaly),
          ),
        ] else
          _buildEmptyState(scale),
        
        SizedBox(height: 32 * scale),
        _buildSectionTitle(scale, 'TELEMETRY FEED'),
        SizedBox(height: 16 * scale),
        _buildTelemetryRow(scale, 'Network Latency', '24ms', LucideIcons.activity, PrimeCareColors.emerald),
        _buildTelemetryRow(scale, 'Memory Utilization', '42%', LucideIcons.cpu, PrimeCareColors.skyBlue),
        _buildTelemetryRow(scale, 'API Health', '100%', LucideIcons.checkCircle, PrimeCareColors.emerald),
        _buildTelemetryRow(scale, 'Sync Engine', 'Idle', LucideIcons.refreshCcw, PrimeCareColors.slate400),
      ],
    );
  }

  Widget _buildSectionTitle(double scale, String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 11 * scale,
        fontWeight: FontWeight.w900,
        letterSpacing: 1.2,
        color: PrimeCareColors.slate400,
      ),
    );
  }

  Widget _buildEmptyState(double scale) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 40 * scale),
      decoration: BoxDecoration(
        color: PrimeCareColors.slate50.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(16 * scale),
        border: Border.all(color: PrimeCareColors.slate100),
      ),
      child: Center(
        child: Column(
          children: [
            Icon(LucideIcons.checkCircle, color: PrimeCareColors.emerald, size: 32 * scale),
            SizedBox(height: 12 * scale),
            Text(
              'All systems nominal',
              style: TextStyle(
                fontSize: 14 * scale,
                fontWeight: FontWeight.w600,
                color: PrimeCareColors.slate600,
              ),
            ),
            Text(
              'Aura Intelligence is monitoring...',
              style: TextStyle(
                fontSize: 12 * scale,
                color: PrimeCareColors.slate400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTelemetryRow(double scale, String label, String value, IconData icon, Color color) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12 * scale),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8 * scale),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8 * scale),
            ),
            child: Icon(icon, size: 16 * scale, color: color),
          ),
          SizedBox(width: 12 * scale),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14 * scale,
                fontWeight: FontWeight.w500,
                color: PrimeCareColors.slate700,
              ),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14 * scale,
              fontWeight: FontWeight.w700,
              color: PrimeCareColors.slate800,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter(double scale) {
    return Container(
      padding: EdgeInsets.all(24 * scale),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: PrimeCareColors.slate200.withValues(alpha: 0.5),
            width: 1,
          ),
        ),
      ),
      child: PrimeCareButton(
        label: 'SYSTEM DIAGNOSTICS',
        type: PrimeCareButtonType.secondary,
        icon: LucideIcons.barChart,
        onPressed: () {},
      ),
    );
  }

  String _getActionLabel(AuraEventType type) {
    switch (type) {
      case AuraEventType.occupancySpike:
        return 'REALLOCATE STAFF';
      case AuraEventType.revenueDip:
        return 'AUDIT TRANSACTIONS';
      case AuraEventType.workforceEfficiency:
        return 'VIEW PERFORMANCE';
      default:
        return 'EXECUTE MITIGATION';
    }
  }

  void _handleInsightAction(
    BuildContext context,
    WidgetRef ref,
    AuraEvent event,
  ) {
    Navigator.pop(context); // Close briefing
    AuraActionManifest.handleMitigation(context, event);
  }

  Color _getImpactColor(InsightImpact impact) {
    switch (impact) {
      case InsightImpact.alert:
      case InsightImpact.warning:
      case InsightImpact.critical:
        return PrimeCareColors.rose;
      case InsightImpact.caution:
        return PrimeCareColors.amber;
      case InsightImpact.positive:
      case InsightImpact.growth:
        return PrimeCareColors.emerald;
      case InsightImpact.info:
        return PrimeCareColors.skyBlue;
    }
  }
}
