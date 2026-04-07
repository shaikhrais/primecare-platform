import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:primecare_v4/shared/components/page_template.dart';

class CredentialTrackingScreen extends ConsumerWidget {
  const CredentialTrackingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'Credential Tracking',
      subtitle:
          'Monitor staff certifications, licenses, and background checks compliances across facilities.',
      headerTrailing: [
        ClinicalSearchTextField(
          hintText: 'Search by staff name, ID, or credential type...',
        ),
        const SizedBox(width: 16),
        ClinicalGlassButton(
          onPressed: () {},
          label: 'Scan Document',
          icon: LucideIcons.scanLine,
          isPrimary: true,
        ),
      ],
      kpiCards: [
        MetricCardData(
          title: 'Expiring (<30 days)',
          value: '28',
          icon: LucideIcons.calendarX,
          trend: '+4 from last week',
          isUp: false,
          color: PrimeCareTheme.colors.amberWarning,
        ),
        MetricCardData(
          title: 'Expired Credentials',
          value: '3',
          icon: LucideIcons.xOctagon,
          trend: 'Requires immediate action',
          isUp: false,
          color: PrimeCareTheme.colors.coralRed,
        ),
        MetricCardData(
          title: 'Total Compliance',
          value: '98.5%',
          icon: LucideIcons.shieldCheck,
          trend: 'Above 95% target',
          isUp: true,
          color: PrimeCareTheme.colors.emeraldTeal,
        ),
      ],
      sidebarContent: [
        _buildActionRequiredPanel(),
        const SizedBox(height: 24),
        _buildCredentialTypes(),
      ],
      mainContent: [_buildStaffCredentialList()],
    );
  }

  Widget _buildActionRequiredPanel() {
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
                LucideIcons.alertCircle,
                color: PrimeCareTheme.colors.coralRed,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text('Expired / Suspended', style: PrimeCareTheme.typography.h3),
            ],
          ),
          const SizedBox(height: 16),
          _buildActionItem('Sarah Jenkins (RN)', 'Nursing License (Expired)'),
          const SizedBox(height: 12),
          _buildActionItem('Michael Ray (PSW)', 'CPR Cert (Expired)'),
          const SizedBox(height: 12),
          _buildActionItem('Elena Rostova (MD)', 'Board Cert (Pending Review)'),
        ],
      ),
    );
  }

  Widget _buildActionItem(String name, String detail) {
    return Row(
      children: [
        Icon(
          LucideIcons.userX,
          size: 16,
          color: PrimeCareTheme.colors.coralRed,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: PrimeCareTheme.typography.body.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                detail,
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

  Widget _buildCredentialTypes() {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                LucideIcons.files,
                color: PrimeCareTheme.colors.navyIndigo,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text('Monitored Types', style: PrimeCareTheme.typography.h3),
            ],
          ),
          const SizedBox(height: 16),
          _buildTypeRow('State Nursing License', '420 Active'),
          const SizedBox(height: 12),
          _buildTypeRow('BLS/CPR Certification', '850 Active'),
          const SizedBox(height: 12),
          _buildTypeRow('DEA Registration', '12 Active'),
          const SizedBox(height: 12),
          _buildTypeRow('Background Check (Level 2)', '880 Active'),
        ],
      ),
    );
  }

  Widget _buildTypeRow(String type, String count) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(type, style: PrimeCareTheme.typography.body),
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

  Widget _buildStaffCredentialList() {
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
                  'Upcoming Expirations',
                  style: PrimeCareTheme.typography.h2,
                ),
                ClinicalGlassButton(
                  onPressed: () {},
                  label: 'Send Reminders',
                  icon: LucideIcons.mail,
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          _buildCredentialRow(
            name: 'Dr. John Smith',
            role: 'Physician',
            credential: 'State Medical License',
            number: 'MD-59201A',
            expiryDate: 'Nov 15, 2026',
            daysLeft: 14,
          ),
          const Divider(height: 1),
          _buildCredentialRow(
            name: 'Amanda Rivera',
            role: 'Registered Nurse',
            credential: 'BLS Certification',
            number: 'BLS-2024-9182',
            expiryDate: 'Nov 18, 2026',
            daysLeft: 17,
          ),
          const Divider(height: 1),
          _buildCredentialRow(
            name: 'David Okafor',
            role: 'Physical Therapist',
            credential: 'State PT License',
            number: 'PT-9912',
            expiryDate: 'Nov 29, 2026',
            daysLeft: 28,
          ),
        ],
      ),
    );
  }

  Widget _buildCredentialRow({
    required String name,
    required String role,
    required String credential,
    required String number,
    required String expiryDate,
    required int daysLeft,
  }) {
    final isCritical = daysLeft <= 15;
    final color = isCritical
        ? PrimeCareTheme.colors.coralRed
        : PrimeCareTheme.colors.amberWarning;

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(LucideIcons.alertTriangle, color: color, size: 20),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(name, style: PrimeCareTheme.typography.h3),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: PrimeCareTheme.colors.cloudGray,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(role, style: PrimeCareTheme.typography.label),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      LucideIcons.fileText,
                      size: 14,
                      color: PrimeCareTheme.colors.slateGray,
                    ),
                    const SizedBox(width: 4),
                    Text(credential, style: PrimeCareTheme.typography.body),
                    const SizedBox(width: 16),
                    Icon(
                      LucideIcons.hash,
                      size: 14,
                      color: PrimeCareTheme.colors.slateGray,
                    ),
                    const SizedBox(width: 4),
                    Text(number, style: PrimeCareTheme.typography.label),
                  ],
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Expires in $daysLeft days',
                style: PrimeCareTheme.typography.body.copyWith(
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                expiryDate,
                style: PrimeCareTheme.typography.label.copyWith(
                  color: PrimeCareTheme.colors.slateGray,
                ),
              ),
              const SizedBox(height: 12),
              ClinicalGlassButton(
                onPressed: () {},
                label: 'Verify Renewal',
                icon: LucideIcons.checkCircle,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
