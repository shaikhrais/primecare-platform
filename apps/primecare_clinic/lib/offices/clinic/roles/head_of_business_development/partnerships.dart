import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/shared/components/page_template.dart';

class PartnershipsScreen extends ConsumerWidget {
  const PartnershipsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'Strategic Partnerships',
      subtitle: 'Manage relationships with external healthcare organizations.',
      kpiCards: [
        KPICardData(
          title: 'Active Partnerships',
          value: '28',
          icon: Icons.handshake,
          trend: 12.0,
          trendLabel: 'increase YTD',
        ),
        KPICardData(
          title: 'Joint Revenue',
          value: '\$2.4M',
          icon: LucideIcons.dollarSign,
          trend: 8.5,
          trendLabel: 'vs last quarter',
        ),
        KPICardData(
          title: 'Pending Renewals',
          value: '4',
          icon: LucideIcons.fileClock,
          trend: 0.0,
          trendLabel: 'within 30 days',
        ),
        KPICardData(
          title: 'Referral Volume',
          value: '1.2K',
          icon: LucideIcons.users,
          trend: 15.2,
          trendLabel: 'via partners',
        ),
      ],
      sidebarContent: [
        ClinicalGlassPanel(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Partnership Types', style: PrimeCareTheme.typography.h3),
              const SizedBox(height: 16),
              _buildTypeRow('Hospitals & Clinics', '12'),
              _buildTypeRow('Insurance Providers', '8'),
              _buildTypeRow('Technology Vendors', '5'),
              _buildTypeRow('Educational Inst.', '3'),
            ],
          ),
        ),
      ],
      mainContent: [
        ClinicalGlassPanel(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Key Partner Accounts',
                    style: PrimeCareTheme.typography.h2,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(LucideIcons.plus, size: 16),
                    label: const Text('New Partner'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: PrimeCareTheme.colors.navyIndigo,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _buildPartnerCard(
                'General Hospital Network',
                'Hospitals & Clinics',
                'Active - Key Tier',
                '14.5%',
                'Renegotiating referral rates for Q3.',
                LucideIcons.building2,
              ),
              _buildPartnerCard(
                'MediLife Insurance',
                'Insurance Provider',
                'Active - Standard',
                '8.2%',
                'Integrated billing API successful.',
                LucideIcons.shield,
              ),
              _buildPartnerCard(
                'HealthTech Solutions',
                'Technology Vendor',
                'Review Pending',
                'N/A',
                'Contract expires in 15 days. Need to review SLA.',
                LucideIcons.monitorSmartphone,
              ),
              _buildPartnerCard(
                'University Medical School',
                'Educational Inst.',
                'Active - Pilot',
                'Indirect',
                'Student placement program launching next month.',
                LucideIcons.graduationCap,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTypeRow(String type, String count) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(type, style: PrimeCareTheme.typography.body),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
            decoration: BoxDecoration(
              color: PrimeCareTheme.colors.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(count, style: PrimeCareTheme.typography.label),
          ),
        ],
      ),
    );
  }

  Widget _buildPartnerCard(
    String name,
    String type,
    String status,
    String revShare,
    String notes,
    IconData icon,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: PrimeCareTheme.colors.surfaceContainerHighest.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: PrimeCareTheme.colors.surfaceContainerHighest,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: PrimeCareTheme.colors.navyIndigo.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: PrimeCareTheme.colors.navyIndigo),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name, style: PrimeCareTheme.typography.h3),
                      const SizedBox(height: 4),
                      Text(
                        type,
                        style: PrimeCareTheme.typography.label.copyWith(
                          color: PrimeCareTheme.colors.slateGray,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Status',
                  style: PrimeCareTheme.typography.label.copyWith(
                    color: PrimeCareTheme.colors.slateGray,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  status,
                  style: PrimeCareTheme.typography.body.copyWith(
                    color: status.contains('Active')
                        ? PrimeCareTheme.colors.emeraldTeal
                        : PrimeCareTheme.colors.coralRed,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Rev. Share',
                  style: PrimeCareTheme.typography.label.copyWith(
                    color: PrimeCareTheme.colors.slateGray,
                  ),
                ),
                const SizedBox(height: 4),
                Text(revShare, style: PrimeCareTheme.typography.body),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Latest Note',
                  style: PrimeCareTheme.typography.label.copyWith(
                    color: PrimeCareTheme.colors.slateGray,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  notes,
                  style: PrimeCareTheme.typography.label.copyWith(
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.right,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
