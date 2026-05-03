# Ontario Finance Regional Dashboard - Refined Prompts

## Prompt A: Regional Financial Overview (Primary)
```markdown
# Ontario Regional View - Main Dashboard
Generate a high-fidelity dashboard wrapped in `MasterLayout`. 
Top Section: `AuraV4Hud` [Title: "ONTARIO REGIONAL LIQUIDITY", Value: "$4.2M", AuraLabel: "STABLE", Gradient: "Emerald"].
KPI Grid: `PrimeCareResponsiveKpiGrid` containing 4 `PrimeCareV4StatCard` instances:
- Revenue: "$1.2M" (+12% trend)
- OpEx: "$840K" (-2% trend)
- Margin: "30%" (Stable)
- Aging AR: "$124K" (Warning trend)
Main Content: 70/30 Desktop Split.
- Left (70%): `PrimeCareLineChart` (Cash Flow) + `PrimeCareV4Card` containing a "Pending Approvals" summary list.
- Right (30%): `IntelligenceInsightCard` stack + "Regional Implementation" progress tracking inside `PrimeCareV4Card`.
Aesthetic: Ethereal Precision, 16dp radius, No-Line borders, tonal shadows.
```

## Prompt B: Pending Approvals Detail View
```markdown
# Pending Approvals Queue - Detail
Generate a screen wrapped in `MasterLayout`.
Header: `DashboardSectionHeader` with "PENDING FINANCIAL CLEARANCE".
Content: `PrimeCareV4Card` wrapping a `PrimeCareDataTable`.
Columns: [ID, Entity, Amount, Due Date, Status, Actions].
Rows: 
- INV-2024-001 | HealthCare Inc | $12,500 | 2024-05-15 | `PrimeCareBadge`("PENDING") | `PrimeCareV4Button`("Approve").
Actions: Each row must have an "Approve" (Primary) and "Review" (Ghost) button.
Aesthetic: Tonal layering, #0F172A Background, #10B981 Accent.
```

## Prompt C: Regional Implementation Roadmap
```markdown
# Ontario Regional Implementation Roadmap
Generate a screen wrapped in `MasterLayout`.
Title: "ROLLOUT STATUS: ONTARIO REGIONAL GOVERNANCE".
Content: Vertical list of `PrimeCareV4Card`s, each representing a Phase.
Phase 1: "Budget Allocation" - `PrimeCareBadge`("COMPLETED").
Phase 2: "Regional Tax Sync" - Progress Bar (65%) + List of sub-tasks.
Phase 3: "Liquidity Testing" - `PrimeCareBadge`("UPCOMING").
Aesthetic: Clinical Atelier, Glassmorphism, 40px Backdrop Blur.
```
