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
                  flex: 5,
                  child: _buildBroadcastStream(),
                ),
                const SizedBox(width: 32),
                Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      _buildComposer(),
                      const SizedBox(height: 32),
                      _buildQuickContacts(),
                    ],
                  ),
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
              'Care Updates',
              style: PrimeCareTheme.typography.heroTitle.copyWith(
                color: PrimeCareTheme.colors.navyIndigo,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Asynchronous clinical stream with physicians, nursing staff, and management.',
              style: PrimeCareTheme.typography.body.copyWith(
                color: PrimeCareTheme.colors.slateGray,
              ),
            ),
          ],
        ),
        Row(
          children: [
            ClinicalGlassButton(
              onPressed: () {},
              label: 'Filter by Patient',
              icon: LucideIcons.listFilter,
            ),
            const SizedBox(width: 16),
            ClinicalGlassButton(
              onPressed: () {},
              label: 'My Updates',
              icon: LucideIcons.user,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBroadcastStream() {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Recent Broadcasts', style: PrimeCareTheme.typography.h2),
              Icon(LucideIcons.radio, color: PrimeCareTheme.colors.slateGray, size: 20),
            ],
          ),
          const SizedBox(height: 24),
          _buildUpdateCard(
            'Dr. Smith (Attending)',
            'Wound Protocol Change',
            'Please ensure all grade 2 ulcers are dressed using the new silver alginate patches provided in supply. Document dimensions before and after.',
            '2 hrs ago',
            urgency: 'High',
            color: Colors.orange,
          ),
          const SizedBox(height: 16),
          _buildUpdateCard(
            'Jane Doe (RN Supervisor)',
            'Shift Handoff',
            'Patient in 2B has elevated BP during morning rounds. Please monitor closely. Start vitals every 4 hours.',
            '5 hrs ago',
            urgency: 'Normal',
            color: PrimeCareTheme.colors.emeraldTeal,
          ),
          const SizedBox(height: 16),
          _buildUpdateCard(
            'Pharmacy Dept',
            'Medication Discontinued',
            'Levothyroxine dose for Mr. Arthur in 104 is being held for the next 2 days pending thyroid panel results.',
            '1 day ago',
            urgency: 'Medium',
            color: PrimeCareTheme.colors.azureBlue,
          ),
        ],
      ),
    );
  }

  Widget _buildUpdateCard(String sender, String title, String body, String time, {required String urgency, required MaterialColor color}) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: PrimeCareTheme.colors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.shade100, width: 1.5),
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
                    radius: 16,
                    backgroundColor: color.shade50,
                    child: Icon(LucideIcons.user, size: 16, color: color.shade700),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(sender, style: PrimeCareTheme.typography.label.copyWith(fontWeight: FontWeight.bold)),
                      Text(time, style: PrimeCareTheme.typography.label.copyWith(color: PrimeCareTheme.colors.slateGray, fontSize: 11)),
                    ],
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: color.shade50,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Text(
                  urgency,
                  style: PrimeCareTheme.typography.label.copyWith(color: color.shade700, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(title, style: PrimeCareTheme.typography.h3),
          const SizedBox(height: 8),
          Text(body, style: PrimeCareTheme.typography.body.copyWith(height: 1.5)),
          const SizedBox(height: 16),
          Row(
            children: [
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(LucideIcons.reply, size: 16),
                label: const Text('Reply'),
                style: TextButton.styleFrom(foregroundColor: PrimeCareTheme.colors.slateGray),
              ),
              const SizedBox(width: 8),
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(LucideIcons.checkCircle, size: 16),
                label: const Text('Acknowledge'),
                style: TextButton.styleFrom(foregroundColor: PrimeCareTheme.colors.emeraldTeal),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildComposer() {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(LucideIcons.penTool, color: PrimeCareTheme.colors.navyIndigo, size: 20),
              const SizedBox(width: 12),
              Text('Send Update', style: PrimeCareTheme.typography.h2),
            ],
          ),
          const SizedBox(height: 24),
          const ClinicalSearchTextField(hintText: 'To: (Select Role or Name)'),
          const SizedBox(height: 16),
          const ClinicalSearchTextField(hintText: 'Subject...'),
          const SizedBox(height: 16),
          Container(
            height: 160,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: PrimeCareTheme.colors.surfaceContainerHighest.withOpacity(0.3),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: PrimeCareTheme.colors.surfaceContainerHighest),
            ),
            child: TextField(
              maxLines: null,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Compose your clinical update here...',
                hintStyle: PrimeCareTheme.typography.body.copyWith(color: PrimeCareTheme.colors.slateGray),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              IconButton(onPressed: () {}, icon: const Icon(LucideIcons.paperclip)),
              IconButton(onPressed: () {}, icon: const Icon(LucideIcons.image)),
              const Spacer(),
              ClinicalGlassButton(onPressed: () {}, label: 'Send Secure Update'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickContacts() {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Quick Contacts', style: PrimeCareTheme.typography.h3),
          const SizedBox(height: 16),
          _buildContactRow('Dr. Gregory', 'On-Call Attending'),
          const Divider(height: 24),
          _buildContactRow('Jane Doe', 'Charge Nurse (Floor 2)'),
          const Divider(height: 24),
          _buildContactRow('Pharmacy', 'Ext. 4021'),
        ],
      ),
    );
  }

  Widget _buildContactRow(String name, String role) {
    return Row(
      children: [
        CircleAvatar(
          radius: 16,
          backgroundColor: PrimeCareTheme.colors.slateGray.withOpacity(0.1),
          child: Icon(LucideIcons.user, size: 16, color: PrimeCareTheme.colors.navyIndigo),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name, style: PrimeCareTheme.typography.label.copyWith(fontWeight: FontWeight.bold)),
            Text(role, style: PrimeCareTheme.typography.label.copyWith(color: PrimeCareTheme.colors.slateGray, fontSize: 11)),
          ],
        ),
        const Spacer(),
        Icon(LucideIcons.messageCircle, size: 16, color: PrimeCareTheme.colors.emeraldTeal),
      ],
    );
  }
}

