# Nurse Practitioner (NP)

## Role Summary

* **Role key**: `np`
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
| NpDashboardScreen | `/clinical/np-dashboard` | 2 | 1 | `LOW_INTERACTION` | 7 | 1 | assessment, diagnosis, prescription, primary-care | **No** |

## Screen Details

### NpDashboardScreen

* **Route**: `/clinical/np-dashboard`
* **Component file**: `packages/primecare_ui/lib/src/screens/clinical/np_dashboard_screen.dart`
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
* **Business Workflow Score**: 7
* **Role Expectation Score**: 1
* **Missing Business Features**: assessment, diagnosis, prescription, primary-care
* **Purpose**: Clinical director hub to review staff quality metrics, manage incident escalations, and review compliance audits.
* **Primary user goal**: Ensure high standards of clinical care, review incident reports, and pass clinical quality audits.
* **Expected user actions**: Filter incident reports, check nurse credential expirations, download audit files, sign approvals.
* **Business reason**: Mandatory for clinical safety oversight, risk mitigation, and compliance with health regulations.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

## Screens to Fix First

1. **NpDashboardScreen** (Progress: 60%, Business Score: 7, Role Score: 1)  
   *Reason*: Missing core workflows/features: assessment, diagnosis, prescription, primary-care

## Recommended Build Order

### 1. Must Fix Now (High Priority)
- NpDashboardScreen (Implement role-specific workflows and transactional features)

### 2. Fix Next (Medium Priority)
- None (All screens are functionally complete)

### 3. Polish Later (Low Priority)
- None (All screens fully completed and polished)

### 4. Consider Merging / Deleting
- None (Zero duplicate screens identified)
