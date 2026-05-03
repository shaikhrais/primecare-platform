# Ontario Finance Regional Dashboard - Stitch Blueprint

## Platform Context
You are generating a screen for the PrimeCare Platform using Aura Vision V4 standards.
Adhere to the "Ethereal Precision" aesthetic: Glassmorphism, No-Line partitioning, Tonal Layering.

## Injecting Source Components (DO NOT HALLUCINATE)
Use ONLY these platform-native components in the layout:
1. `MasterLayout`: Root wrapper. **CRITICAL**: This component provides the persistent common top bar and navigation sidebar. All content must be inside its `child`.
2. `AuraV4Hud`: Top-level telemetry widget. Requires `title`, `value`, `auraLabel`, `gradient`.
3. `PrimeCareV4StatCard`: KPI metric card. Requires `title`, `value`, `icon`, `trend`.
4. `DashboardKpiGrid`: High-precision grid for `PrimeCareV4StatCard` instances.
5. `ActionableInsightCard`: Insight card with impact colors. Requires `insight` model.
6. `DashboardAnalyticsCharts`: Grid for `PrimeCareLineChart` instances.
7. `DashboardSectionHeader`: Header for sections like "Recent Transactions" or "Regional Insights".
8. `PrimeCareV4Card`: Generic container for lists and content blocks.
9. `PrimeCareButton`: Standard action button.

## Screen: Ontario Finance Regional View
### View Model / Data Context:
- Region: Ontario, CA
- Roles: CFO, Regional Finance Manager
- Primary KPIs: Revenue ($1.2M), OpEx ($840K), Margin (30%), Outstanding Invoices (142).
- Pending List: Invoices awaiting approval, Expense claims.
- Implementation List: Regional budget rollout, Tax reconciliation.

### Layout Instructions:
1. **Root Layout**: Wrap the entire screen in `MasterLayout`. 
2. **Top Section**: `AuraV4Hud` showing "ONTARIO REGIONAL LIQUIDITY" with value "$4.2M" and emerald-to-teal gradient.
3. **KPI Section**: `DashboardKpiGrid` containing 4 `PrimeCareV4StatCard`s:
   - Revenue: "$1.2M" (+12% trend)
   - OpEx: "$840K" (-2% trend)
   - Margin: "30%" (Stable)
   - Aging AR: "$124K" (Warning trend)
4. **Main Content (Split Layout)**:
   - **Left Column (70%)**: 
     - `DashboardAnalyticsCharts` showing "Monthly Cash Flow" and "Revenue vs Budget".
     - `DashboardSectionHeader`("Pending Approvals Queue")
     - `PrimeCareV4Card` containing a List of Pending Items:
       - INV-2024-001 | HealthCare Inc | $12,500 | [Approve] [Review]
       - EXP-TR-042 | Dr. Jane Smith | $1,240 | [Approve] [Review]
       - INV-2024-003 | Regional Supply Co | $45,000 | [Approve] [Review]
   - **Right Column (30%)**: 
     - `DashboardSectionHeader`("Actionable Intelligence")
     - 3 `ActionableInsightCard` instances focused on OpEx reduction and AR collection.
     - `DashboardSectionHeader`("Regional Implementation")
     - `PrimeCareV4Card` showing rollout progress:
       - "Budget Phase 2" (85% Complete)
       - "Tax Harmonization" (40% Complete)
       - "Regional Audit Prep" (In Progress)

### Responsive Matrix:
- **Desktop/4K**: Full split layout (70/30).
- **Tablet**: Vertical stack, HUD compacts.
- **Mobile**: Single column, `AuraV4Hud` becomes a mini-floating card at the top.

## Visual Directives:
- BACKGROUND: #0F172A (Deep Slate)
- ACCENTS: #10B981 (Emerald), #3B82F6 (Primary Blue)
- SURFACING: Glassy background with 16dp blur on all cards.
- NO LINES: Use tonal shifts and shadows instead of borders.
