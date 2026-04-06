import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/shared/components/page_template.dart';

class ProgressUpdatesScreen extends ConsumerWidget {
  const ProgressUpdatesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'Progress Updates',
      subtitle: 'Communicate clinical status changes to the broader care team.',
      kpiCards: [
        KPICardData(
          title: 'Updates Sent',
          value: '8',
          icon: LucideIcons.send,
          trend: 0.0,
          trendLabel: 'today',
        ),
        KPICardData(
          title: 'Replies Pending',
          value: '2',
          icon: LucideIcons.messageSquare,
          trend: 1.0,
          trendLabel: 'from care team',
        ),
        KPICardData(
          title: 'Critical Updates',
          value: '0',
          icon: LucideIcons.alertTriangle,
          trend: -1.0,
          trendLabel: 'this shift',
        ),
      ],
      sidebarContent: [
        ClinicalGlassPanel(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Update Audiences', style: PrimeCareTheme.typography.h3),
              const SizedBox(height: 16),
              _buildAudienceFilter('Primary Care Physician', 3, PrimeCareTheme.colors.navyIndigo),
              _buildAudienceFilter('Family / Next of Kin', 4, PrimeCareTheme.colors.emeraldTeal),
              _buildAudienceFilter('Allied Health (PT/OT)', 1, PrimeCareTheme.colors.lavenderLustre),
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
                   Text('Recent Communications', style: PrimeCareTheme.typography.h2),
                   ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(LucideIcons.edit3),
                    label: const Text('Draft Update'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: PrimeCareTheme.colors.navyIndigo,
                      foregroundColor: Colors.white,
                    ),
                  ),
                 ],
               ),
               const SizedBox(height: 24),
               _buildUpdateCard(
                 'To: Dr. Thorne (PCP)',
                 'Re: Maria Garcia - BP Escalation',
                 '11:45 AM',
                 'Maria\'s BP remains consistently above 150/90 despite dietary changes. Requesting review of Lisinopril dosage. See latest vitals flowsheet for 3-day trend.',
                 PrimeCareTheme.colors.coralRed,
                 'Awaiting Reply'
               ),
               _buildUpdateCard(
                 'To: Daughter (Jane Smith)',
                 'Re: John Smith - Diabetic Management',
                 '09:30 AM',
                 'John\'s morning blood sugar was slightly low today, but we managed it quickly with some juice. He is doing well and ate a good breakfast.',
                 PrimeCareTheme.colors.emeraldTeal,
                 'Sent'
               ),
               _buildUpdateCard(
                 'To: PT Department',
                 'Re: Eleanor Rigby - Mobility',
                 'Yesterday, 4:00 PM',
                 'Eleanor is reporting increased pain (4/10) during transfer from bed to chair. Wound site appears stable. Please advise if adjustments to PT schedule are recommended.',
                 PrimeCareTheme.colors.lavenderLustre,
                 'Replied'
               ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAudienceFilter(String label, int count, Color color) {
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
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(label, style: PrimeCareTheme.typography.body),
            ],
          ),
          Text(count.toString(), style: PrimeCareTheme.typography.label.copyWith(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildUpdateCard(String recipient, String subject, String time, String content, Color highlightColor, String status) {
     return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: PrimeCareTheme.colors.surfaceContainerHighest.withOpacity(0.3),
        borderRadius: BorderRadius.circular(16),
        border: Border(left: BorderSide(color: highlightColor, width: 4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
                Text(recipient, style: PrimeCareTheme.typography.h3),
                Text(status, style: PrimeCareTheme.typography.label.copyWith(color: highlightColor, fontWeight: FontWeight.bold)),
             ],
           ),
           const SizedBox(height: 4),
           Text(subject, style: PrimeCareTheme.typography.label.copyWith(fontWeight: FontWeight.bold, color: PrimeCareTheme.colors.slateGray)),
           const SizedBox(height: 12),
           Text(content, style: PrimeCareTheme.typography.body),
           const SizedBox(height: 16),
           Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
                Text(time, style: PrimeCareTheme.typography.label.copyWith(color: PrimeCareTheme.colors.slateGray)),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(foregroundColor: PrimeCareTheme.colors.navyIndigo),
                  child: const Text('View Thread'),
                )
             ],
           )
        ],
      )
     );
  }
}
