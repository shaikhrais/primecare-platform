import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:primecare_v4/shared/components/page_template.dart';

class CertificationsScreen extends ConsumerWidget {
  const CertificationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'Professional Certifications',
      subtitle:
          'Track in-house certification programs, external professional credits, and renewals.',
      headerTrailing: [
        ClinicalSearchTextField(hintText: 'Search certifications or staff...'),
        const SizedBox(width: 16),
        ClinicalGlassButton(
          onPressed: () {},
          label: 'Import Records',
          icon: LucideIcons.uploadCloud,
        ),
        const SizedBox(width: 12),
        ClinicalGlassButton(
          onPressed: () {},
          label: 'Add Certification',
          icon: LucideIcons.plus,
          isPrimary: true,
        ),
      ],
      kpiCards: [
        KPICardData(
          title: 'Active Certifications',
          value: '4,210',
          icon: LucideIcons.award,
          trend: 'Across 1,200 staff members',
          isUp: true,
          color: PrimeCareTheme.colors.navyIndigo,
        ),
        KPICardData(
          title: 'Expiring in 60 Days',
          value: '185',
          icon: LucideIcons.calendarMinus,
          trend: 'Focus on CPR/BLS renewals',
          isUp: false,
          color: PrimeCareTheme.colors.amberWarning,
        ),
        KPICardData(
          title: 'Expired / Lapsed',
          value: '12',
          icon: LucideIcons.xCircle,
          trend: 'Immediate action required',
          isUp: false,
          color: PrimeCareTheme.colors.coralRed,
        ),
      ],
      sidebarContent: [
        _buildCertificationDistribution(),
        const SizedBox(height: 24),
        _buildExpiringCritical(),
      ],
      mainContent: [_buildStaffCertificationList()],
    );
  }

  Widget _buildCertificationDistribution() {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                LucideIcons.pieChart,
                color: PrimeCareTheme.colors.navyIndigo,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Top Certifications (Active)',
                style: PrimeCareTheme.typography.h3,
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildCertStat('BLS / CPR', '1,180'),
          const SizedBox(height: 12),
          _buildCertStat('Infection Control Level 2', '950'),
          const SizedBox(height: 12),
          _buildCertStat('Advanced Cardiac (ACLS)', '320'),
          const SizedBox(height: 12),
          _buildCertStat('Gentle Persuasive App.', '640'),
        ],
      ),
    );
  }

  Widget _buildCertStat(String name, String count) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(name, style: PrimeCareTheme.typography.body),
        Text(
          count,
          style: PrimeCareTheme.typography.label.copyWith(
            color: PrimeCareTheme.colors.slateGray,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildExpiringCritical() {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      border: Border.all(
        color: PrimeCareTheme.colors.coralRed.withOpacity(0.3),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                LucideIcons.alertTriangle,
                color: PrimeCareTheme.colors.coralRed,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text('Critical Expiries', style: PrimeCareTheme.typography.h3),
            ],
          ),
          const SizedBox(height: 16),
          _buildCriticalItem(
            'MD License - Dr. E. Rostova',
            'Expired 2 days ago',
          ),
          const SizedBox(height: 12),
          _buildCriticalItem('ACLS - John Carmichael', 'Expires in 5 days'),
          const SizedBox(height: 12),
          _buildCriticalItem('BLS - Michael Ray', 'Expires in 7 days'),
        ],
      ),
    );
  }

  Widget _buildCriticalItem(String title, String status) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: PrimeCareTheme.typography.body.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          status,
          style: PrimeCareTheme.typography.label.copyWith(
            color: PrimeCareTheme.colors.coralRed,
          ),
        ),
      ],
    );
  }

  Widget _buildStaffCertificationList() {
    return ClinicalGlassPanel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Certification Tracking List',
                  style: PrimeCareTheme.typography.h2,
                ),
                ClinicalGlassButton(
                  onPressed: () {},
                  label: 'Filter: Expiring Soon',
                  icon: LucideIcons.filter,
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          _buildStaffCertItem(
            staffName: 'Amanda Rivera',
            role: 'RN',
            certName: 'Advanced Cardiac Life Support (ACLS)',
            provider: 'American Heart Association',
            issueDate: 'Jan 15, 2025',
            expiryDate: 'Jan 15, 2027',
            status: 'Active',
          ),
          const Divider(height: 1),
          _buildStaffCertItem(
            staffName: 'John Carmichael',
            role: 'RN',
            certName: 'Advanced Cardiac Life Support (ACLS)',
            provider: 'American Heart Association',
            issueDate: 'Nov 12, 2024',
            expiryDate: 'Nov 12, 2026',
            status: 'Expiring Soon',
          ),
          const Divider(height: 1),
          _buildStaffCertItem(
            staffName: 'Elena Rostova',
            role: 'MD',
            certName: 'State Medical Board License',
            provider: 'College of Physicians',
            issueDate: 'Oct 01, 2024',
            expiryDate: 'Oct 01, 2026',
            status: 'Grace Period',
          ),
        ],
      ),
    );
  }

  Widget _buildStaffCertItem({
    required String staffName,
    required String role,
    required String certName,
    required String provider,
    required String issueDate,
    required String expiryDate,
    required String status,
  }) {
    Color statusColor;
    if (status == 'Active') {
      statusColor = PrimeCareTheme.colors.emeraldTeal;
    } else if (status == 'Grace Period') {
      statusColor = PrimeCareTheme.colors.coralRed;
    } else {
      statusColor = PrimeCareTheme.colors.amberWarning;
    }

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              status == 'Active'
                  ? LucideIcons.checkCircle
                  : LucideIcons.alertCircle,
              color: statusColor,
              size: 20,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(certName, style: PrimeCareTheme.typography.h3),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      LucideIcons.user,
                      size: 14,
                      color: PrimeCareTheme.colors.slateGray,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '$staffName ($role)',
                      style: PrimeCareTheme.typography.body.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Icon(
                      LucideIcons.building,
                      size: 14,
                      color: PrimeCareTheme.colors.slateGray,
                    ),
                    const SizedBox(width: 4),
                    Text(provider, style: PrimeCareTheme.typography.label),
                  ],
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                status,
                style: PrimeCareTheme.typography.body.copyWith(
                  fontWeight: FontWeight.bold,
                  color: statusColor,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Expires: $expiryDate',
                style: PrimeCareTheme.typography.label.copyWith(
                  color: PrimeCareTheme.colors.slateGray,
                ),
              ),
              const SizedBox(height: 12),
              ClinicalGlassButton(
                onPressed: () {},
                label: 'View Certificate',
                icon: LucideIcons.fileImage,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
