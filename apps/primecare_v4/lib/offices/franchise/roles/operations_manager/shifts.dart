import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/shared/components/page_template.dart';

class ShiftsScreen extends ConsumerWidget {
  const ShiftsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'Live Dispatch & Shifts',
      subtitle:
          'Real-time tracking of caregivers in the field and active shift progress.',
      headerTrailing: Row(
        children: [
          ClinicalGlassButton(
            label: 'GPS Settings',
            icon: LucideIcons.mapPin,
            onPressed: () {},
            isPrimary: false,
          ),
          const SizedBox(width: 12),
          ClinicalGlassButton(
            label: 'Broadcast Message',
            icon: LucideIcons.radio,
            onPressed: () {},
            isPrimary: true,
          ),
        ],
      ),
      kpiCards: [
        KPICardData(
          title: 'Active in Field',
          value: '38',
          icon: LucideIcons.car,
          trend: 0.0,
          trendLabel: 'Currently dispatched',
          color: PrimeCareTheme.colors.emeraldTeal,
        ),
        KPICardData(
          title: 'En Route',
          value: '12',
          icon: LucideIcons.navigation,
          trend: 0.0,
          trendLabel: 'To next client',
          color: PrimeCareTheme.colors.navyIndigo,
        ),
        KPICardData(
          title: 'Off Route / Idle',
          value: '2',
          icon: LucideIcons.mapPinOff,
          trend: -15.0,
          trendLabel: '> 15m delay',
          color: PrimeCareTheme.colors.coralRed,
          isUp: false,
        ),
        KPICardData(
          title: 'Avg ETA Accuracy',
          value: '94%',
          icon: LucideIcons.timer,
          trend: 1.0,
          trendLabel: 'vs target',
          color: PrimeCareTheme.colors.emeraldTeal,
        ),
      ],
      mainContent: [
        ClinicalGlassPanel(
          padding: const EdgeInsets.all(0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Live Fleet Telemetry (Map View)',
                      style: PrimeCareTheme.typography.h2,
                    ),
                    Row(
                      children: [
                        const Icon(
                          LucideIcons.satellite,
                          color: PrimeCareTheme.colors.emeraldTeal,
                          size: 16,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Connected',
                          style: PrimeCareTheme.typography.label.copyWith(
                            color: PrimeCareTheme.colors.emeraldTeal,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                height: 350,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: PrimeCareTheme.colors.surfaceContainerHighest
                      .withOpacity(0.3),
                  image: const DecorationImage(
                    image: NetworkImage(
                      'https://images.unsplash.com/photo-1524661135-423995f22d0b?auto=format&fit=crop&q=80&w=1200',
                    ),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Colors.black54,
                      BlendMode.darken,
                    ),
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        LucideIcons.map,
                        size: 48,
                        color: PrimeCareTheme.colors.emeraldTeal.withOpacity(
                          0.8,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'GIS Rendering Engine initializing...',
                        style: PrimeCareTheme.typography.label.copyWith(
                          color: PrimeCareTheme.colors.slateGray,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        ClinicalGlassPanel(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Active Staff in Field',
                    style: PrimeCareTheme.typography.h3,
                  ),
                  const Icon(LucideIcons.moreHorizontal, color: Colors.white70),
                ],
              ),
              const SizedBox(height: 24),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  headingTextStyle: PrimeCareTheme.typography.label.copyWith(
                    fontWeight: FontWeight.w600,
                    color: PrimeCareTheme.colors.slateGray,
                  ),
                  dataTextStyle: PrimeCareTheme.typography.body,
                  columns: const [
                    DataColumn(label: Text('Staff Member')),
                    DataColumn(label: Text('Client ETA')),
                    DataColumn(label: Text('Progress')),
                    DataColumn(label: Text('Action')),
                  ],
                  rows: [
                    _buildDataRow(
                      'Sarah Jenkins (RN)',
                      'Arrived 10m ago',
                      0.8,
                      PrimeCareTheme.colors.emeraldTeal,
                    ),
                    _buildDataRow(
                      'Mike Ross (PSW)',
                      'ETA 15m (On Time)',
                      0.3,
                      Colors.blue,
                    ),
                    _buildDataRow(
                      'Lisa Wong (LPN)',
                      'ETA 2m (Late)',
                      0.9,
                      Colors.orange,
                    ),
                    _buildDataRow(
                      'John Smith (PSW)',
                      'Idle > 10m',
                      0.1,
                      PrimeCareTheme.colors.coralRed,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
      sidebarContent: [
        ClinicalGlassPanel(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    LucideIcons.route,
                    color: PrimeCareTheme.colors.emeraldTeal,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Text('Route Efficiency', style: PrimeCareTheme.typography.h3),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: _buildCategoryBar(
                      'Optimal',
                      65,
                      PrimeCareTheme.colors.emeraldTeal,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildCategoryBar('Sub-Opt.', 25, Colors.orange),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildCategoryBar('Re-routed', 10, Colors.blue),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Text(
                'AI suggestions saved 14h of total drive time today.',
                style: PrimeCareTheme.typography.label.copyWith(
                  color: PrimeCareTheme.colors.slateGray,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        ClinicalGlassPanel(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    LucideIcons.activitySquare,
                    color: Colors.blue,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Live Shift Events',
                    style: PrimeCareTheme.typography.h3,
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _buildEventItem(
                'S. Jenkins Completed Care',
                'Client: Jane Doe',
                'Just now',
              ),
              const Divider(color: Colors.white12, height: 24),
              _buildEventItem(
                'M. Ross Started Travel',
                'Dest: Appt #452',
                '10m ago',
              ),
              const Divider(color: Colors.white12, height: 24),
              _buildEventItem(
                'L. Wong SOS Ping',
                'Manual check-in required',
                '12m ago',
                isAlert: true,
              ),
            ],
          ),
        ),
      ],
    );
  }

  DataRow _buildDataRow(
    String name,
    String status,
    double progress,
    Color statusColor,
  ) {
    return DataRow(
      cells: [
        DataCell(
          Text(name, style: const TextStyle(fontWeight: FontWeight.w500)),
        ),
        DataCell(
          Text(
            status,
            style: TextStyle(color: statusColor, fontWeight: FontWeight.bold),
          ),
        ),
        DataCell(
          SizedBox(
            width: 150,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: PrimeCareTheme.colors.surfaceContainerHighest,
                valueColor: AlwaysStoppedAnimation<Color>(statusColor),
                minHeight: 6,
              ),
            ),
          ),
        ),
        DataCell(
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(
              LucideIcons.messageSquare,
              size: 14,
              color: Colors.white70,
            ),
            label: const Text(
              'Comms',
              style: TextStyle(color: Colors.white70, fontSize: 12),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryBar(String label, double height, Color color) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          '${height.toInt()}%',
          style: PrimeCareTheme.typography.label.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: height * 2,
          decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(4),
              topRight: Radius.circular(4),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          textAlign: TextAlign.center,
          style: PrimeCareTheme.typography.label.copyWith(
            color: PrimeCareTheme.colors.slateGray,
            fontSize: 11,
          ),
        ),
      ],
    );
  }

  Widget _buildEventItem(
    String title,
    String subtitle,
    String time, {
    bool isAlert = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isAlert
                ? PrimeCareTheme.colors.coralRed.withOpacity(0.2)
                : PrimeCareTheme.colors.surfaceContainerHighest.withOpacity(
                    0.5,
                  ),
            shape: BoxShape.circle,
          ),
          child: Icon(
            isAlert ? LucideIcons.alertCircle : LucideIcons.checkCircle,
            size: 16,
            color: isAlert ? PrimeCareTheme.colors.coralRed : Colors.white,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: PrimeCareTheme.typography.body.copyWith(
                  color: isAlert
                      ? PrimeCareTheme.colors.coralRed
                      : Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    subtitle,
                    style: PrimeCareTheme.typography.label.copyWith(
                      color: PrimeCareTheme.colors.slateGray,
                    ),
                  ),
                  Text(
                    time,
                    style: PrimeCareTheme.typography.label.copyWith(
                      color: PrimeCareTheme.colors.slateGray,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
