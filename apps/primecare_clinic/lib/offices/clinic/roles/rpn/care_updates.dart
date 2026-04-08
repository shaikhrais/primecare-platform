import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/shared/components/page_template.dart';

class RpnCareUpdatesScreen extends ConsumerWidget {
  const RpnCareUpdatesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'Care Updates & Memos',
      subtitle:
          'Critical clinical changes, task revisions, and policy updates requiring your acknowledgment.',
      kpiCards: [
        KPICardData(
          title: 'Action Required',
          value: '3',
          icon: LucideIcons.alertCircle,
          trend: 1.0,
          trendLabel: 'pending acknowledgment',
        ),
        KPICardData(
          title: 'Critical Care Plans',
          value: '1',
          icon: LucideIcons.activity,
          trend: 0.0,
          trendLabel: 'updated today',
        ),
        KPICardData(
          title: 'General Memos',
          value: '5',
          icon: LucideIcons.fileText,
          trend: 0.0,
          trendLabel: 'unread',
        ),
      ],
      sidebarContent: [
        ClinicalGlassPanel(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Update Categories', style: PrimeCareTheme.typography.h3),
              const SizedBox(height: 24),
              _buildCategoryFilter(
                'Critical Updates',
                1,
                PrimeCareTheme.colors.error,
              ),
              _buildCategoryFilter(
                'Task Revisions',
                2,
                PrimeCareTheme.colors.primary,
              ),
              _buildCategoryFilter(
                'Policy Memos',
                5,
                PrimeCareTheme.colors.secondary,
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
                'Critical Care Plan Updates',
                style: PrimeCareTheme.typography.h2.copyWith(
                  color: PrimeCareTheme.colors.error,
                ),
              ),
            ),
            _buildUpdateCard(
              patientName: 'Arthur Dent',
              room: 'Room 201-B',
              time: '10:45 AM',
              title: 'Medication Order Change: Lisinopril',
              content:
                  'Dr. Thorne has discontinued Lisinopril 10mg PO Daily. New order: Amlodipine 5mg PO Daily starting immediately. Please review new care plan details.',
              severity: 'High Priority',
              themeColor: PrimeCareTheme.colors.error,
              isHighPriority: true,
            ),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 16.0,
              ),
              child: Text(
                'General Ward Memos & Revisions',
                style: PrimeCareTheme.typography.h2,
              ),
            ),
            _buildUpdateCard(
              patientName: 'Ward-wide',
              room: 'Nursing Station',
              time: '09:00 AM',
              title: 'Updated Hand Hygiene Protocol',
              content:
                  'Effective immediately, the mandatory hand hygiene audit protocol has been updated. Please review the attached memo for the new 5-step checklist.',
              severity: 'Routine',
              themeColor: PrimeCareTheme.colors.secondary,
              isHighPriority: false,
            ),
            _buildUpdateCard(
              patientName: 'Tricia McMillan',
              room: 'Room 312-A',
              time: 'Yesterday, 4:30 PM',
              title: 'Physiotherapy Schedule Revised',
              content:
                  'PT department has moved Ms. McMillan\'s ambulation session from 10:00 AM to 2:00 PM to accommodate her post-op rest schedule. Please update daily routine accordingly.',
              severity: 'Notice',
              themeColor: PrimeCareTheme.colors.primary,
              isHighPriority: false,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCategoryFilter(String label, int count, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  shape: BoxShape.circle,
                  border: Border.all(color: color, width: 2),
                ),
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

  Widget _buildUpdateCard({
    required String patientName,
    required String room,
    required String time,
    required String title,
    required String content,
    required String severity,
    required Color themeColor,
    required bool isHighPriority,
  }) {
    return Stack(
      children: [
        if (isHighPriority)
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: RadialGradient(
                  center: Alignment.topLeft,
                  radius: 2.0,
                  colors: [themeColor.withOpacity(0.15), Colors.transparent],
                ),
              ),
            ),
          ),
        Container(
          margin: const EdgeInsets.only(bottom: 24),
          decoration: BoxDecoration(
            color: PrimeCareTheme.colors.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: themeColor.withOpacity(0.05),
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
                            border: Border.all(
                              color: themeColor.withOpacity(0.3),
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                isHighPriority
                                    ? LucideIcons.alertOctagon
                                    : LucideIcons.info,
                                size: 14,
                                color: themeColor,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                severity.toUpperCase(),
                                style: PrimeCareTheme.typography.label.copyWith(
                                  color: themeColor,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Text(
                          time,
                          style: PrimeCareTheme.typography.label.copyWith(
                            color: PrimeCareTheme.colors.outline,
                          ),
                        ),
                      ],
                    ),
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
                        Icon(
                          LucideIcons.mapPin,
                          size: 16,
                          color: PrimeCareTheme.colors.outline,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          room,
                          style: PrimeCareTheme.typography.label.copyWith(
                            color: PrimeCareTheme.colors.outline,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Text(title, style: PrimeCareTheme.typography.h3),
                const SizedBox(height: 12),
                Text(
                  content,
                  style: PrimeCareTheme.typography.body.copyWith(
                    color: PrimeCareTheme.colors.onSurfaceVariant,
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 32),
                Row(
                  children: [
                    Container(
                      decoration: isHighPriority
                          ? BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  themeColor,
                                  themeColor.withOpacity(0.7),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(24),
                            )
                          : null,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isHighPriority
                              ? Colors.transparent
                              : Colors.transparent,
                          shadowColor: Colors.transparent,
                          foregroundColor: isHighPriority
                              ? PrimeCareTheme.colors.onPrimary
                              : PrimeCareTheme.colors.onSurface,
                          side: isHighPriority
                              ? BorderSide.none
                              : BorderSide(
                                  color: PrimeCareTheme.colors.outlineVariant,
                                  width: 1,
                                ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 16,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(LucideIcons.checkCircle, size: 18),
                            const SizedBox(width: 8),
                            const Text(
                              'Acknowledge Update',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    TextButton.icon(
                      onPressed: () {},
                      icon: Icon(
                        LucideIcons.cornerUpRight,
                        size: 18,
                        color: PrimeCareTheme.colors.secondary,
                      ),
                      label: Text(
                        'Reply to Sender',
                        style: TextStyle(
                          color: PrimeCareTheme.colors.secondary,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
