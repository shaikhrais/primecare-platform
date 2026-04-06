import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';

class CareUpdatesScreen extends ConsumerWidget {
  const CareUpdatesScreen({super.key});

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
              'Care Updates',
              style: PrimeCareTheme.typography.heroTitle.copyWith(
                color: PrimeCareTheme.colors.navyIndigo,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Asynchronous communication stream with physicians and RN supervisors.',
              style: PrimeCareTheme.typography.body.copyWith(
                color: PrimeCareTheme.colors.slateGray,
              ),
            ),
            const SizedBox(height: 32),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: ClinicalGlassPanel(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Recent Broadcasts', style: PrimeCareTheme.typography.h2),
                        const SizedBox(height: 24),
                        _buildUpdateCard(
                          'Dr. Smith',
                          'Wound Protocol Change',
                          'Please ensure all grade 2 ulcers are dressed using the new silver alginate patches provided in supply.',
                          '2 hrs ago',
                        ),
                        const SizedBox(height: 16),
                        _buildUpdateCard(
                          'Jane Doe (RN)',
                          'Shift Handoff',
                          'Patient in 2B has elevated BP during morning rounds. Please monitor closely.',
                          '5 hrs ago',
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 24),
                Expanded(
                  flex: 2,
                  child: ClinicalGlassPanel(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Send Update', style: PrimeCareTheme.typography.h2),
                        const SizedBox(height: 24),
                        ClinicalSearchTextField(hintText: 'To: (Select Role or Name)'),
                        const SizedBox(height: 16),
                        Container(
                          height: 150,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: PrimeCareTheme.colors.surfaceContainerHighest.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: PrimeCareTheme.colors.surfaceContainerHighest),
                          ),
                          child: const TextField(
                            maxLines: null,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Compose message...',
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        ClinicalGlassButton(onPressed: () {}, label: 'Send Update', isFullWidth: true),
                      ],
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

  Widget _buildUpdateCard(String sender, String title, String body, String time) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: PrimeCareTheme.colors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: PrimeCareTheme.colors.surfaceContainerHighest),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 12,
                    backgroundColor: PrimeCareTheme.colors.navyIndigo.withOpacity(0.1),
                    child: Icon(LucideIcons.user, size: 12, color: PrimeCareTheme.colors.navyIndigo),
                  ),
                  const SizedBox(width: 8),
                  Text(sender, style: PrimeCareTheme.typography.label.copyWith(fontWeight: FontWeight.bold)),
                ],
              ),
              Text(time, style: PrimeCareTheme.typography.label.copyWith(color: PrimeCareTheme.colors.slateGray)),
            ],
          ),
          const SizedBox(height: 12),
          Text(title, style: PrimeCareTheme.typography.h3),
          const SizedBox(height: 4),
          Text(body, style: PrimeCareTheme.typography.body),
        ],
      ),
    );
  }
}
