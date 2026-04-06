import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/shared/components/page_template.dart';

class PatientHealthRecordsScreen extends ConsumerStatefulWidget {
  const PatientHealthRecordsScreen({super.key});

  @override
  ConsumerState<PatientHealthRecordsScreen> createState() => _PatientHealthRecordsScreenState();
}

class _PatientHealthRecordsScreenState extends ConsumerState<PatientHealthRecordsScreen> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'My Health Records',
      subtitle: 'Secure access to your test results, prescriptions, and visit summaries',
      icon: LucideIcons.folderHeart,
      actions: [
        Container(
          decoration: BoxDecoration(
            color: PrimeCareTheme.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(PrimeCareTheme.radiusLg),
            boxShadow: [
               BoxShadow(
                 color: PrimeCareTheme.primary.withOpacity(0.05),
                 blurRadius: 12,
                 offset: const Offset(0, 4)
               ),
            ]
          ),
          child: TextButton.icon(
            onPressed: () {},
            icon: const Icon(LucideIcons.downloadCloud, size: 18, color: PrimeCareTheme.primary),
            label: Text('Download History', style: PrimeCareTheme.titleSmall.copyWith(color: PrimeCareTheme.primary)),
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: PrimeCareTheme.spacing5, vertical: PrimeCareTheme.spacing3),
            ),
          ),
        ),
      ],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Custom Tab Navigation
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: PrimeCareTheme.surfaceContainerHigh.withOpacity(0.3),
              borderRadius: BorderRadius.circular(PrimeCareTheme.radiusXl),
            ),
            child: Row(
              children: [
                Expanded(child: _buildTabButton(0, 'Lab Results', LucideIcons.flaskConical)),
                Expanded(child: _buildTabButton(1, 'Prescriptions', LucideIcons.pill)),
                Expanded(child: _buildTabButton(2, 'Visit Summaries', LucideIcons.fileText)),
              ],
            ),
          ),
          const SizedBox(height: PrimeCareTheme.spacing6),
          
          // Tab Content
          Expanded(
            child: SingleChildScrollView(
              child: _buildTabContent(),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTabButton(int index, String title, IconData icon) {
    final isSelected = _selectedTab == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedTab = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: PrimeCareTheme.spacing3),
        decoration: BoxDecoration(
          color: isSelected ? PrimeCareTheme.surfaceContainerLowest : Colors.transparent,
          borderRadius: BorderRadius.circular(PrimeCareTheme.radiusLg),
          boxShadow: isSelected ? [
            BoxShadow(
              color: PrimeCareTheme.primary.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            )
          ] : [],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 18,
              color: isSelected ? PrimeCareTheme.primary : PrimeCareTheme.onSurfaceVariant,
            ),
            const SizedBox(width: PrimeCareTheme.spacing2),
            Text(
              title,
              style: PrimeCareTheme.titleSmall.copyWith(
                color: isSelected ? PrimeCareTheme.onSurface : PrimeCareTheme.onSurfaceVariant,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabContent() {
    switch (_selectedTab) {
      case 0:
        return _buildLabResultsView();
      case 1:
        return _buildPrescriptionsView();
      case 2:
        return _buildVisitSummariesView();
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildLabResultsView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildRecordCard(
          title: 'Comprehensive Metabolic Panel',
          date: 'Oct 1, 2026',
          provider: 'PrimeCare Central Lab',
          icon: LucideIcons.flaskConical,
          status: 'Review Complete',
          statusColor: PrimeCareTheme.tertiary,
          actionLabel: 'View Results',
        ),
        const SizedBox(height: PrimeCareTheme.spacing4),
        _buildRecordCard(
          title: 'Lipid Panel',
          date: 'Jun 12, 2026',
          provider: 'PrimeCare Central Lab',
          icon: LucideIcons.activity,
          status: 'Review Complete',
          statusColor: PrimeCareTheme.tertiary,
          actionLabel: 'View Results',
        ),
      ],
    );
  }

  Widget _buildPrescriptionsView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildRecordCard(
          title: 'Atorvastatin 20mg',
          date: 'Active',
          provider: 'Prescribed by Dr. Emily Chen',
          icon: LucideIcons.pill,
          status: '2 Refills Remaining',
          statusColor: PrimeCareTheme.primary,
          actionLabel: 'Request Refill',
        ),
        const SizedBox(height: PrimeCareTheme.spacing4),
        _buildRecordCard(
          title: 'Amoxicillin 500mg',
          date: 'Completed - Sep 2026',
          provider: 'Prescribed by Dr. Emily Chen',
          icon: LucideIcons.pill,
          status: 'Finished',
          statusColor: PrimeCareTheme.onSurfaceVariant,
          actionLabel: 'View Details',
        ),
      ],
    );
  }

  Widget _buildVisitSummariesView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildRecordCard(
          title: 'Annual Physical Checkup',
          date: 'Oct 5, 2026',
          provider: 'Dr. Emily Chen',
          icon: LucideIcons.stethoscope,
          status: 'Summary Available',
          statusColor: PrimeCareTheme.secondary,
          actionLabel: 'Read Summary',
        ),
        const SizedBox(height: PrimeCareTheme.spacing4),
        _buildRecordCard(
          title: 'Physiotherapy Consultation',
          date: 'Aug 22, 2026',
          provider: 'Sarah Smith, PT',
          icon: LucideIcons.activity,
          status: 'Exercises Updated',
          statusColor: PrimeCareTheme.secondary,
          actionLabel: 'View Plan',
        ),
      ],
    );
  }

  Widget _buildRecordCard({
    required String title,
    required String date,
    required String provider,
    required IconData icon,
    required String status,
    required Color statusColor,
    required String actionLabel,
  }) {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(PrimeCareTheme.spacing5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: PrimeCareTheme.surfaceContainerHigh.withOpacity(0.5),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: PrimeCareTheme.primary, size: 28),
          ),
          const SizedBox(width: PrimeCareTheme.spacing5),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: PrimeCareTheme.titleMedium),
                const SizedBox(height: PrimeCareTheme.spacing1),
                Text(provider, style: PrimeCareTheme.bodyMedium.copyWith(color: PrimeCareTheme.onSurfaceVariant)),
                const SizedBox(height: PrimeCareTheme.spacing2),
                Row(
                  children: [
                    Text(date, style: PrimeCareTheme.labelMedium.copyWith(color: PrimeCareTheme.onSurfaceVariant)),
                    const SizedBox(width: PrimeCareTheme.spacing3),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: statusColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        status,
                        style: PrimeCareTheme.labelSmall.copyWith(color: statusColor, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              backgroundColor: PrimeCareTheme.primaryContainer,
              padding: const EdgeInsets.symmetric(horizontal: PrimeCareTheme.spacing4, vertical: PrimeCareTheme.spacing3),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(PrimeCareTheme.radiusMd)),
            ),
            child: Text(actionLabel, style: PrimeCareTheme.titleSmall.copyWith(color: PrimeCareTheme.primary)),
          )
        ],
      ),
    );
  }
}
