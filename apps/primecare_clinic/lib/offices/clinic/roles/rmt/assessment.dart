import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/shared/components/page_template.dart';

class RmtAssessmentScreen extends ConsumerWidget {
  const RmtAssessmentScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'Initial Assessments',
      subtitle:
          'Document comprehensive RMT assessments including postural, ROM, and special tests.',
      kpiCards: [
        KPICardData(
          title: 'New Assessments',
          value: '2',
          icon: LucideIcons.clipboardSignature,
          trend: 0.0,
          trendLabel: 'today',
        ),
      ],
      sidebarContent: [
        ClinicalGlassPanel(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Assessment Types', style: PrimeCareTheme.typography.h3),
              const SizedBox(height: 16),
              _buildFilterRow('Postural', 4, PrimeCareTheme.colors.navyIndigo),
              _buildFilterRow(
                'Range of Motion',
                6,
                PrimeCareTheme.colors.emeraldTeal,
              ),
              _buildFilterRow(
                'Orthopedic Tests',
                3,
                PrimeCareTheme.colors.lavenderLustre,
              ),
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
                    'Recent Assessments',
                    style: PrimeCareTheme.typography.h2,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(LucideIcons.plus),
                    label: const Text('New Assessment'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: PrimeCareTheme.colors.navyIndigo,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _buildNoteCard(
                'Sarah Connor',
                'Initial Postural',
                'May 14, 2024 • 09:00',
                'Observed anterior pelvic tilt, protracted shoulder girdle (bilaterally, worse on right). Deep cervical flexors appear weak in relation to SCM and scalenes. Hyperlordosis in lumbar spine.',
                PrimeCareTheme.colors.navyIndigo,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFilterRow(String label, int count, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
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
              const SizedBox(width: 8),
              Text(label, style: PrimeCareTheme.typography.body),
            ],
          ),
          Text(
            count.toString(),
            style: PrimeCareTheme.typography.label.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNoteCard(
    String clientName,
    String category,
    String time,
    String note,
    Color themeColor,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: PrimeCareTheme.colors.surfaceContainerHighest.withOpacity(0.3),
        borderRadius: BorderRadius.circular(16),
        border: Border(left: BorderSide(color: themeColor, width: 4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(clientName, style: PrimeCareTheme.typography.h3),
                  const SizedBox(width: 8),
                  Text(
                    '•',
                    style: TextStyle(color: PrimeCareTheme.colors.slateGray),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    category,
                    style: PrimeCareTheme.typography.label.copyWith(
                      fontWeight: FontWeight.bold,
                      color: themeColor,
                    ),
                  ),
                ],
              ),
              Text(
                time,
                style: PrimeCareTheme.typography.label.copyWith(
                  color: PrimeCareTheme.colors.slateGray,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(note, style: PrimeCareTheme.typography.body),
        ],
      ),
    );
  }
}
