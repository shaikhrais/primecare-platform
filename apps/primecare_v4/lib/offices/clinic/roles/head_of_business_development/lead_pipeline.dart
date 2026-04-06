import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';

class LeadPipelineScreen extends ConsumerWidget {
  const LeadPipelineScreen({super.key});

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
                      'Lead Pipeline',
                      style: PrimeCareTheme.typography.heroTitle.copyWith(
                        color: PrimeCareTheme.colors.navyIndigo,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Manage and track incoming PrimeCare franchise leads.',
                      style: PrimeCareTheme.typography.body.copyWith(
                        color: PrimeCareTheme.colors.slateGray,
                      ),
                    ),
                  ],
                ),
                ClinicalSearchTextField(
                  hintText: 'Search leads by name or region...',
                ),
              ],
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(child: _buildMetricCard('Total Pipeline Value', '\$4.2M', LucideIcons.dollarSign)),
                const SizedBox(width: 16),
                Expanded(child: _buildMetricCard('Active Leads', '34', LucideIcons.users)),
                const SizedBox(width: 16),
                Expanded(child: _buildMetricCard('Conversion Rate', '12%', LucideIcons.trendingUp)),
              ],
            ),
            const SizedBox(height: 32),
            SizedBox(
              height: 600,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(child: _buildKanbanColumn('Inquiry', [
                    _buildLeadCard('Dr. Emily Chen', 'Toronto, ON', 'High', 'Contacted 2 days ago'),
                    _buildLeadCard('Mark Johnson', 'Vancouver, BC', 'Medium', 'New inquiry'),
                  ])),
                  const SizedBox(width: 16),
                  Expanded(child: _buildKanbanColumn('Qualified', [
                    _buildLeadCard('Sarah Peterson', 'Calgary, AB', 'High', 'Financials verified'),
                  ])),
                  const SizedBox(width: 16),
                  Expanded(child: _buildKanbanColumn('In Negotiation', [
                    _buildLeadCard('Dr. Rajesh Patel', 'Mississauga, ON', 'Very High', 'Sending draft agreement'),
                  ])),
                  const SizedBox(width: 16),
                  Expanded(child: _buildKanbanColumn('Signed', [
                    _buildLeadCard('Prime Health Group', 'Ottawa, ON', 'Completed', 'Onboarding phase'),
                  ])),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, IconData icon) {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: PrimeCareTheme.typography.label.copyWith(color: PrimeCareTheme.colors.slateGray)),
              const SizedBox(height: 8),
              Text(value, style: PrimeCareTheme.typography.h2.copyWith(color: PrimeCareTheme.colors.navyIndigo)),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: PrimeCareTheme.colors.emeraldTeal.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: PrimeCareTheme.colors.emeraldTeal),
          ),
        ],
      ),
    );
  }

  Widget _buildKanbanColumn(String title, List<Widget> cards) {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Text(
              '$title (${cards.length})',
              style: PrimeCareTheme.typography.h3,
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: cards.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) => cards[index],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLeadCard(String name, String region, String priority, String status) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: PrimeCareTheme.colors.surfaceContainerHighest.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: PrimeCareTheme.colors.surfaceContainerHighest),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(name, style: PrimeCareTheme.typography.h3),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: priority == 'High' || priority == 'Very High' 
                      ? PrimeCareTheme.colors.coralRed.withOpacity(0.1) 
                      : PrimeCareTheme.colors.navyIndigo.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  priority,
                  style: PrimeCareTheme.typography.label.copyWith(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: priority == 'High' || priority == 'Very High' 
                        ? PrimeCareTheme.colors.coralRed 
                        : PrimeCareTheme.colors.navyIndigo,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(LucideIcons.mapPin, size: 14, color: PrimeCareTheme.colors.slateGray),
              const SizedBox(width: 4),
              Text(region, style: PrimeCareTheme.typography.body.copyWith(color: PrimeCareTheme.colors.slateGray)),
            ],
          ),
          const SizedBox(height: 8),
          Text(status, style: PrimeCareTheme.typography.label.copyWith(fontStyle: FontStyle.italic)),
        ],
      ),
    );
  }
}
