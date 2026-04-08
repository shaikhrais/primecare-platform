import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/shared/components/page_template.dart';

class RpnClientHistoryScreen extends ConsumerWidget {
  const RpnClientHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'Client Medical History',
      subtitle: 'Review comprehensive medical history and past treatments.',
      kpiCards: [
        KPICardData(
          title: 'Total Records',
          value: '142',
          icon: LucideIcons.folderClosed,
          trend: 0.0,
          trendLabel: 'on file',
        ),
        KPICardData(
          title: 'Active Diagnoses',
          value: '3',
          icon: LucideIcons.activity,
          trend: 0.0,
          trendLabel: 'managed',
        ),
        KPICardData(
          title: 'Recent Discharges',
          value: '1',
          icon: LucideIcons.logOut,
          trend: -1.0,
          trendLabel: 'this month',
        ),
      ],
      sidebarContent: [
        ClinicalGlassPanel(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Active Patient Roster',
                style: PrimeCareTheme.typography.h3,
              ),
              const SizedBox(height: 24),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search clients by name, ID...',
                  hintStyle: TextStyle(color: PrimeCareTheme.colors.outline),
                  prefixIcon: Icon(
                    LucideIcons.search,
                    color: PrimeCareTheme.colors.primary,
                  ),
                  filled: true,
                  fillColor: PrimeCareTheme.colors.surfaceContainerLowest,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                ),
                style: TextStyle(color: PrimeCareTheme.colors.onSurface),
              ),
              const SizedBox(height: 24),
              _buildClientListTile('Maria Garcia', 'Rm 201-A', isActive: true),
              _buildClientListTile('John Smith', 'Rm 204-B'),
              _buildClientListTile('Eleanor Rigby', 'Rm 205-A'),
              _buildClientListTile('Arthur Dent', 'Rm 201-B'),
            ],
          ),
        ),
      ],
      mainContent: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClinicalGlassPanel(
              padding: const EdgeInsets.all(32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Maria Garcia',
                            style: PrimeCareTheme.typography.display.copyWith(
                              fontSize: 32,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'DOB: 1945-08-12 (78 years) • Female • MRN: 8849-2A',
                            style: PrimeCareTheme.typography.body.copyWith(
                              color: PrimeCareTheme.colors.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                      Wrap(
                        spacing: 8,
                        children: [
                          _buildAllergyTag(
                            'Penicillin',
                            PrimeCareTheme.colors.error,
                          ),
                          _buildAllergyTag(
                            'Latex',
                            PrimeCareTheme.colors.error,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 16.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Chronological History',
                    style: PrimeCareTheme.typography.h2,
                  ),
                  Row(
                    children: [
                      Icon(
                        LucideIcons.filter,
                        size: 18,
                        color: PrimeCareTheme.colors.primary,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Filter by Type',
                        style: TextStyle(
                          color: PrimeCareTheme.colors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            _buildHistoryTimelineEntry(
              date: 'May 15, 2024',
              time: '14:30',
              type: 'Routine Follow-up',
              author: 'Dr. Thorne',
              content:
                  'Patient states she is feeling well. Blood pressure within normal limits (128/82). Discussed importance of maintaining low-sodium diet. Scheduled for 3-month follow-up. No changes to medication.',
              themeColor: PrimeCareTheme.colors.tertiary,
              icon: LucideIcons.stethoscope,
            ),
            _buildHistoryTimelineEntry(
              date: 'May 01, 2024',
              time: '09:15',
              type: 'Wound Care Assessment',
              author: 'RN Sarah Jenkins',
              content:
                  'Initial assessment of minor skin tear on left forearm. Cleaned with saline and applied sterile dressing. Wound edges are approximated. Educated patient on signs of infection to monitor.',
              themeColor: PrimeCareTheme.colors.primary,
              icon: LucideIcons.activitySquare,
            ),
            _buildHistoryTimelineEntry(
              date: 'April 10, 2024',
              time: '11:00',
              type: 'Specialist Note: Cardiology',
              author: 'Dr. H. McCoy',
              content:
                  'Echocardiogram results reviewed. Mild left ventricular hypertrophy noted, consistent with history of hypertension. Current medication regimen is adequate. Will review again in 6 months.',
              themeColor: PrimeCareTheme.colors.secondary,
              icon: LucideIcons.heartPulse,
            ),
            _buildHistoryTimelineEntry(
              date: 'February 22, 2024',
              time: '16:00',
              type: 'Discharge Summary',
              author: 'Dr. Thorne',
              content:
                  'Patient discharged after brief admission for acute bronchitis. Tolerating oral antibiotics. Follow-up with primary care in 1 week.',
              themeColor: PrimeCareTheme.colors.error,
              icon: LucideIcons.logOut,
              isLast: true,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildClientListTile(
    String name,
    String details, {
    bool isActive = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: isActive
            ? PrimeCareTheme.colors.primary.withOpacity(0.1)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isActive
              ? PrimeCareTheme.colors.primary.withOpacity(0.3)
              : Colors.transparent,
        ),
      ),
      child: ListTile(
        leading: CircleAvatar(
          radius: 20,
          backgroundColor: isActive
              ? PrimeCareTheme.colors.primary
              : PrimeCareTheme.colors.surfaceContainerLowest,
          child: Text(
            name[0],
            style: TextStyle(
              color: isActive
                  ? PrimeCareTheme.colors.onPrimary
                  : PrimeCareTheme.colors.onSurface,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(
          name,
          style: PrimeCareTheme.typography.h3.copyWith(fontSize: 16),
        ),
        subtitle: Text(
          details,
          style: TextStyle(color: PrimeCareTheme.colors.onSurfaceVariant),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        onTap: () {},
      ),
    );
  }

  Widget _buildAllergyTag(String allergy, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(LucideIcons.alertTriangle, size: 14, color: color),
          const SizedBox(width: 8),
          Text(
            allergy,
            style: PrimeCareTheme.typography.label.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryTimelineEntry({
    required String date,
    required String time,
    required String type,
    required String author,
    required String content,
    required Color themeColor,
    required IconData icon,
    bool isLast = false,
  }) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Timeline side
          SizedBox(
            width: 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  date,
                  style: PrimeCareTheme.typography.label.copyWith(
                    color: PrimeCareTheme.colors.onSurface,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  time,
                  style: PrimeCareTheme.typography.label.copyWith(
                    color: PrimeCareTheme.colors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          // Timeline line and node
          Column(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: themeColor.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: themeColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: isLast
                    ? const SizedBox()
                    : Container(
                        width: 2,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              themeColor.withOpacity(0.5),
                              PrimeCareTheme.colors.surfaceContainerHighest,
                            ],
                          ),
                        ),
                      ),
              ),
            ],
          ),
          const SizedBox(width: 24),
          // Timeline Content
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(bottom: 32),
              decoration: BoxDecoration(
                color: PrimeCareTheme.colors.surfaceContainerLowest,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: themeColor.withOpacity(0.03),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: ClinicalGlassPanel(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Icon(icon, size: 20, color: themeColor),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  type,
                                  style: PrimeCareTheme.typography.h3,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color:
                                PrimeCareTheme.colors.surfaceContainerHighest,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            'Author: $author',
                            style: PrimeCareTheme.typography.label.copyWith(
                              color: PrimeCareTheme.colors.onSurfaceVariant,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      content,
                      style: PrimeCareTheme.typography.body.copyWith(
                        color: PrimeCareTheme.colors.onSurfaceVariant,
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        TextButton.icon(
                          onPressed: () {},
                          icon: Icon(
                            LucideIcons.fileText,
                            size: 16,
                            color: PrimeCareTheme.colors.primary,
                          ),
                          label: Text(
                            'View Full Report',
                            style: TextStyle(
                              color: PrimeCareTheme.colors.primary,
                            ),
                          ),
                          style: TextButton.styleFrom(padding: EdgeInsets.zero),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
