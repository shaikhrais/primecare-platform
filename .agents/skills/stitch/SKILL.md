---
name: Stitch UI Orchestration
description: Leverages Stitch (Google DeepMind's UI engine) to generate, refine, and apply high-fidelity design systems and screens to the PrimeCare platform.
---

# Stitch UI Orchestration Skill

This skill enables the agent to prototype and implement premium UI designs using the **Stitch** platform. It provides a bridge between low-fidelity requirements and high-fidelity Flutter screens.

## Workflow

### 1. Project Initialization
- Use `create_project` to establish a new workspace for UI exploration if a relevant one doesn't exist.
- Use `list_projects` to locate existing project contexts (e.g., "PrimeCare V4").

### 2. Design System Definition
- Use `create_design_system` to define the "Clinical Atelier" visual language.
- Standard parameters:
  - **Colors**: Vibrant, professional blues/teals.
  - **Typography**: `Outfit` for headings, `Inter` for body.
  - **Shape**: Smooth 16dp corners for glass surfaces.
- Use `update_design_system` to refine tokens based on user feedback.

### 3. Screen Generation
- Use `generate_screen_from_text` to create new dashboard or feature screens.
- **Prompt Strategy**: Use "PrimeCare V4" as a prefix. Include specific role KPIs (e.g., "CFO Dashboard with Revenue, Accounts Receivable, and Ledger Audit").
- **Variants**: Use `generate_variants` to explore different layout densitites (Mobile vs Desktop).

### 4. Implementation Linkage
- Once a screen is generated in Stitch, use `get_screen` to retrieve the design details.
- Manually map the Stitch output to the `PageTemplate` or custom Flutter dashboards in `apps/primecare_v4`.
- Ensure data hydration using `dashboardMetricsProvider` and `Dio` services.

## Best Practices
- **Consistency**: Always link generated screens to the global `DesignSystem` asset.
- **Responsiveness**: Generate variants for both `MOBILE` and `DESKTOP` to ensure cross-platform compatibility.
- **Aesthetics**: Use the "Wow" factor—glassmorphism, subtle gradients, and modern typography are mandatory.
