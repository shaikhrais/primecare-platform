// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

/// A card tracking supply chain health and delivery velocity.
class SupplyChainHealthCard extends StatelessWidget {
  final AnalyticsChart chart;

  const SupplyChainHealthCard({super.key, required this.chart});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return PrimeCareCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Supply Chain Velocity', style: theme.typography.h3),
                  Text(
                    'Delivery fulfillment and inventory replenishment rates',
                    style: theme.typography.labelMedium,
                  ),
                ],
              ),
              const Spacer(),
              PrimeCareButton(
                label: 'LOGISTICS',
                type: PrimeCareButtonType.text,
                onPressed: () {},
                icon: LucideIcons.truck,
              ),
            ],
          ),
          SizedBox(height: theme.spacing.lg),
          SizedBox(height: 250, child: PrimeCareBarChart(chart: chart)),
        ],
      ),
    );
  }
}

/// A grid tracking facility utilization and maintenance status.
class FacilityUtilizationGrid extends StatelessWidget {
  const FacilityUtilizationGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return PrimeCareCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Infrastructure Utilization', style: theme.typography.h3),
          Text(
            'Physical asset capacity and maintenance auditing',
            style: theme.typography.labelMedium,
          ),
          SizedBox(height: theme.spacing.lg),
          PrimeCareDataTable<Map<String, String>>(
            columns: const ['Facility', 'Utilization', 'Health', 'Status'],
            rows: [
              _buildRow('Main Logistics Hub', '88%', 'Verified', 'SUCCESS'),
              _buildRow('Regional Storage A', '94%', 'Verified', 'SUCCESS'),
              _buildRow('Training Center', '45%', 'Pending', 'CAUTION'),
              _buildRow('Corporate HQ', '62%', 'Verified', 'SUCCESS'),
            ],
          ),
        ],
      ),
    );
  }

  DataRow _buildRow(
    String facility,
    String utilization,
    String health,
    String status,
  ) {
    return DataRow(
      cells: [
        DataCell(Text(facility)),
        DataCell(
          Text(
            utilization,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        DataCell(Text(health)),
        DataCell(
          PrimeCareStatusBadge(
            label: status,
            type: status == 'SUCCESS' ? BadgeType.success : BadgeType.warning,
          ),
        ),
      ],
    );
  }
}

/// Operational action hub for the Operations Manager.
class OperationsActionHub extends StatelessWidget {
  const OperationsActionHub({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimeCareQuickActionsGrid(
      actions: const [
        PrimeCareActionItem(
          title: 'Manage Fleet',
          icon: LucideIcons.truck,
          route: '/fleet/manage',
        ),
        PrimeCareActionItem(
          title: 'Inventory Audit',
          icon: LucideIcons.box,
          route: '/inventory/audit',
        ),
        PrimeCareActionItem(
          title: 'Facility Maintenance',
          icon: LucideIcons.wrench,
          route: '/facilities/maintenance',
        ),
        PrimeCareActionItem(
          title: 'Supply Order',
          icon: LucideIcons.shoppingCart,
          route: '/supply/order',
        ),
      ],
    );
  }
}
