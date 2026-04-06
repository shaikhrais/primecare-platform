import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';

class ContentCalendarScreen extends ConsumerWidget {
  const ContentCalendarScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Content Calendar',
                  style: PrimeCareTheme.typography.heroTitle.copyWith(
                    color: PrimeCareTheme.colors.navyIndigo,
                  ),
                ),
                ClinicalGlassButton(onPressed: (){}, icon: LucideIcons.calendar, label: 'Schedule Post'),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'A visual timeline for social media posts, email blasts, and events.',
              style: PrimeCareTheme.typography.body.copyWith(
                color: PrimeCareTheme.colors.slateGray,
              ),
            ),
            const SizedBox(height: 32),
            Container(
              height: 500,
              decoration: BoxDecoration(
                color: PrimeCareTheme.colors.surfaceContainerHighest.withOpacity(0.3),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: PrimeCareTheme.colors.surfaceContainerHighest),
              ),
              child: Center(
                child: Text('Calendar Library Integration Pending', style: PrimeCareTheme.typography.h3.copyWith(color: PrimeCareTheme.colors.slateGray)),
              ),
            ),
            const SizedBox(height: 32),
            Text('Upcoming This Week', style: PrimeCareTheme.typography.h2),
            const SizedBox(height: 16),
            _buildPostRow('Facebook', 'April 15 - 9:00 AM', 'Spring Cleaning Tips for Back Health', 'Scheduled'),
            _buildPostRow('Instagram', 'April 16 - 12:00 PM', 'Meet our new Physiotherapist!', 'Draft'),
            _buildPostRow('Email', 'April 18 - 8:00 AM', 'April Patient Newsletter', 'Approved'),
          ],
        ),
      ),
    );
  }

  Widget _buildPostRow(String platform, String time, String content, String status) {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
           Row(
             children: [
               Icon(LucideIcons.share2, color: PrimeCareTheme.colors.navyIndigo, size: 20),
               const SizedBox(width: 16),
               Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Text(content, style: PrimeCareTheme.typography.h3),
                   Text('$platform • $time', style: PrimeCareTheme.typography.label.copyWith(color: PrimeCareTheme.colors.slateGray)),
                 ],
               ),
             ],
           ),
           Container(
             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
             decoration: BoxDecoration(
               color: status == 'Scheduled' || status == 'Approved' ? PrimeCareTheme.colors.emeraldTeal.withOpacity(0.1) : PrimeCareTheme.colors.amberWarning.withOpacity(0.1),
               borderRadius: BorderRadius.circular(20),
             ),
             child: Text(status, style: PrimeCareTheme.typography.label.copyWith(color: status == 'Scheduled' || status == 'Approved' ? PrimeCareTheme.colors.emeraldTeal : PrimeCareTheme.colors.amberWarning, fontWeight: FontWeight.bold)),
           ),
        ],
      )
    );
  }
}
