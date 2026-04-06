import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:primecare_v4/shared/components/page_template.dart';

class VitalsScreen extends ConsumerWidget {
  const VitalsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'Vitals & Biometrics',
      subtitle: 'Monitor continuous telemetry and record point-of-care vital signs.',
      headerTrailing: [
        ClinicalSearchTextField(hintText: 'Search patients or devices...'),
        const SizedBox(width: 16),
        ClinicalGlassButton(
          onPressed: () {},
          label: 'Log Vitals',
          icon: LucideIcons.plus,
          isPrimary: true,
        ),
      ],
      kpiCards: [
        MetricCardData(
          title: 'Critical Alerts',
          value: '3',
          icon: LucideIcons.activity,
          trend: 'Immediate action req.',
          isUp: false,
          color: PrimeCareTheme.colors.coralRed,
        ),
        MetricCardData(
          title: 'Scheduled Checks',
          value: '22',
          icon: LucideIcons.clipboardList,
          trend: 'For next 4 hours',
          isUp: true,
        ),
        MetricCardData(
          title: 'Telemetry Connected',
          value: '95%',
          icon: LucideIcons.wifi,
          trend: 'All systems online',
          isUp: true,
        ),
      ],
      sidebarContent: [
        _buildActiveTelemetryList(),
      ],
      mainContent: [
        _buildDashboardGrid(),
      ],
    );
  }

  Widget _buildActiveTelemetryList() {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(LucideIcons.activity, color: PrimeCareTheme.colors.navyIndigo, size: 20),
              const SizedBox(width: 8),
              Text('Continuous Telemetry', style: PrimeCareTheme.typography.h3),
            ],
          ),
          const SizedBox(height: 16),
          _buildTelemetryItem('John C.', 'HR: 85 bpm', LucideIcons.heart, PrimeCareTheme.colors.emeraldTeal),
          const SizedBox(height: 12),
          _buildTelemetryItem('Marcus A.', 'SpO2: 89%', LucideIcons.wind, PrimeCareTheme.colors.amberWarning),
          const SizedBox(height: 12),
          _buildTelemetryItem('Sylvia P.', 'BP: 145/95', LucideIcons.activity, PrimeCareTheme.colors.coralRed),
        ],
      ),
    );
  }

  Widget _buildTelemetryItem(String patient, String metric, IconData icon, Color statusColor) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: statusColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: statusColor, size: 16),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(patient, style: PrimeCareTheme.typography.body.copyWith(fontWeight: FontWeight.bold)),
              Text(metric, style: PrimeCareTheme.typography.label.copyWith(color: statusColor, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDashboardGrid() {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 24,
      mainAxisSpacing: 24,
      shrinkWrap: true,
      childAspectRatio: 1.5,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        _buildVitalCard(
          title: 'Heart Rate',
          value: '72 bpm',
          patient: 'Eleanor Vance',
          icon: LucideIcons.heart,
          color: PrimeCareTheme.colors.royalPurple,
          time: '2 mins ago',
        ),
        _buildVitalCard(
          title: 'Blood Pressure',
          value: '120/80',
          patient: 'Eleanor Vance',
          icon: LucideIcons.activity,
          color: PrimeCareTheme.colors.emeraldTeal,
          time: '5 mins ago',
        ),
        _buildVitalCard(
          title: 'Temperature',
          value: '37.8 °C',
          patient: 'Sylvia Plath',
          icon: LucideIcons.thermometer,
          color: PrimeCareTheme.colors.amberWarning,
          isWarning: true,
          time: '12 mins ago',
        ),
        _buildVitalCard(
          title: 'Oxygen Saturation',
          value: '98%',
          patient: 'Arthur Dent',
          icon: LucideIcons.wind,
          color: PrimeCareTheme.colors.navyIndigo,
          time: '1 hour ago',
        ),
      ],
    );
  }

  Widget _buildVitalCard({
    required String title,
    required String value,
    required String patient,
    required IconData icon,
    required Color color,
    required String time,
    bool isWarning = false,
  }) {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      border: isWarning ? Border.all(color: color.withOpacity(0.5)) : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(icon, color: color, size: 20),
                  const SizedBox(width: 8),
                  Text(title, style: PrimeCareTheme.typography.h3),
                ],
              ),
              if (isWarning)
                Icon(LucideIcons.alertTriangle, color: color, size: 20),
            ],
          ),
          const Spacer(),
          Text(
            value,
            style: PrimeCareTheme.typography.heroTitle.copyWith(
              color: isWarning ? color : PrimeCareTheme.colors.navyIndigo,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(LucideIcons.user, size: 14, color: PrimeCareTheme.colors.slateGray),
                  const SizedBox(width: 4),
                  Text(patient, style: PrimeCareTheme.typography.body.copyWith(fontWeight: FontWeight.bold)),
                ],
              ),
              Text(time, style: PrimeCareTheme.typography.label.copyWith(color: PrimeCareTheme.colors.slateGray)),
            ],
          ),
        ],
      ),
    );
  }
}
