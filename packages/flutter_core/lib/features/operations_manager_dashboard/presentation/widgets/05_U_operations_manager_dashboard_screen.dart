// Layer: 05_UI_PRESENTATION
import 'package:flutter/material.dart';
import 'package:primecare_core/00_B_flutter_core.dart';
import 'package:primecare_ui/00_B_primecare_ui.dart';

/// High-Fidelity Operations Manager Dashboard
/// Focuses on resource allocation, supply chain logistics, and facility maintenance.
class OperationsManagerDashboardScreen extends ConsumerWidget {
  final dynamic data;
  
  const OperationsManagerDashboardScreen({super.key, this.data});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = PrimeCareTheme.of(context);
    
    return MasterLayout(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(theme.spacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context, theme),
            SizedBox(height: theme.spacing.xl),
            _buildOperationsKpis(context, theme),
            SizedBox(height: theme.spacing.xl),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 3, child: _buildMaintenanceQueue(context, theme)),
                SizedBox(width: theme.spacing.xl),
                Expanded(flex: 2, child: _buildSupplyInventory(context, theme)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, PrimeCareThemeData theme) {
    return ClinicalGlassPanel(
      padding: EdgeInsets.symmetric(
        horizontal: theme.spacing.lg,
        vertical: theme.spacing.md,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Operations Command Center',
                  style: theme.typography.h2,
                ),
                Text(
                  'Supply Chain • Facilities • Resource Allocation',
                  style: theme.typography.label.copyWith(
                    color: theme.colors.slateGray,
                  ),
                ),
              ],
            ),
          ),
          ClinicalGlassButton(
            label: 'Order Supplies',
            icon: LucideIcons.shoppingCart,
            onPressed: () {},
          ),
          SizedBox(width: theme.spacing.md),
          ClinicalGlassButton(
            label: 'Facility Audit',
            icon: LucideIcons.clipboardCheck,
            onPressed: () {},
            isPrimary: true,
          ),
        ],
      ),
    );
  }

  Widget _buildOperationsKpis(BuildContext context, PrimeCareThemeData theme) {
    return Row(
      children: [
        _buildStatCard(theme, 'Vehicle Fleet', '12/14', 'Operational', LucideIcons.truck, theme.colors.emeraldTeal),
        SizedBox(width: theme.spacing.lg),
        _buildStatCard(theme, 'Avg Response', '14m', '-2m from Q1', LucideIcons.clock, theme.colors.primary),
        SizedBox(width: theme.spacing.lg),
        _buildStatCard(theme, 'Supply Index', '82%', 'Critical Refill', LucideIcons.box, theme.colors.amberWarning),
        SizedBox(width: theme.spacing.lg),
        _buildStatCard(theme, 'Energy Efficiency', 'A+', 'Target Met', LucideIcons.zap, theme.colors.emeraldTeal),
      ],
    );
  }

  Widget _buildStatCard(PrimeCareThemeData theme, String label, String value, String status, IconData icon, Color color) {
    return Expanded(
      child: ClinicalGlassPanel(
        padding: EdgeInsets.all(theme.spacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(theme.spacing.xs),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(theme.spacing.xs),
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            SizedBox(height: theme.spacing.md),
            Text(
              value,
              style: theme.typography.h2.copyWith(fontWeight: FontWeight.w900),
            ),
            Text(label, style: theme.typography.labelSmall.copyWith(fontWeight: FontWeight.bold)),
            Text(status, style: theme.typography.labelSmall.copyWith(color: theme.colors.slateGray)),
          ],
        ),
      ),
    );
  }

  Widget _buildMaintenanceQueue(BuildContext context, PrimeCareThemeData theme) {
    return ClinicalGlassPanel(
      title: 'Facility Maintenance Queue',
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        children: [
          _buildQueueItem(theme, 'HVAC Calibration', 'Basement Wing B', 'Urgent', theme.colors.roseRed),
          const Divider(),
          _buildQueueItem(theme, 'Elevator Service', 'Main Hub - P1', 'Scheduled', theme.colors.primary),
          const Divider(),
          _buildQueueItem(theme, 'Roof Inspection', 'Facility North', 'Pending', theme.colors.slateGray),
          const Divider(),
          _buildQueueItem(theme, 'Fire Alarm Test', 'Institutional-Wide', 'Compliance', theme.colors.emeraldTeal),
        ],
      ),
    );
  }

  Widget _buildQueueItem(PrimeCareThemeData theme, String task, String location, String priority, Color color) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: theme.spacing.sm),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(task, style: theme.typography.bodyLarge.copyWith(fontWeight: FontWeight.bold)),
                Text(location, style: theme.typography.labelSmall.copyWith(color: theme.colors.slateGray)),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: theme.spacing.sm, vertical: theme.spacing.xxs),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(theme.spacing.xxs),
              border: Border.all(color: color.withValues(alpha: 0.2)),
            ),
            child: Text(
              priority,
              style: theme.typography.labelSmall.copyWith(color: color, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSupplyInventory(BuildContext context, PrimeCareThemeData theme) {
    return ClinicalGlassPanel(
      title: 'Critical Inventory',
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        children: [
          _buildInventoryRow(theme, 'PPE Masks', 0.94, theme.colors.emeraldTeal),
          _buildInventoryRow(theme, 'Sanitizer Bulk', 0.42, theme.colors.amberWarning),
          _buildInventoryRow(theme, 'Bed Linens', 0.88, theme.colors.emeraldTeal),
          _buildInventoryRow(theme, 'Wound Care Kits', 0.15, theme.colors.roseRed),
        ],
      ),
    );
  }

  Widget _buildInventoryRow(PrimeCareThemeData theme, String label, double level, Color color) {
    return Padding(
      padding: EdgeInsets.only(bottom: theme.spacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: theme.typography.bodyMedium.copyWith(fontWeight: FontWeight.w500)),
              Text('${(level * 100).toInt()}%', style: theme.typography.labelSmall.copyWith(color: color)),
            ],
          ),
          SizedBox(height: theme.spacing.xs),
          LinearProgressIndicator(
            value: level,
            backgroundColor: theme.colors.surfaceContainerHighest,
            color: color,
            minHeight: 6,
            borderRadius: BorderRadius.circular(3),
          ),
        ],
      ),
    );
  }
}
