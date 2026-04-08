import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_v4/shared/components/page_template.dart';
import '../../../../providers/dashboard_providers.dart';

class GuestDashboard extends ConsumerWidget {
  const GuestDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'Welcome to PrimeCare V4',
      subtitle:
          'Institutional Clinical Excellence. Scalable. Precise. Reliable.',
      sections: const [
        _ClinicalEcosystemSection(),
        _InstitutionalInquirySection(),
      ],
    );
  }
}

class _ClinicalEcosystemSection extends StatelessWidget {
  const _ClinicalEcosystemSection();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Our Clinical Ecosystem',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              fontFamily: 'Outfit',
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          _buildServiceRow(
            'Specialized Nursing',
            'RN / RPN / PSW Clusters',
            Icons.health_and_safety_outlined,
            Colors.tealAccent,
          ),
          const Divider(color: Colors.blueGrey, height: 24, thickness: 0.1),
          _buildServiceRow(
            'Rehabilitative Arts',
            'Physio / Chiro / OT / SLP',
            Icons.fitness_center_outlined,
            Colors.orangeAccent,
          ),
          const Divider(color: Colors.blueGrey, height: 24, thickness: 0.1),
          _buildServiceRow(
            'Logistics Hub',
            'Intake / Sched / Billing / Support',
            Icons.hub_outlined,
            Colors.blueAccent,
          ),
        ],
      ),
    );
  }

  Widget _buildServiceRow(
    String title,
    String subtitle,
    IconData icon,
    Color color,
  ) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              Text(
                subtitle,
                style: const TextStyle(color: Colors.blueGrey, fontSize: 12),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _InstitutionalInquirySection extends StatelessWidget {
  const _InstitutionalInquirySection();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Institutional Inquiry',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              fontFamily: 'Outfit',
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Contact our Intake Hub',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey,
            ),
          ),
          const SizedBox(height: 16),
          _buildInputField('Your Institutional Name'),
          const SizedBox(height: 12),
          _buildInputField('Department / Region'),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Inquiry Submitted Successfully!'),
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.tealAccent.withValues(alpha: 0.1),
                foregroundColor: Colors.tealAccent,
                padding: const EdgeInsets.all(16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'SUBMIT INQUIRY',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: const TextStyle(color: Colors.blueGrey, fontSize: 14),
      ),
    );
  }
}
