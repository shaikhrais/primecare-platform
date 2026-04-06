import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';

class LeadsScreen extends ConsumerWidget {
  const LeadsScreen({super.key});

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
                  'Lead Monitoring',
                  style: PrimeCareTheme.typography.heroTitle.copyWith(
                    color: PrimeCareTheme.colors.navyIndigo,
                  ),
                ),
                ClinicalGlassButton(onPressed: (){}, icon: LucideIcons.download, label: 'Export Leads CSV'),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Enterprise-level lead flow monitoring, MQL vs SQL distributions.',
              style: PrimeCareTheme.typography.body.copyWith(
                color: PrimeCareTheme.colors.slateGray,
              ),
            ),
            const SizedBox(height: 32),
            Row(
               children: [
                 Expanded(
                   child: ClinicalGlassPanel(
                     padding: const EdgeInsets.all(24),
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Text('Total MQLs (30d)', style: PrimeCareTheme.typography.label),
                         const SizedBox(height: 8),
                         Text('3,601', style: PrimeCareTheme.typography.h1.copyWith(color: PrimeCareTheme.colors.navyIndigo)),
                       ],
                     ),
                   ),
                 ),
                 const SizedBox(width: 16),
                 Expanded(
                   child: ClinicalGlassPanel(
                     padding: const EdgeInsets.all(24),
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Text('Total SQLs (30d)', style: PrimeCareTheme.typography.label),
                         const SizedBox(height: 8),
                         Text('1,620', style: PrimeCareTheme.typography.h1.copyWith(color: PrimeCareTheme.colors.emeraldTeal)),
                       ],
                     ),
                   ),
                 ),
                 const SizedBox(width: 16),
                 Expanded(
                   child: ClinicalGlassPanel(
                     padding: const EdgeInsets.all(24),
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Text('Avg. Lead Score', style: PrimeCareTheme.typography.label),
                         const SizedBox(height: 8),
                         Text('78.4', style: PrimeCareTheme.typography.h1.copyWith(color: PrimeCareTheme.colors.emeraldTeal)),
                       ],
                     ),
                   ),
                 ),
               ],
            ),
            const SizedBox(height: 32),
            ClinicalGlassPanel(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Recent Lead Intake', style: PrimeCareTheme.typography.h2),
                      ClinicalSearchTextField(hintText: 'Search leads...'),
                    ],
                  ),
                  const SizedBox(height: 24),
                  _buildLeadRow('LD-9021', 'A. Jensen', 'Physiotherapy', 'MQL', 65),
                  _buildLeadRow('LD-9022', 'M. Tran', 'Chiropractic', 'SQL', 92),
                  _buildLeadRow('LD-9023', 'S. Gupta', 'Massage Therapy', 'SQL', 88),
                  _buildLeadRow('LD-9024', 'L. Chen', 'Wellness Check', 'MQL', 45),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLeadRow(String id, String name, String service, String type, int score) {
    Color typeColor = type == 'SQL' ? PrimeCareTheme.colors.emeraldTeal : PrimeCareTheme.colors.amberWarning;
    Color scoreColor = score > 80 ? PrimeCareTheme.colors.emeraldTeal : (score > 50 ? PrimeCareTheme.colors.amberWarning : PrimeCareTheme.colors.coralRed);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Icon(LucideIcons.userPlus, color: PrimeCareTheme.colors.slateGray, size: 16),
                const SizedBox(width: 8),
                Text(id, style: PrimeCareTheme.typography.label),
              ],
            ),
          ),
          Expanded(flex: 3, child: Text(name, style: PrimeCareTheme.typography.h3)),
          Expanded(flex: 3, child: Text(service, style: PrimeCareTheme.typography.body)),
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: typeColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(type, style: PrimeCareTheme.typography.label.copyWith(color: typeColor, fontWeight: FontWeight.bold)),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('Score: ', style: PrimeCareTheme.typography.label),
                Text('$score', style: PrimeCareTheme.typography.h3.copyWith(color: scoreColor)),
              ],
            )
          )
        ],
      ),
    );
  }
}
