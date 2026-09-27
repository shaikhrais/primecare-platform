# Social Worker

## Role Summary

* **Role key**: `social_worker`
* **Role category**: `clinical`
* **Total screens**: 4
* **Business ready screens**: 1
* **Incomplete screens**: 4
* **False progress screens**: 0
* **Zero Screen-Body Interaction screens**: 0
* **Average progress**: 45.0%
* **Average screen-body interactions**: 2.0

## Screen List

| Screen Name | Route Path | Body Interactions | Global Nav | Status | Business Score | Role Score | Missing Business Features | Business Ready |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| SocialWorkerDashboardScreen | `/offices/clinical/roles/social_worker/dashboard` | 2 | 1 | `LOW_INTERACTION` | 5 | 0 | assessment, client, notes, case, counseling, referral | **No** |
| SocialWorkerAnalyticsScreen | `/offices/clinical/roles/social_worker/analytics` | 2 | 0 | `LOW_INTERACTION` | 2 | 3 | notes, counseling, referral | **Yes** |
| SocialWorkerComplianceScreen | `/offices/clinical/roles/social_worker/compliance` | 2 | 1 | `LOW_INTERACTION` | 5 | 0 | assessment, client, notes, case, counseling, referral | **No** |
| SocialWorkerWorkflowScreen | `/offices/clinical/roles/social_worker/workflow` | 2 | 0 | `LOW_INTERACTION` | 2 | 1 | assessment, notes, case, counseling, referral | **No** |

## Screen Details

### SocialWorkerDashboardScreen

* **Route**: `/offices/clinical/roles/social_worker/dashboard`
* **Component file**: `packages/primecare_ui/lib/src/screens/common/social_worker_dashboard_screen.dart`
* **Current stage**: Stage 5
* **Progress %**: 50%
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
* **Business Workflow Score**: 5
* **Role Expectation Score**: 0
* **Missing Business Features**: assessment, client, notes, case, counseling, referral
* **Purpose**: Clinical director hub to review staff quality metrics, manage incident escalations, and review compliance audits.
* **Primary user goal**: Ensure high standards of clinical care, review incident reports, and pass clinical quality audits.
* **Expected user actions**: Filter incident reports, check nurse credential expirations, download audit files, sign approvals.
* **Business reason**: Mandatory for clinical safety oversight, risk mitigation, and compliance with health regulations.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### SocialWorkerAnalyticsScreen

* **Route**: `/offices/clinical/roles/social_worker/analytics`
* **Component file**: `packages/primecare_ui/lib/src/screens/common/social_worker_analytics_screen.dart`
* **Current stage**: Stage 4
* **Progress %**: 40%
* **Visual status**: `INTERACTIVE`
* **Business ready**: `Yes`
* **Meaningful Interaction Status**: `LOW_INTERACTION`
* **Screen Body Interactions**: 2
  * **Buttons**: 2
  * **Forms**: 0
  * **Filters**: 0
  * **Table Actions**: 0
  * **Clickable Cards**: 0
* **Global Navigation Count**: 0
* **Business Workflow Score**: 2
* **Role Expectation Score**: 3
* **Missing Business Features**: notes, counseling, referral
* **Purpose**: Clinical director hub to review staff quality metrics, manage incident escalations, and review compliance audits.
* **Primary user goal**: Ensure high standards of clinical care, review incident reports, and pass clinical quality audits.
* **Expected user actions**: Filter incident reports, check nurse credential expirations, download audit files, sign approvals.
* **Business reason**: Mandatory for clinical safety oversight, risk mitigation, and compliance with health regulations.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### SocialWorkerComplianceScreen

* **Route**: `/offices/clinical/roles/social_worker/compliance`
* **Component file**: `packages/primecare_ui/lib/src/screens/common/social_worker_compliance_screen.dart`
* **Current stage**: Stage 5
* **Progress %**: 50%
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
* **Business Workflow Score**: 5
* **Role Expectation Score**: 0
* **Missing Business Features**: assessment, client, notes, case, counseling, referral
* **Purpose**: Clinical director hub to review staff quality metrics, manage incident escalations, and review compliance audits.
* **Primary user goal**: Ensure high standards of clinical care, review incident reports, and pass clinical quality audits.
* **Expected user actions**: Filter incident reports, check nurse credential expirations, download audit files, sign approvals.
* **Business reason**: Mandatory for clinical safety oversight, risk mitigation, and compliance with health regulations.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### SocialWorkerWorkflowScreen

* **Route**: `/offices/clinical/roles/social_worker/workflow`
* **Component file**: `packages/primecare_ui/lib/src/screens/common/social_worker_workflow_screen.dart`
* **Current stage**: Stage 4
* **Progress %**: 40%
* **Visual status**: `INTERACTIVE`
* **Business ready**: `No`
* **Meaningful Interaction Status**: `LOW_INTERACTION`
* **Screen Body Interactions**: 2
  * **Buttons**: 2
  * **Forms**: 0
  * **Filters**: 0
  * **Table Actions**: 0
  * **Clickable Cards**: 0
* **Global Navigation Count**: 0
* **Business Workflow Score**: 2
* **Role Expectation Score**: 1
* **Missing Business Features**: assessment, notes, case, counseling, referral
* **Purpose**: Clinical director hub to review staff quality metrics, manage incident escalations, and review compliance audits.
* **Primary user goal**: Ensure high standards of clinical care, review incident reports, and pass clinical quality audits.
* **Expected user actions**: Filter incident reports, check nurse credential expirations, download audit files, sign approvals.
* **Business reason**: Mandatory for clinical safety oversight, risk mitigation, and compliance with health regulations.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

## Screens to Fix First

1. **SocialWorkerWorkflowScreen** (Progress: 40%, Business Score: 2, Role Score: 1)  
   *Reason*: Missing core workflows/features: assessment, notes, case, counseling, referral
2. **SocialWorkerDashboardScreen** (Progress: 50%, Business Score: 5, Role Score: 0)  
   *Reason*: Missing core workflows/features: assessment, client, notes, case, counseling, referral
3. **SocialWorkerComplianceScreen** (Progress: 50%, Business Score: 5, Role Score: 0)  
   *Reason*: Missing core workflows/features: assessment, client, notes, case, counseling, referral

## Recommended Build Order

### 1. Must Fix Now (High Priority)
- SocialWorkerWorkflowScreen (Implement role-specific workflows and transactional features)
- SocialWorkerDashboardScreen (Implement role-specific workflows and transactional features)
- SocialWorkerComplianceScreen (Implement role-specific workflows and transactional features)

### 2. Fix Next (Medium Priority)
- None (All screens are functionally complete)

### 3. Polish Later (Low Priority)
- SocialWorkerAnalyticsScreen (Micro-interactions and design alignment polish)

### 4. Consider Merging / Deleting
- None (Zero duplicate screens identified)
