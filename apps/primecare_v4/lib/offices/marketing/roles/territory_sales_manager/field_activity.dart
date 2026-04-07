import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:primecare_v4/shared/components/page_template.dart';

class TerritoryFieldActivityScreen extends ConsumerWidget {
  const TerritoryFieldActivityScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'Field Activity',
      subtitle: 'Live tracking of local marketing managers and sales reps in the field.',
      headerTrailing: Row(
        children: [
          ClinicalGlassButton(
            onPressed: () {},
            icon: LucideIcons.filter,
            label: 'Filter Staff',
            isPrimary: false,
          ),
          const SizedBox(width: 16),
          ClinicalGlassButton(
            onPressed: () {},
            icon: LucideIcons.plus,
            label: 'Log Activity',
            isPrimary: true,
          ),
        ],
      ),
      kpiCards: [
        KPICardData(
          title: 'Active Reps',
          value: '8',
          icon: LucideIcons.users,
          trend: 0.0,
          trendLabel: 'on field today',
          color: PrimeCareTheme.colors.navyIndigo,
        ),
        KPICardData(
          title: 'Meetings Today',
          value: '45',
          icon: LucideIcons.calendarCheck,
          trend: 12.0,
          trendLabel: 'vs yesterday',
          color: PrimeCareTheme.colors.emeraldTeal,
        ),
        KPICardData(
          title: 'Drop-offs',
          value: '18',
          icon: LucideIcons.package,
          trend: -2.0,
          trendLabel: 'vs target',
          color: PrimeCareTheme.colors.slateGray,
        ),
        KPICardData(
          title: 'Target Reached',
          value: '82%',
          icon: LucideIcons.target,
          trend: 5.0,
          trendLabel: 'overall performance',
          color: PrimeCareTheme.colors.emeraldTeal,
        ),
      ],
      mainContent: [
        ClinicalGlassPanel(
          padding: EdgeInsets.zero,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 350,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: PrimeCareTheme.colors.surfaceContainerHighest.withValues(
                        alpha: 0.3,
                      ),
                      borderRadius: BorderRadius.circular(24),
                      image: const DecorationImage(
                        image: NetworkImage(
                          'https://maps.googleapis.com/maps/api/staticmap?center=40.7128,-74.0060&zoom=11&size=800x400&style=feature:all|element:labels.text.fill|color:0x333333&style=feature:water|element:geometry|color:0xdddddd&sensor=false',
                        ),
                        fit: BoxFit.cover,
                        opacity: 0.4,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 24,
                    left: 24,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.9),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Icon(
                            LucideIcons.mapPin,
                            size: 16,
                            color: PrimeCareTheme.colors.emeraldTeal,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Active Field Staff: 8',
                            style: PrimeCareTheme.typography.label.copyWith(
                              color: PrimeCareTheme.colors.navyIndigo,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  _buildMapPin(top: 100, left: 200, label: 'MJ', isActive: true),
                  _buildMapPin(top: 150, left: 350, label: 'SL', isActive: true),
                  _buildMapPin(top: 250, left: 180, label: 'RK', isActive: false),
                  _buildMapPin(top: 80, left: 450, label: 'JD', isActive: true),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Live Activity Feed',
                      style: PrimeCareTheme.typography.h3.copyWith(
                        color: PrimeCareTheme.colors.navyIndigo,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildActivityItem(
                      time: '14:32',
                      repName: 'Sarah Jenkins',
                      action: 'Facility Tour Completed',
                      target: 'Dr. Robert Smith (Cardiology)',
                      type: 'Meeting',
                      isSuccess: true,
                    ),
                    _buildActivityTimelineSeparator(),
                    _buildActivityItem(
                      time: '13:15',
                      repName: 'Michael Chang',
                      action: 'Dropped off collateral',
                      target: 'Sunrise Assisted Living',
                      type: 'Drop-off',
                      isSuccess: true,
                    ),
                    _buildActivityTimelineSeparator(),
                    _buildActivityItem(
                      time: '11:45',
                      repName: 'Aisha Patel',
                      action: 'Follow-up Call',
                      target: 'Oakridge Family Practice',
                      type: 'Call',
                      isSuccess: false,
                    ),
                    _buildActivityTimelineSeparator(),
                    _buildActivityItem(
                      time: '09:30',
                      repName: 'Sarah Jenkins',
                      action: 'Lunch & Learn Scheduled',
                      target: 'Mercy Hospital Admin Team',
                      type: 'Milestone',
                      isSuccess: true,
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Top Performers',
                    style: PrimeCareTheme.typography.h3.copyWith(
                      color: PrimeCareTheme.colors.navyIndigo,
                    ),
                  ),
                  Icon(LucideIcons.award, size: 20, color: Colors.amber.shade700),
                ],
              ),
              const SizedBox(height: 24),
              _buildPerformerRow(
                rank: 1,
                name: 'Sarah Jenkins',
                metrics: '45 meetings / 12 conv.',
                isTop: true,
              ),
              const SizedBox(height: 20),
              _buildPerformerRow(
                rank: 2,
                name: 'Michael Chang',
                metrics: '38 meetings / 9 conv.',
                isTop: false,
              ),
              const SizedBox(height: 20),
              _buildPerformerRow(
                rank: 3,
                name: 'David Rossi',
                metrics: '35 meetings / 6 conv.',
                isTop: false,
              ),
              const SizedBox(height: 20),
              _buildPerformerRow(
                rank: 4,
                name: 'Aisha Patel',
                metrics: '30 meetings / 5 conv.',
                isTop: false,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMapPin({
    required double top,
    required double left,
    required String label,
    required bool isActive,
  }) {
    Color pinColor = isActive
        ? PrimeCareTheme.colors.emeraldTeal
        : PrimeCareTheme.colors.slateGray;
    return Positioned(
      top: top,
      left: left,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: pinColor.withValues(alpha: 0.3),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: CircleAvatar(
              radius: 12,
              backgroundColor: pinColor,
              child: Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 2),
          Icon(LucideIcons.mapPin, size: 16, color: pinColor),
        ],
      ),
    );
  }

  Widget _buildActivityTimelineSeparator() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 19,
      ),
      child: Container(
        height: 24,
        width: 2,
        color: PrimeCareTheme.colors.surfaceContainerHighest,
      ),
    );
  }

  Widget _buildActivityItem({
    required String time,
    required String repName,
    required String action,
    required String target,
    required String type,
    required bool isSuccess,
  }) {
    IconData typeIcon;
    if (type == 'Meeting') typeIcon = LucideIcons.users;
    else if (type == 'Drop-off') typeIcon = LucideIcons.package;
    else if (type == 'Call') typeIcon = LucideIcons.phone;
    else typeIcon = LucideIcons.flag;

    Color stateColor = isSuccess
        ? PrimeCareTheme.colors.emeraldTeal
        : PrimeCareTheme.colors.slateGray;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 50,
          child: Text(
            time,
            style: PrimeCareTheme.typography.label.copyWith(
              color: PrimeCareTheme.colors.slateGray,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: stateColor.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(typeIcon, size: 16, color: stateColor),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    repName,
                    style: PrimeCareTheme.typography.h4.copyWith(
                      color: PrimeCareTheme.colors.navyIndigo,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text('•', style: TextStyle(color: Colors.grey)),
                  ),
                  Text(
                    action,
                    style: PrimeCareTheme.typography.body.copyWith(
                      color: PrimeCareTheme.colors.navyIndigo,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                '@ $target',
                style: PrimeCareTheme.typography.label.copyWith(
                  color: PrimeCareTheme.colors.slateGray,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPerformerRow({
    required int rank,
    required String name,
    required String metrics,
    required bool isTop,
  }) {
    return Row(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: isTop
                ? Colors.amber.shade700.withValues(alpha: 0.1)
                : PrimeCareTheme.colors.surfaceContainerHighest,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
               rank.toString(),
              style: PrimeCareTheme.typography.label.copyWith(
                color: isTop
                    ? Colors.amber.shade700
                    : PrimeCareTheme.colors.slateGray,
                fontWeight: FontWeight.bold,
                fontSize: 11,
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: PrimeCareTheme.typography.h4.copyWith(
                  color: PrimeCareTheme.colors.navyIndigo,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                metrics,
                style: PrimeCareTheme.typography.label.copyWith(
                  color: PrimeCareTheme.colors.slateGray,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
        IconButton(
          icon: Icon(
            LucideIcons.chevronRight,
            size: 16,
            color: PrimeCareTheme.colors.slateGray,
          ),
          onPressed: () {},
        ),
      ],
    );
  }
}
