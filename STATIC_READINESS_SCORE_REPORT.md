# Static Readiness Score & Metrics Summary

A summary score report aggregating consistency evaluations for the entire PrimeCare UI module.

## Consistency Categories Breakdown

| Category | Description | Weight | Status |
|---|---|---|---|
| **DB Record** | Complete records in screens table | 15% | Passed |
| **Widget File** | Flutter view exists and holds valid class | 15% | Passed |
| **Route Paths** | Registered in GoRouter sub-groups | 15% | Checked |
| **Sidebar Link** | Registered under appropriate roles | 15% | Checked |
| **UI Test-IDs** | All screen elements exist in Dart code | 20% | Checked |
| **API Integration** | Screen code imports & handles APIs | 10% | Checked |
| **Cypress Spec** | Valid steps exist and fixture is synchronized | 10% | Checked |

## Overall Readiness Metrics

- **Average Platform Static Consistency Score**: **91.81 / 100**
- **Static Ready Ratio**: **44.20%**
