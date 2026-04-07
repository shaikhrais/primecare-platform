import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:flutter/material.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../../theme/theme.dart';
import '../../../../theme/clinical_glass_panel.dart';
import 'package:lucide_icons/lucide_icons.dart';

class ReleaseManagementScreen extends StatelessWidget {
  const ReleaseManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          const SizedBox(height: 24),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildKPIs(context),
                  const SizedBox(height: 24),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            _buildDeploymentPipeline(context),
                            const SizedBox(height: 24),
                            _buildActiveFeatureFlags(context),
                          ],
                        ),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            _buildRecentReleases(context),
                            const SizedBox(height: 24),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Release Management & CI/CD',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Pipeline status, rollout controls, and deployment history.',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.white70),
            ),
          ],
        ),
        Row(
          children: [
            _buildActionIconButton(
              context,
              LucideIcons.github,
              'GitHub Actions',
            ),
            const SizedBox(width: 12),
            _buildActionIconButton(
              context,
              LucideIcons.pauseCircle,
              'Halt Deployments',
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionIconButton(
    BuildContext context,
    IconData icon,
    String tooltip,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.white),
        onPressed: () {},
        tooltip: tooltip,
      ),
    );
  }

  Widget _buildKPIs(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildKPIUnit(
            context,
            'Build Success Rate',
            '98.5%',
            LucideIcons.checkSquare,
            'Last 100 builds',
            PrimeCareTheme.emeraldTeal,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildKPIUnit(
            context,
            'Current Version',
            'v4.2.1-rc3',
            LucideIcons.tag,
            'Deployed 2h ago',
            Colors.blue,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildKPIUnit(
            context,
            'Time to Deploy',
            '4m 12s',
            LucideIcons.timer,
            'Master branch',
            PrimeCareTheme.emeraldTeal,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildKPIUnit(
            context,
            'Active Flags',
            '14',
            LucideIcons.toggleRight,
            '3 canary rolls',
            Colors.orange,
          ),
        ),
      ],
    );
  }

  Widget _buildKPIUnit(
    BuildContext context,
    String title,
    String value,
    IconData icon,
    String subtitle,
    Color color,
  ) {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Icon(icon, color: color, size: 20),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(
              color: color.withValues(alpha: 0.8),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeploymentPipeline(BuildContext context) {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Active Deployment Pipeline',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                'View Full Logs',
                style: TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          _buildPipelineStage(
            'Push to Master (f8a92b1)',
            'Complete (12s)',
            LucideIcons.gitCommit,
            PrimeCareTheme.emeraldTeal,
          ),
          _buildPipelineConnector(PrimeCareTheme.emeraldTeal),
          _buildPipelineStage(
            'Build Web Client',
            'Complete (1m 45s)',
            LucideIcons.monitor,
            PrimeCareTheme.emeraldTeal,
          ),
          _buildPipelineConnector(PrimeCareTheme.emeraldTeal),
          _buildPipelineStage(
            'Run End-to-End Tests',
            'In Progress (2m+)',
            LucideIcons.testTube,
            Colors.blue,
            isActive: true,
          ),
          _buildPipelineConnector(Colors.white12),
          _buildPipelineStage(
            'Deploy to Staging',
            'Pending',
            LucideIcons.cloudRain,
            Colors.white38,
          ),
          _buildPipelineConnector(Colors.white12),
          _buildPipelineStage(
            'Production Canary Rollout',
            'Pending',
            LucideIcons.rocket,
            Colors.white38,
          ),
        ],
      ),
    );
  }

  Widget _buildPipelineStage(
    String title,
    String status,
    IconData icon,
    Color color, {
    bool isActive = false,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isActive
                ? color.withValues(alpha: 0.2)
                : color.withValues(alpha: 0.1),
            border: Border.all(
              color: isActive ? color : color.withValues(alpha: 0.2),
            ),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: isActive ? Colors.white : Colors.white70,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              status,
              style: TextStyle(
                color: color,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        if (isActive) ...[
          const Spacer(),
          const SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildPipelineConnector(Color color) {
    return Container(
      margin: const EdgeInsets.only(left: 23, top: 8, bottom: 8),
      width: 2,
      height: 24,
      color: color,
    );
  }

  Widget _buildActiveFeatureFlags(BuildContext context) {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Active Feature Flags',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(LucideIcons.toggleRight, color: Colors.white54, size: 20),
            ],
          ),
          const SizedBox(height: 24),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              headingTextStyle: const TextStyle(
                color: Colors.white70,
                fontWeight: FontWeight.w600,
              ),
              dataTextStyle: const TextStyle(color: Colors.white),
              columns: const [
                DataColumn(label: Text('Flag Key')),
                DataColumn(label: Text('Description')),
                DataColumn(label: Text('Rollout %')),
                DataColumn(label: Text('Targeting')),
                DataColumn(label: Text('Action')),
              ],
              rows: [
                _buildFlagRow(
                  'new_billing_portal_v2',
                  'Redesigned Stripe invoicing',
                  25,
                  'Enterprise Tier',
                  true,
                ),
                _buildFlagRow(
                  'enable_haversine_v3',
                  'New maps routing algorithm',
                  100,
                  'Global',
                  true,
                ),
                _buildFlagRow(
                  'dark_mode_legacy_sync',
                  'Syncs dark mode to API',
                  0,
                  'Internal IPs',
                  false,
                ),
                _buildFlagRow(
                  'ai_diagnosis_assist',
                  'LLM chart summarization',
                  10,
                  'Beta Testers',
                  true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  DataRow _buildFlagRow(
    String key,
    String desc,
    int rollout,
    String target,
    bool isOn,
  ) {
    return DataRow(
      cells: [
        DataCell(
          Text(key, style: const TextStyle(fontWeight: FontWeight.w500)),
        ),
        DataCell(Text(desc, style: const TextStyle(color: Colors.white70))),
        DataCell(
          Row(
            children: [
              Text(
                '$rollout%',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 8),
              SizedBox(
                width: 50,
                child: LinearProgressIndicator(
                  value: rollout / 100,
                  backgroundColor: Colors.white12,
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    PrimeCareTheme.emeraldTeal,
                  ),
                  minHeight: 4,
                ),
              ),
            ],
          ),
        ),
        DataCell(
          Text(
            target,
            style: const TextStyle(color: Colors.blueAccent, fontSize: 12),
          ),
        ),
        DataCell(
          Switch(
            value: isOn,
            onChanged: (val) {},
            activeColor: PrimeCareTheme.emeraldTeal,
            activeTrackColor: PrimeCareTheme.emeraldTeal.withValues(alpha: 0.3),
            inactiveThumbColor: Colors.white54,
            inactiveTrackColor: Colors.white12,
          ),
        ),
      ],
    );
  }

  Widget _buildRecentReleases(BuildContext context) {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recent Releases',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          _buildReleaseItem(
            'v4.2.0',
            'Major Platform Update',
            '2 days ago',
            PrimeCareTheme.emeraldTeal,
          ),
          const SizedBox(height: 16),
          _buildReleaseItem(
            'v4.1.9',
            'Hotfix: Auth timeouts',
            '4 days ago',
            Colors.orange,
          ),
          const SizedBox(height: 16),
          _buildReleaseItem(
            'v4.1.8',
            'Performance optimizations',
            '1 week ago',
            PrimeCareTheme.emeraldTeal,
          ),
          const SizedBox(height: 16),
          _buildReleaseItem(
            'v4.1.7',
            'New integrations sync',
            '2 weeks ago',
            PrimeCareTheme.emeraldTeal,
          ),
        ],
      ),
    );
  }

  Widget _buildReleaseItem(
    String version,
    String title,
    String time,
    Color color,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            version,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                ),
              ),
              Text(
                time,
                style: const TextStyle(color: Colors.white54, fontSize: 12),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
