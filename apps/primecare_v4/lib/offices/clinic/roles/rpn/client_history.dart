import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';

class ClientHistoryScreen extends ConsumerWidget {
  const ClientHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 32),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: _buildPatientProfile(),
                ),
                const SizedBox(width: 32),
                Expanded(
                  flex: 5,
                  child: _buildClinicalTimeline(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Clinical History Engine',
              style: PrimeCareTheme.typography.heroTitle.copyWith(
                color: PrimeCareTheme.colors.navyIndigo,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Deep longitudinal record of patient visits, labs, and previous RPN interventions.',
              style: PrimeCareTheme.typography.body.copyWith(
                color: PrimeCareTheme.colors.slateGray,
              ),
            ),
          ],
        ),
        SizedBox(
          width: 300,
          child: ClinicalSearchTextField(
            hintText: 'Search by client ID or name...',
          ),
        ),
      ],
    );
  }

  Widget _buildPatientProfile() {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          CircleAvatar(
            radius: 48,
            backgroundColor: PrimeCareTheme.colors.navyIndigo.withOpacity(0.1),
            child: Icon(LucideIcons.user, size: 48, color: PrimeCareTheme.colors.navyIndigo),
          ),
          const SizedBox(height: 16),
          Text(
            'John Carmichael',
            style: PrimeCareTheme.typography.h2,
            textAlign: TextAlign.center,
          ),
          Text(
            'DOB: 1948-03-12 (78 Yrs)',
            style: PrimeCareTheme.typography.label.copyWith(color: PrimeCareTheme.colors.slateGray),
          ),
          const SizedBox(height: 24),
          _buildInfoRow('MRN', 'A8392-XX1'),
          const Divider(height: 24),
          _buildInfoRow('Primary Dx', 'Type II Diabetes'),
          const Divider(height: 24),
          _buildInfoRow('Allergies', 'Penicillin (Severe)'),
          const SizedBox(height: 24),
          ClinicalGlassButton(
            onPressed: () {},
            label: 'View Full Chart',
            isFullWidth: true,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: PrimeCareTheme.typography.label.copyWith(color: PrimeCareTheme.colors.slateGray)),
        Text(value, style: PrimeCareTheme.typography.label.copyWith(fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildClinicalTimeline() {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Longitudinal Timeline', style: PrimeCareTheme.typography.h2),
              Row(
                children: [
                  Icon(LucideIcons.filter, size: 16, color: PrimeCareTheme.colors.slateGray),
                  const SizedBox(width: 8),
                  Text('Filter Resources', style: PrimeCareTheme.typography.label),
                ],
              ),
            ],
          ),
          const SizedBox(height: 32),
          _buildTimelineNode(
            date: 'Sep 10, 2026',
            title: 'Wound Management Log (Q3)',
            description: 'Debridement of stage 2 ulcer. Copious serous drainage noted. Applied hydrocolloid dressing.',
            provider: 'Sarah Jenkins (RPN)',
            icon: LucideIcons.clipboardList,
            color: Colors.orange,
            isLast: false,
          ),
          _buildTimelineNode(
            date: 'Aug 22, 2026',
            title: 'Post-Op Catheter Install',
            description: 'Indwelling Foley inserted per MD orders. Output 400cc clear yellow.',
            provider: 'Mark Davis (RN)',
            icon: LucideIcons.activity,
            color: PrimeCareTheme.colors.azureBlue,
            isLast: false,
          ),
          _buildTimelineNode(
            date: 'Aug 05, 2026',
            title: 'Lab Results: A1C Check',
            description: 'HbA1c levels returned at 8.1%. Medication reconciliation initiated by pharmacy.',
            provider: 'Dr. Gregory (Endo)',
            icon: LucideIcons.flaskConical,
            color: PrimeCareTheme.colors.emeraldTeal,
            isLast: true,
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineNode({
    required String date,
    required String title,
    required String description,
    required String provider,
    required IconData icon,
    required MaterialColor color,
    required bool isLast,
  }) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              date,
              style: PrimeCareTheme.typography.label.copyWith(
                color: PrimeCareTheme.colors.slateGray,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.right,
            ),
          ),
          const SizedBox(width: 24),
          Column(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: color.shade50,
                child: Icon(icon, color: color.shade700, size: 18),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: PrimeCareTheme.colors.surfaceContainerHighest,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 24),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: PrimeCareTheme.typography.h3),
                  const SizedBox(height: 8),
                  Text(description, style: PrimeCareTheme.typography.body.copyWith(height: 1.5)),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(LucideIcons.user, size: 12, color: PrimeCareTheme.colors.slateGray),
                      const SizedBox(width: 6),
                      Text(
                        provider,
                        style: PrimeCareTheme.typography.label.copyWith(
                          color: PrimeCareTheme.colors.slateGray,
                        ),
                      ),
                      const Spacer(),
                      ClinicalGlassButton(
                        onPressed: () {},
                        label: 'View Logs',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
