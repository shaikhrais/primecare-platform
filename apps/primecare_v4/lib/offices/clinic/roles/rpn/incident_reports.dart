import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/shared/components/page_template.dart';

class RpnIncidentReportsScreen extends ConsumerWidget {
  const RpnIncidentReportsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'Incident Reports',
      subtitle: 'Log, track, and review clinical incidents and near misses.',
      kpiCards: [
        KPICardData(
          title: 'Total Incidents',
          value: '4',
          icon: LucideIcons.fileWarning,
          trend: 0.0,
          trendLabel: 'this month',
        ),
        KPICardData(
          title: 'Critical Severity',
          value: '1',
          icon: LucideIcons.alertTriangle,
          trend: 1.0,
          trendLabel: 'requires action',
        ),
        KPICardData(
          title: 'Resolved',
          value: '3',
          icon: LucideIcons.checkCircle,
          trend: 0.0,
          trendLabel: 'closed status',
        ),
      ],
      sidebarContent: [
        ClinicalGlassPanel(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      PrimeCareTheme.colors.primary,
                      PrimeCareTheme.colors.primaryContainer,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(LucideIcons.plus, color: Colors.white),
                  label: const Text(
                    'File New Report',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Text('Filter by Status', style: PrimeCareTheme.typography.h3),
              const SizedBox(height: 16),
              _buildFilterOption(
                'Under Investigation',
                1,
                PrimeCareTheme.colors.secondary,
              ),
              _buildFilterOption(
                'Requires Review',
                0,
                PrimeCareTheme.colors.error,
              ),
              _buildFilterOption(
                'Closed / Resolved',
                3,
                PrimeCareTheme.colors.tertiary,
              ),
            ],
          ),
        ),
      ],
      mainContent: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 16.0,
              ),
              child: Text(
                'Recent Incident Reports',
                style: PrimeCareTheme.typography.h2,
              ),
            ),
            _buildIncidentCard(
              incidentId: 'INC-2024-089',
              type: 'Medication Administration Error',
              patientName: 'Arthur Dent',
              location: 'Room 201-B',
              date: 'Today, 11:30 AM',
              summary:
                  'Incorrect dosage of Lisinopril prepared. Error caught globally during secondary check. No medication administered to patient.',
              status: 'Under Investigation',
              severity: 'Critical',
              themeColor: PrimeCareTheme.colors.error,
            ),
            const SizedBox(height: 16),
            _buildIncidentCard(
              incidentId: 'INC-2024-085',
              type: 'Patient Fall (Unwitnessed)',
              patientName: 'Maria Garcia',
              location: 'Bathroom 201',
              date: 'Yesterday, 02:15 AM',
              summary:
                  'Patient found on bathroom floor. Denies pain or hitting head. Vitals within normal limits. Post-fall protocol initiated.',
              status: 'Resolved',
              severity: 'Moderate',
              themeColor: PrimeCareTheme.colors.secondary,
            ),
            const SizedBox(height: 16),
            _buildIncidentCard(
              incidentId: 'INC-2024-081',
              type: 'Equipment Failure',
              patientName: 'Ward-Wide',
              location: 'IV Pump Station',
              date: 'May 10, 09:00 AM',
              summary:
                  'Infusion pump #1224 failed self-test during setup. Tagged and removed from service. Backup pump utilized without delay in care.',
              status: 'Resolved',
              severity: 'Low',
              themeColor: PrimeCareTheme.colors.tertiary,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFilterOption(String label, int count, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              ),
              const SizedBox(width: 12),
              Text(label, style: PrimeCareTheme.typography.body),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: PrimeCareTheme.colors.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              count.toString(),
              style: PrimeCareTheme.typography.label.copyWith(
                color: PrimeCareTheme.colors.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIncidentCard({
    required String incidentId,
    required String type,
    required String patientName,
    required String location,
    required String date,
    required String summary,
    required String status,
    required String severity,
    required Color themeColor,
  }) {
    final bool isCritical = severity == 'Critical';

    return Container(
      decoration: BoxDecoration(
        color: PrimeCareTheme.colors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          if (isCritical)
            BoxShadow(
              color: themeColor.withOpacity(0.15),
              blurRadius: 48,
              offset: const Offset(0, 8),
            )
          else
            BoxShadow(
              color: PrimeCareTheme.colors.surface.withOpacity(0.6),
              blurRadius: 32,
              offset: const Offset(0, 16),
            ),
        ],
      ),
      child: ClinicalGlassPanel(
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: themeColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            LucideIcons.alertTriangle,
                            size: 14,
                            color: themeColor,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            severity.toUpperCase(),
                            style: PrimeCareTheme.typography.label.copyWith(
                              color: themeColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      incidentId,
                      style: PrimeCareTheme.typography.label.copyWith(
                        color: PrimeCareTheme.colors.outline,
                      ),
                    ),
                  ],
                ),
                Text(
                  date,
                  style: PrimeCareTheme.typography.label.copyWith(
                    color: PrimeCareTheme.colors.outline,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              type,
              style: PrimeCareTheme.typography.h3.copyWith(fontSize: 20),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  LucideIcons.user,
                  size: 16,
                  color: PrimeCareTheme.colors.secondary,
                ),
                const SizedBox(width: 8),
                Text(
                  patientName,
                  style: PrimeCareTheme.typography.label.copyWith(
                    color: PrimeCareTheme.colors.secondary,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  '•',
                  style: TextStyle(color: PrimeCareTheme.colors.outline),
                ),
                const SizedBox(width: 12),
                Icon(
                  LucideIcons.mapPin,
                  size: 16,
                  color: PrimeCareTheme.colors.outline,
                ),
                const SizedBox(width: 8),
                Text(
                  location,
                  style: PrimeCareTheme.typography.label.copyWith(
                    color: PrimeCareTheme.colors.outline,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              summary,
              style: PrimeCareTheme.typography.body.copyWith(
                color: PrimeCareTheme.colors.onSurfaceVariant,
                height: 1.6,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: PrimeCareTheme.colors.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        LucideIcons.activity,
                        size: 14,
                        color: PrimeCareTheme.colors.onSurface,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Status: $status',
                        style: PrimeCareTheme.typography.label,
                      ),
                    ],
                  ),
                ),
                TextButton.icon(
                  onPressed: () {},
                  icon: Icon(
                    LucideIcons.arrowRight,
                    size: 16,
                    color: PrimeCareTheme.colors.primary,
                  ),
                  label: Text(
                    'View Details',
                    style: TextStyle(
                      color: PrimeCareTheme.colors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
