import 'package:flutter/material.dart';
import 'package:flutter_core/models/governance_types.dart';

/// A widget that displays a high-level system readiness report.
class PlatformReadinessViewer extends StatelessWidget {
  const PlatformReadinessViewer({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock data for now, would typically come from a provider
    final report = PlatformReadinessReport(
      totalServices: 8,
      activeServices: 8,
      complianceScore: 0.94,
      criticalIssues: [
        'Documentation mismatch in Billing API',
        'Insecure route discovered in Auth Service (Local only)',
      ],
      timestamp: DateTime.now(),
    );

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          const SizedBox(height: 32),
          _buildScoreCard(context, report.complianceScore),
          const SizedBox(height: 24),
          _buildDetailGrid(context, report),
          const SizedBox(height: 32),
          _buildCriticalIssues(context, report.criticalIssues),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'System Readiness Report',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, letterSpacing: -1.0),
        ),
        Text(
          'Standardized platform-wide health and compliance audit summary.',
          style: TextStyle(color: Colors.grey[600], fontSize: 14),
        ),
      ],
    );
  }

  Widget _buildScoreCard(BuildContext context, double score) {
    final color = score > 0.9 ? Colors.green : (score > 0.7 ? Colors.orange : Colors.red);
    
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color.withValues(alpha: 0.8), color],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'PLATFORM READINESS SCORE',
                  style: TextStyle(color: Colors.white70, fontWeight: FontWeight.w800, fontSize: 12, letterSpacing: 1.5),
                ),
                const SizedBox(height: 8),
                Text(
                  '${(score * 100).toInt()}%',
                  style: const TextStyle(color: Colors.white, fontSize: 64, fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'PRODUCTION READY',
                    style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.verified_user, color: Colors.white, size: 100),
        ],
      ),
    );
  }

  Widget _buildDetailGrid(BuildContext context, PlatformReadinessReport report) {
    return Row(
      children: [
        _buildDetailItem(context, 'Total Services', report.totalServices.toString(), Icons.dns_outlined),
        const SizedBox(width: 16),
        _buildDetailItem(context, 'Active Status', '${report.activeServices}/${report.totalServices}', Icons.check_circle_outline),
        const SizedBox(width: 16),
        _buildDetailItem(context, 'Last Audit', '2 mins ago', Icons.history),
      ],
    );
  }

  Widget _buildDetailItem(BuildContext context, String label, String value, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.withValues(alpha: 0.1)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: Colors.blue, size: 24),
            const SizedBox(height: 16),
            Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
            const SizedBox(height: 4),
            Text(label, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _buildCriticalIssues(BuildContext context, List<String> issues) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'CRITICAL COMPLIANCE ISSUES',
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 12, letterSpacing: 1.2, color: Colors.red),
        ),
        const SizedBox(height: 16),
        ...issues.map((issue) => Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.red.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.red.withValues(alpha: 0.1)),
          ),
          child: Row(
            children: [
              const Icon(Icons.warning_amber_rounded, color: Colors.red, size: 20),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  issue,
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ),
              const Icon(Icons.chevron_right, color: Colors.red, size: 20),
            ],
          ),
        )),
      ],
    );
  }
}
