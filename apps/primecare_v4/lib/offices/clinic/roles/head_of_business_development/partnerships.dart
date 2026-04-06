import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';

class PartnershipsScreen extends ConsumerWidget {
  const PartnershipsScreen({super.key});

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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Strategic Partnerships',
                      style: PrimeCareTheme.typography.heroTitle.copyWith(
                        color: PrimeCareTheme.colors.navyIndigo,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Manage institutional networks and affiliation agreements.',
                      style: PrimeCareTheme.typography.body.copyWith(
                        color: PrimeCareTheme.colors.slateGray,
                      ),
                    ),
                  ],
                ),
                ClinicalSearchTextField(hintText: 'Search partners...'),
              ],
            ),
            const SizedBox(height: 32),
            Container(
              decoration: BoxDecoration(
                color: PrimeCareTheme.colors.surfaceContainerHighest.withOpacity(0.3),
                borderRadius: BorderRadius.circular(16),
              ),
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 4,
                separatorBuilder: (context, index) => Divider(color: PrimeCareTheme.colors.surfaceContainerHighest),
                itemBuilder: (context, index) {
                  final partners = [
                    {'name': 'National Insurance Corp', 'type': 'Payer', 'status': 'Active', 'value': '\$4.5M'},
                    {'name': 'TechMed Suppliers', 'type': 'Vendor', 'status': 'Active', 'value': '\$1.2M'},
                    {'name': 'University Health Network', 'type': 'Research', 'status': 'Pending Renewal', 'value': 'N/A'},
                    {'name': 'Global Pharma', 'type': 'Clinical Trials', 'status': 'In Negotiation', 'value': '\$2.0M'},
                  ];
                  return ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    leading: CircleAvatar(
                      backgroundColor: PrimeCareTheme.colors.navyIndigo.withOpacity(0.1),
                      child: Icon(LucideIcons.building, color: PrimeCareTheme.colors.navyIndigo),
                    ),
                    title: Text(partners[index]['name']!, style: PrimeCareTheme.typography.h3),
                    subtitle: Text('${partners[index]['type']} • Value: ${partners[index]['value']}', style: PrimeCareTheme.typography.body.copyWith(color: PrimeCareTheme.colors.slateGray)),
                    trailing: _buildStatusChip(partners[index]['status']!),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    Color color;
    switch (status) {
      case 'Active':
        color = PrimeCareTheme.colors.emeraldTeal;
        break;
      case 'Pending Renewal':
        color = PrimeCareTheme.colors.amberWarning;
        break;
      default:
        color = PrimeCareTheme.colors.slateGray;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: PrimeCareTheme.typography.label.copyWith(
          color: color,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
