# Clinical Nurse Specialist

## Role Summary

* **Role key**: `cns`
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
| CnsDashboardScreen | `/clinical/cns-dashboard` | 2 | 1 | `LOW_INTERACTION` | 5 | 4 | research, care-plan | **Yes** |
| Clinical Nurse Specialist Analytics | `/rn/cns-analytics` | 2 | 1 | `LOW_INTERACTION` | 4 | 1 | research, consultation, education, care-plan, audit | **No** |
| Clinical Nurse Specialist Compliance Workflow | `/rn/cns-workflow` | 2 | 1 | `LOW_INTERACTION` | 3 | 1 | research, consultation, education, care-plan, audit | **No** |

## Screen Details

### CnsDashboardScreen

* **Route**: `/clinical/cns-dashboard`
* **Component file**: `packages/primecare_ui/lib/src/screens/clinical/cns_dashboard_screen.dart`
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
* **Business Workflow Score**: 5
* **Role Expectation Score**: 4
* **Missing Business Features**: research, care-plan
* **Purpose**: Clinical director hub to review staff quality metrics, manage incident escalations, and review compliance audits.
* **Primary user goal**: Ensure high standards of clinical care, review incident reports, and pass clinical quality audits.
* **Expected user actions**: Filter incident reports, check nurse credential expirations, download audit files, sign approvals.
* **Business reason**: Mandatory for clinical safety oversight, risk mitigation, and compliance with health regulations.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### Clinical Nurse Specialist Analytics

* **Route**: `/rn/cns-analytics`
* **Component file**: `packages/primecare_ui/lib/src/screens/rn/cns_analytics_screen.dart`
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
* **Business Workflow Score**: 4
* **Role Expectation Score**: 1
* **Missing Business Features**: research, consultation, education, care-plan, audit
* **Purpose**: Clinical director hub to review staff quality metrics, manage incident escalations, and review compliance audits.
* **Primary user goal**: Ensure high standards of clinical care, review incident reports, and pass clinical quality audits.
* **Expected user actions**: Filter incident reports, check nurse credential expirations, download audit files, sign approvals.
* **Business reason**: Mandatory for clinical safety oversight, risk mitigation, and compliance with health regulations.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### Clinical Nurse Specialist Compliance Workflow

* **Route**: `/rn/cns-workflow`
* **Component file**: `packages/primecare_ui/lib/src/screens/rn/cns_workflow_screen.dart`
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
* **Role Expectation Score**: 1
* **Missing Business Features**: research, consultation, education, care-plan, audit
* **Purpose**: Clinical director hub to review staff quality metrics, manage incident escalations, and review compliance audits.
* **Primary user goal**: Ensure high standards of clinical care, review incident reports, and pass clinical quality audits.
* **Expected user actions**: Filter incident reports, check nurse credential expirations, download audit files, sign approvals.
* **Business reason**: Mandatory for clinical safety oversight, risk mitigation, and compliance with health regulations.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

## Screens to Fix First

1. **Clinical Nurse Specialist Analytics** (Progress: 60%, Business Score: 4, Role Score: 1)  
   *Reason*: Missing core workflows/features: research, consultation, education, care-plan, audit
2. **Clinical Nurse Specialist Compliance Workflow** (Progress: 60%, Business Score: 3, Role Score: 1)  
   *Reason*: Missing core workflows/features: research, consultation, education, care-plan, audit

## Recommended Build Order

### 1. Must Fix Now (High Priority)
- Clinical Nurse Specialist Analytics (Implement role-specific workflows and transactional features)
- Clinical Nurse Specialist Compliance Workflow (Implement role-specific workflows and transactional features)

### 2. Fix Next (Medium Priority)
- None (All screens are functionally complete)

### 3. Polish Later (Low Priority)
- CnsDashboardScreen (Micro-interactions and design alignment polish)

### 4. Consider Merging / Deleting
- None (Zero duplicate screens identified)
