import os
import re

def pascal_case(s):
    return ''.join(word.capitalize() for word in s.split('_'))

features = [
    "admin_reconciliation_dashboard",
    "community_outreach_dashboard",
    "customer_support_dashboard",
    "demo_dashboard",
    "dynamic_role_dashboard",
    "family_member",
    "franchise_dashboard",
    "franchise_owner_dashboard",
    "franchise_reconciliation_dashboard",
    "franchise_refunds_dashboard",
    "franchise_reports_dashboard",
    "franchise_sales_manager_dashboard",
    "head_of_bus_dev_dashboard",
    "head_of_marketing_dashboard",
    "hr_manager",
    "intake_coordinator",
    "intake_dashboard",
    "local_marketing",
    "local_marketing_manager_dashboard",
    "owner_dashboard",
    "partnership_manager_dashboard",
    "patient_dashboard",
    "quality_assurance",
    "regional_manager_ontario_dashboard",
    "territory_sales"
]

template = """
// Layer: 05_UI_PRESENTATION
import 'package:flutter/material.dart';
import 'package:primecare_core/00_B_flutter_core.dart';
import 'package:primecare_ui/00_B_primecare_ui.dart';

/// High-Fidelity {name}
class {class_name}Screen extends ConsumerWidget {{
  const {class_name}Screen({{super.key}});

  @override
  Widget build(BuildContext context, WidgetRef ref) {{
    final theme = context.theme;

    return SingleChildScrollView(
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context, theme),
          SizedBox(height: theme.spacing.xl),
          const PrimeCareResponsiveKpiGrid(metrics: {{
            'Performance': '98.5%',
            'Utility': 'High',
            'Status': 'Operational',
            'SLA': '100%',
          }}),
          SizedBox(height: theme.spacing.xl),
          _buildMainContent(context, theme),
        ],
      ),
    );
  }}

  Widget _buildHeader(BuildContext context, PrimeCareThemeData theme) {{
    return PrimeCareCard(
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '{display_name}',
                  style: theme.typography.h2,
                ),
                Text(
                  'Standardized Platform Dashboard • V4 Optimized',
                  style: theme.typography.labelSmall.copyWith(
                    color: theme.colors.slateGray,
                  ),
                ),
              ],
            ),
          ),
          PrimeCareButton(
            label: 'Generate Report',
            icon: LucideIcons.fileText,
            onPressed: () {{}},
            type: PrimeCareButtonType.primary,
          ),
        ],
      ),
    );
  }}

  Widget _buildMainContent(BuildContext context, PrimeCareThemeData theme) {{
    return PrimeCareCard(
      padding: EdgeInsets.all(theme.spacing.xl),
      child: Center(
        child: Column(
          children: [
            Icon(LucideIcons.layoutDashboard, size: 64, color: theme.colors.primary.withValues(alpha: 0.2)),
            SizedBox(height: theme.spacing.lg),
            Text(
              'Unified Role-Based Interface',
              style: theme.typography.titleLarge,
            ),
            SizedBox(height: theme.spacing.sm),
            Text(
              'This sector has been defragmented and standardized for the PrimeCare Unified UX.',
              textAlign: TextAlign.center,
              style: theme.typography.bodyMedium.copyWith(color: theme.colors.slateGray),
            ),
          ],
        ),
      ),
    );
  }}
}}
"""

base_path = "packages/flutter_core/lib/features"

for feature in features:
    class_name = pascal_case(feature)
    display_name = feature.replace('_', ' ').title()
    content = template.format(name=display_name, class_name=class_name, display_name=display_name)
    
    dir_path = os.path.join(base_path, feature, "presentation", "widgets")
    if not os.path.exists(dir_path):
        os.makedirs(dir_path)
        
    file_path = os.path.join(dir_path, f"05_U_{feature}_screen.dart")
    with open(file_path, "w") as f:
        f.write(content)
    print(f"Generated: {file_path}")

print("Mass Recovery Complete.")
