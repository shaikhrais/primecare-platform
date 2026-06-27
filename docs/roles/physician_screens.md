# Physician

## Role Summary

* **Role key**: `physician`
* **Role category**: `clinical`
* **Total screens**: 3
* **Business ready screens**: 1
* **Incomplete screens**: 3
* **False progress screens**: 0
* **Zero Screen-Body Interaction screens**: 0
* **Average progress**: 60.0%
* **Average screen-body interactions**: 2.0

## Screen List

| Screen Name | Route Path | Body Interactions | Global Nav | Status | Business Score | Role Score | Missing Business Features | Business Ready |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| PhysicianDashboardScreen | `/clinical/physician-dashboard` | 2 | 1 | `LOW_INTERACTION` | 6 | 3 | diagnosis, vitals, referral | **Yes** |
| Physician Analytics | `/clinical/physician-analytics` | 2 | 1 | `LOW_INTERACTION` | 3 | 2 | diagnosis, prescription, vitals, referral | **No** |
| Physician Compliance Workflow | `/clinical/physician-workflow` | 2 | 1 | `LOW_INTERACTION` | 3 | 2 | diagnosis, prescription, vitals, referral | **No** |

## Screen Details

### PhysicianDashboardScreen

* **Route**: `/clinical/physician-dashboard`
* **Component file**: `packages/primecare_ui/lib/src/screens/clinical/physician_dashboard_screen.dart`
* **Current stage**: Stage 6
* **Progress %**: 60%
* **Visual status**: `INTERACTIVE`
* **Business ready**: `Yes`
* **Meaningful Interaction Status**: `LOW_INTERACTION`
* **Screen Body Interactions**: 2
  * **Buttons**: 2
  * **Forms**: 0
  * **Filters**: 0
  * **Table Actions**: 0
  * **Clickable Cards**: 0
* **Global Navigation Count**: 1
* **Business Workflow Score**: 6
* **Role Expectation Score**: 3
* **Missing Business Features**: diagnosis, vitals, referral
* **Purpose**: Clinical director hub to review staff quality metrics, manage incident escalations, and review compliance audits.
* **Primary user goal**: Ensure high standards of clinical care, review incident reports, and pass clinical quality audits.
* **Expected user actions**: Filter incident reports, check nurse credential expirations, download audit files, sign approvals.
* **Business reason**: Mandatory for clinical safety oversight, risk mitigation, and compliance with health regulations.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### Physician Analytics

* **Route**: `/clinical/physician-analytics`
* **Component file**: `packages/primecare_ui/lib/src/screens/clinical/physician_analytics_screen.dart`
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
* **Business Workflow Score**: 3
* **Role Expectation Score**: 2
* **Missing Business Features**: diagnosis, prescription, vitals, referral
* **Purpose**: Clinical director hub to review staff quality metrics, manage incident escalations, and review compliance audits.
* **Primary user goal**: Ensure high standards of clinical care, review incident reports, and pass clinical quality audits.
* **Expected user actions**: Filter incident reports, check nurse credential expirations, download audit files, sign approvals.
* **Business reason**: Mandatory for clinical safety oversight, risk mitigation, and compliance with health regulations.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### Physician Compliance Workflow

* **Route**: `/clinical/physician-workflow`
* **Component file**: `packages/primecare_ui/lib/src/screens/clinical/physician_workflow_screen.dart`
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
* **Business Workflow Score**: 3
* **Role Expectation Score**: 2
* **Missing Business Features**: diagnosis, prescription, vitals, referral
* **Purpose**: Clinical director hub to review staff quality metrics, manage incident escalations, and review compliance audits.
* **Primary user goal**: Ensure high standards of clinical care, review incident reports, and pass clinical quality audits.
* **Expected user actions**: Filter incident reports, check nurse credential expirations, download audit files, sign approvals.
* **Business reason**: Mandatory for clinical safety oversight, risk mitigation, and compliance with health regulations.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

## Screens to Fix First

1. **Physician Analytics** (Progress: 60%, Business Score: 3, Role Score: 2)  
   *Reason*: Missing core workflows/features: diagnosis, prescription, vitals, referral
2. **Physician Compliance Workflow** (Progress: 60%, Business Score: 3, Role Score: 2)  
   *Reason*: Missing core workflows/features: diagnosis, prescription, vitals, referral

## Recommended Build Order

### 1. Must Fix Now (High Priority)
- Physician Analytics (Implement role-specific workflows and transactional features)
- Physician Compliance Workflow (Implement role-specific workflows and transactional features)

### 2. Fix Next (Medium Priority)
- None (All screens are functionally complete)

### 3. Polish Later (Low Priority)
- PhysicianDashboardScreen (Micro-interactions and design alignment polish)

### 4. Consider Merging / Deleting
- None (Zero duplicate screens identified)
