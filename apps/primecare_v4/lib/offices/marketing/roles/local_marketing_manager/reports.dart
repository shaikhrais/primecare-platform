import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';

class LocalReportsScreen extends ConsumerWidget {
  const LocalReportsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Franchise Marketing Reports',
              style: PrimeCareTheme.typography.heroTitle.copyWith(
                color: PrimeCareTheme.colors.navyIndigo,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Summary reports of localized marketing efforts for franchise owners.',
              style: PrimeCareTheme.typography.body.copyWith(
                color: PrimeCareTheme.colors.slateGray,
              ),
            ),
            const SizedBox(height: 32),
            ClinicalGlassPanel(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(LucideIcons.fileText, color: PrimeCareTheme.colors.navyIndigo),
                      const SizedBox(width: 12),
                      Text('Generated Summaries', style: PrimeCareTheme.typography.h2),
                    ],
                  ),
                  const SizedBox(height: 24),
                  _buildReportRow('End of Month Lead Summary - March 2026', 'PDF', '1.2 MB'),
                  const SizedBox(height: 12),
                  _buildReportRow('Q1 Local Campaign ROI Report', 'PDF', '2.5 MB'),
                  const SizedBox(height: 12),
                  _buildReportRow('Event Audit: Spring Health Fair', 'PDF', '0.8 MB'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReportRow(String title, String fileType, String size) {
    return Container(
      decoration: BoxDecoration(
        color: PrimeCareTheme.colors.surfaceContainerHighest.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(flex: 3, child: Text(title, style: PrimeCareTheme.typography.h3)),
          Expanded(flex: 1, child: Text('$fileType • $size', style: PrimeCareTheme.typography.label.copyWith(color: PrimeCareTheme.colors.slateGray))),
          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.centerRight,
              child: ClinicalGlassButton(onPressed: (){}, icon: LucideIcons.download, label: 'Download', isPrimary: false),
            ),
          )
        ],
      )
    );
  }
}
