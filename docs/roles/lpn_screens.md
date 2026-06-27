# Licensed Practical Nurse (LPN)

## Role Summary

* **Role key**: `lpn`
* **Role category**: `clinical`
* **Total screens**: 1
* **Business ready screens**: 0
* **Incomplete screens**: 1
* **False progress screens**: 0
* **Zero Screen-Body Interaction screens**: 0
* **Average progress**: 60.0%
* **Average screen-body interactions**: 2.0

## Screen List

| Screen Name | Route Path | Body Interactions | Global Nav | Status | Business Score | Role Score | Missing Business Features | Business Ready |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| LpnDashboardScreen | `/clinical/lpn-dashboard` | 2 | 1 | `LOW_INTERACTION` | 6 | 2 | nursing, tasks, charting | **No** |

## Screen Details

### LpnDashboardScreen

* **Route**: `/clinical/lpn-dashboard`
* **Component file**: `packages/primecare_ui/lib/src/screens/clinical/lpn_dashboard_screen.dart`
* **Current stage**: Stage 6
* **Progress %**: 60%
* **Visual status**: `INTERACTIVE`
* **Business ready**: `No`
* **Meaningful Interaction Status**: `LOW_INTERACTION`
* **Screen Body Interactions**: 2
  * **Buttons**: 2
  * **Forms**: 0
  * **Filters**: 0
  * **Table Actions**: 0
  * **Clickable Cards**: 0
* **Global Navigation Count**: 1
* **Business Workflow Score**: 6
* **Role Expectation Score**: 2
* **Missing Business Features**: nursing, tasks, charting
* **Purpose**: Clinical director hub to review staff quality metrics, manage incident escalations, and review compliance audits.
* **Primary user goal**: Ensure high standards of clinical care, review incident reports, and pass clinical quality audits.
* **Expected user actions**: Filter incident reports, check nurse credential expirations, download audit files, sign approvals.
* **Business reason**: Mandatory for clinical safety oversight, risk mitigation, and compliance with health regulations.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

## Screens to Fix First

1. **LpnDashboardScreen** (Progress: 60%, Business Score: 6, Role Score: 2)  
   *Reason*: Missing core workflows/features: nursing, tasks, charting

## Recommended Build Order

### 1. Must Fix Now (High Priority)
- LpnDashboardScreen (Implement role-specific workflows and transactional features)

### 2. Fix Next (Medium Priority)
- None (All screens are functionally complete)

### 3. Polish Later (Low Priority)
- None (All screens fully completed and polished)

### 4. Consider Merging / Deleting
- None (Zero duplicate screens identified)
