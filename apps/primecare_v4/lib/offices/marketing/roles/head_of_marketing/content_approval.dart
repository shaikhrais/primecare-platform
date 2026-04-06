import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';

class ContentApprovalScreen extends ConsumerWidget {
  const ContentApprovalScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Content Approval',
              style: PrimeCareTheme.typography.heroTitle.copyWith(
                color: PrimeCareTheme.colors.navyIndigo,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Kanban-style workflow for reviewing and approving marketing copy and creatives.',
              style: PrimeCareTheme.typography.body.copyWith(
                color: PrimeCareTheme.colors.slateGray,
              ),
            ),
            const SizedBox(height: 32),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: _buildKanbanColumn('In Review', [
                    _buildTaskCard('Q2 Newsletter Draft', 'Pending final copy review.', 'Toronto West'),
                    _buildTaskCard('Facebook Ads Graphics', 'Missing brand hex codes.', 'Calgary Center', isAlert: true),
                  ])),
                  const SizedBox(width: 16),
                  Expanded(child: _buildKanbanColumn('Needs Revision', [
                     _buildTaskCard('Promo Video Script', 'Requested shorter intro hook.', 'National Team'),
                  ])),
                  const SizedBox(width: 16),
                  Expanded(child: _buildKanbanColumn('Approved (Ready to Ship)', [
                     _buildTaskCard('Physio May Special Flyer', 'Approved by Legal.', 'Vancouver Local'),
                     _buildTaskCard('LinkedIn Webinar Invite', 'Approved.', 'B2B Sales'),
                  ])),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildKanbanColumn(String title, List<Widget> children) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: PrimeCareTheme.colors.surfaceContainerHighest.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           Text(title, style: PrimeCareTheme.typography.h3),
           const SizedBox(height: 16),
           ...children.map((c) => Padding(
             padding: const EdgeInsets.only(bottom: 12),
             child: c,
           )).toList(),
         ],
      ),
    );
  }

  Widget _buildTaskCard(String title, String desc, String region, {bool isAlert = false}) {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Expanded(child: Text(title, style: PrimeCareTheme.typography.h3.copyWith(color: isAlert ? PrimeCareTheme.colors.coralRed : PrimeCareTheme.colors.navyIndigo))),
               Icon(LucideIcons.moreHorizontal, color: PrimeCareTheme.colors.slateGray, size: 16),
             ],
           ),
           const SizedBox(height: 8),
           Text(desc, style: PrimeCareTheme.typography.body.copyWith(fontSize: 13)),
           const SizedBox(height: 16),
           Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               Container(
                 padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                 decoration: BoxDecoration(
                   color: PrimeCareTheme.colors.slateGray.withOpacity(0.1),
                   borderRadius: BorderRadius.circular(4),
                 ),
                 child: Text(region, style: PrimeCareTheme.typography.label),
               ),
               Icon(LucideIcons.messageSquare, size: 14, color: PrimeCareTheme.colors.slateGray),
             ],
           )
        ],
      )
    );
  }
}
