# QA Specialist

## Role Summary

* **Role key**: `qa_specialist`
* **Role category**: `common`
* **Total screens**: 15
* **Business ready screens**: 2
* **Incomplete screens**: 15
* **False progress screens**: 0
* **Zero Screen-Body Interaction screens**: 1
* **Average progress**: 24.7%
* **Average screen-body interactions**: 4.9

## Screen List

| Screen Name | Route Path | Body Interactions | Global Nav | Status | Business Score | Role Score | Missing Business Features | Business Ready |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| QaDashboardScreen | `/offices/support/roles/quality_assurance/dashboard` | 2 | 1 | `LOW_INTERACTION` | 5 | 2 | test, bug, validation, scenario | **No** |
| QualityAssuranceDashboardScreen | `/staff/quality-assurance-dashboard` | 2 | 1 | `LOW_INTERACTION` | 5 | 2 | test, bug, validation, scenario | **No** |
| QaAnalyticsScreen | `/common/qa-analytics` | 2 | 0 | `LOW_INTERACTION` | 2 | 1 | bug, check, validation, scenario, run | **No** |
| QaWorkflowScreen | `/common/qa-workflow` | 2 | 0 | `LOW_INTERACTION` | 3 | 1 | bug, check, validation, scenario, run | **No** |
| QualityAssuranceAnalyticsScreen | `/staff/quality-assurance-analytics` | 3 | 0 | `MEANINGFUL` | 2 | 1 | bug, check, validation, scenario, run | **No** |
| QualityAssuranceComplianceScreen | `/staff/quality-assurance-compliance` | 4 | 1 | `MEANINGFUL` | 5 | 2 | test, bug, validation, scenario | **No** |
| QualityAssuranceWorkflowScreen | `/staff/quality-assurance-workflow` | 3 | 0 | `MEANINGFUL` | 3 | 1 | bug, check, validation, scenario, run | **No** |
| Quality Assurance Audits | `/generated/quality-assurance-audits` | 8 | 6 | `MEANINGFUL` | 7 | 2 | bug, validation, scenario, run | **No** |
| Quality Assurance Complaints | `/generated/quality-assurance-complaints` | 8 | 6 | `MEANINGFUL` | 8 | 1 | bug, check, validation, scenario, run | **No** |
| Quality Assurance Compliance Checks | `/generated/quality-assurance-compliance-checks` | 8 | 6 | `MEANINGFUL` | 8 | 3 | bug, scenario, run | **Yes** |
| Quality Assurance Corrective Actions | `/generated/quality-assurance-corrective-actions` | 8 | 6 | `MEANINGFUL` | 7 | 2 | bug, validation, scenario, run | **No** |
| Quality Assurance Reports | `/generated/quality-assurance-reports` | 8 | 6 | `MEANINGFUL` | 7 | 1 | bug, check, validation, scenario, run | **No** |
| Quality Assurance Reviews | `/generated/quality-assurance-reviews` | 8 | 6 | `MEANINGFUL` | 8 | 2 | bug, validation, scenario, run | **No** |
| Quality Assurance Scorecards | `/generated/quality-assurance-scorecards` | 8 | 6 | `MEANINGFUL` | 7 | 3 | bug, scenario, run | **Yes** |
| Quality Assurance Metrics | `/generated/quality-assurance-metrics` | 0 | 1 | `READ_ONLY_VALID` | 2 | 2 | bug, validation, scenario, run | **No** |

## Screen Details

### QaDashboardScreen

* **Route**: `/offices/support/roles/quality_assurance/dashboard`
* **Component file**: `packages/primecare_ui/lib/src/screens/common/qa_dashboard_screen.dart`
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
* **Role Expectation Score**: 2
* **Missing Business Features**: test, bug, validation, scenario
* **Purpose**: Management workspace screen for QaDashboardScreen module access.
* **Primary user goal**: Review system records and coordinate day-to-day administrative functions.
* **Expected user actions**: Filter records, view items list, click item detail card, click edit/update buttons.
* **Business reason**: Supports general administrative oversight and recordkeeping.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### QualityAssuranceDashboardScreen

* **Route**: `/staff/quality-assurance-dashboard`
* **Component file**: `packages/primecare_ui/lib/src/screens/staff/quality_assurance_dashboard_screen.dart`
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
* **Role Expectation Score**: 2
* **Missing Business Features**: test, bug, validation, scenario
* **Purpose**: Management workspace screen for QualityAssuranceDashboardScreen module access.
* **Primary user goal**: Review system records and coordinate day-to-day administrative functions.
* **Expected user actions**: Filter records, view items list, click item detail card, click edit/update buttons.
* **Business reason**: Supports general administrative oversight and recordkeeping.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### QaAnalyticsScreen

* **Route**: `/common/qa-analytics`
* **Component file**: `packages/primecare_ui/lib/src/screens/common/qa_analytics_screen.dart`
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
* **Missing Business Features**: bug, check, validation, scenario, run
* **Purpose**: Business intelligence analytics dashboard for QaAnalyticsScreen to monitor performance trends.
* **Primary user goal**: Review historical metrics, filter performance reports, and analyze operational trends.
* **Expected user actions**: Select date range filter, export chart data to CSV, switch between metric tab displays.
* **Business reason**: Data-driven performance tracking and resource allocation forecasting.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### QaWorkflowScreen

* **Route**: `/common/qa-workflow`
* **Component file**: `packages/primecare_ui/lib/src/screens/common/qa_workflow_screen.dart`
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
* **Business Workflow Score**: 3
* **Role Expectation Score**: 1
* **Missing Business Features**: bug, check, validation, scenario, run
* **Purpose**: Operational workflow configuration and tracking screen for QaWorkflowScreen workflows.
* **Primary user goal**: Configure process tasks, track live workflow execution states, and review failed process blocks.
* **Expected user actions**: Edit task list nodes, restart failed workflow execution, sign off on completed steps.
* **Business reason**: Operational automation and validation of process steps.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### QualityAssuranceAnalyticsScreen

* **Route**: `/staff/quality-assurance-analytics`
* **Component file**: `packages/primecare_ui/lib/src/screens/staff/quality_assurance_analytics_screen.dart`
* **Current stage**: Stage 4
* **Progress %**: 40%
* **Visual status**: `INTERACTIVE`
* **Business ready**: `No`
* **Meaningful Interaction Status**: `MEANINGFUL`
* **Screen Body Interactions**: 3
  * **Buttons**: 3
  * **Forms**: 0
  * **Filters**: 0
  * **Table Actions**: 0
  * **Clickable Cards**: 0
* **Global Navigation Count**: 0
* **Business Workflow Score**: 2
* **Role Expectation Score**: 1
* **Missing Business Features**: bug, check, validation, scenario, run
* **Purpose**: Business intelligence analytics dashboard for QualityAssuranceAnalyticsScreen to monitor performance trends.
* **Primary user goal**: Review historical metrics, filter performance reports, and analyze operational trends.
* **Expected user actions**: Select date range filter, export chart data to CSV, switch between metric tab displays.
* **Business reason**: Data-driven performance tracking and resource allocation forecasting.
* **Missing items**: Missing core role features: bug, check, validation, scenario, run
* **Next action**: Implement expected workflows for qa_specialist role.

### QualityAssuranceComplianceScreen

* **Route**: `/staff/quality-assurance-compliance`
* **Component file**: `packages/primecare_ui/lib/src/screens/staff/quality_assurance_compliance_screen.dart`
* **Current stage**: Stage 5
* **Progress %**: 50%
* **Visual status**: `INTERACTIVE`
* **Business ready**: `No`
* **Meaningful Interaction Status**: `MEANINGFUL`
* **Screen Body Interactions**: 4
  * **Buttons**: 4
  * **Forms**: 0
  * **Filters**: 0
  * **Table Actions**: 0
  * **Clickable Cards**: 0
* **Global Navigation Count**: 1
* **Business Workflow Score**: 5
* **Role Expectation Score**: 2
* **Missing Business Features**: test, bug, validation, scenario
* **Purpose**: Regulatory compliance tracking and audit registry for QualityAssuranceComplianceScreen protocols.
* **Primary user goal**: Review policy documents, verify training completion status, and log compliance incidents.
* **Expected user actions**: Check off policy read agreements, upload compliance proofs, search audit registers.
* **Business reason**: Mandatory safety oversight, legal compliance, and liability protection.
* **Missing items**: Missing core role features: test, bug, validation, scenario
* **Next action**: Implement expected workflows for qa_specialist role.

### QualityAssuranceWorkflowScreen

* **Route**: `/staff/quality-assurance-workflow`
* **Component file**: `packages/primecare_ui/lib/src/screens/staff/quality_assurance_workflow_screen.dart`
* **Current stage**: Stage 4
* **Progress %**: 40%
* **Visual status**: `INTERACTIVE`
* **Business ready**: `No`
* **Meaningful Interaction Status**: `MEANINGFUL`
* **Screen Body Interactions**: 3
  * **Buttons**: 3
  * **Forms**: 0
  * **Filters**: 0
  * **Table Actions**: 0
  * **Clickable Cards**: 0
* **Global Navigation Count**: 0
* **Business Workflow Score**: 3
* **Role Expectation Score**: 1
* **Missing Business Features**: bug, check, validation, scenario, run
* **Purpose**: Operational workflow configuration and tracking screen for QualityAssuranceWorkflowScreen workflows.
* **Primary user goal**: Configure process tasks, track live workflow execution states, and review failed process blocks.
* **Expected user actions**: Edit task list nodes, restart failed workflow execution, sign off on completed steps.
* **Business reason**: Operational automation and validation of process steps.
* **Missing items**: Missing core role features: bug, check, validation, scenario, run
* **Next action**: Implement expected workflows for qa_specialist role.

### Quality Assurance Audits

* **Route**: `/generated/quality-assurance-audits`
* **Component file**: `apps/primecare_support/lib/features/generated_screens/quality_assurance_audits_screen.dart`
* **Current stage**: Stage 0
* **Progress %**: 0%
* **Visual status**: `INTERACTIVE`
* **Business ready**: `No`
* **Meaningful Interaction Status**: `MEANINGFUL`
* **Screen Body Interactions**: 8
  * **Buttons**: 4
  * **Forms**: 3
  * **Filters**: 1
  * **Table Actions**: 0
  * **Clickable Cards**: 0
* **Global Navigation Count**: 6
* **Business Workflow Score**: 7
* **Role Expectation Score**: 2
* **Missing Business Features**: bug, validation, scenario, run
* **Purpose**: Platform governance dashboard to view audit trails, runtime checks, database drift, and telemetry logs.
* **Primary user goal**: Verify system integrity, inspect security audit logs, and remediate registry configuration drift.
* **Expected user actions**: Run security sweep, download compliance audit files, approve database schema alterations.
* **Business reason**: Maintains platform regulatory security standards and code governance control rooms.
* **Missing items**: Missing core role features: bug, validation, scenario, run
* **Next action**: Implement expected workflows for qa_specialist role.

### Quality Assurance Complaints

* **Route**: `/generated/quality-assurance-complaints`
* **Component file**: `apps/primecare_support/lib/features/generated_screens/quality_assurance_complaints_screen.dart`
* **Current stage**: Stage 0
* **Progress %**: 0%
* **Visual status**: `INTERACTIVE`
* **Business ready**: `No`
* **Meaningful Interaction Status**: `MEANINGFUL`
* **Screen Body Interactions**: 8
  * **Buttons**: 4
  * **Forms**: 3
  * **Filters**: 1
  * **Table Actions**: 0
  * **Clickable Cards**: 0
* **Global Navigation Count**: 6
* **Business Workflow Score**: 8
* **Role Expectation Score**: 1
* **Missing Business Features**: bug, check, validation, scenario, run
* **Purpose**: Management workspace screen for Quality Assurance Complaints module access.
* **Primary user goal**: Review system records and coordinate day-to-day administrative functions.
* **Expected user actions**: Filter records, view items list, click item detail card, click edit/update buttons.
* **Business reason**: Supports general administrative oversight and recordkeeping.
* **Missing items**: Missing core role features: bug, check, validation, scenario, run
* **Next action**: Implement expected workflows for qa_specialist role.

### Quality Assurance Compliance Checks

* **Route**: `/generated/quality-assurance-compliance-checks`
* **Component file**: `apps/primecare_support/lib/features/generated_screens/quality_assurance_compliance_checks_screen.dart`
* **Current stage**: Stage 0
* **Progress %**: 0%
* **Visual status**: `INTERACTIVE`
* **Business ready**: `Yes`
* **Meaningful Interaction Status**: `MEANINGFUL`
* **Screen Body Interactions**: 8
  * **Buttons**: 4
  * **Forms**: 3
  * **Filters**: 1
  * **Table Actions**: 0
  * **Clickable Cards**: 0
* **Global Navigation Count**: 6
* **Business Workflow Score**: 8
* **Role Expectation Score**: 3
* **Missing Business Features**: bug, scenario, run
* **Purpose**: Regulatory compliance tracking and audit registry for Quality Assurance Compliance Checks protocols.
* **Primary user goal**: Review policy documents, verify training completion status, and log compliance incidents.
* **Expected user actions**: Check off policy read agreements, upload compliance proofs, search audit registers.
* **Business reason**: Mandatory safety oversight, legal compliance, and liability protection.
* **Missing items**: None
* **Next action**: None

### Quality Assurance Corrective Actions

* **Route**: `/generated/quality-assurance-corrective-actions`
* **Component file**: `apps/primecare_support/lib/features/generated_screens/quality_assurance_corrective_actions_screen.dart`
* **Current stage**: Stage 0
* **Progress %**: 0%
* **Visual status**: `INTERACTIVE`
* **Business ready**: `No`
* **Meaningful Interaction Status**: `MEANINGFUL`
* **Screen Body Interactions**: 8
  * **Buttons**: 4
  * **Forms**: 3
  * **Filters**: 1
  * **Table Actions**: 0
  * **Clickable Cards**: 0
* **Global Navigation Count**: 6
* **Business Workflow Score**: 7
* **Role Expectation Score**: 2
* **Missing Business Features**: bug, validation, scenario, run
* **Purpose**: Management workspace screen for Quality Assurance Corrective Actions module access.
* **Primary user goal**: Review system records and coordinate day-to-day administrative functions.
* **Expected user actions**: Filter records, view items list, click item detail card, click edit/update buttons.
* **Business reason**: Supports general administrative oversight and recordkeeping.
* **Missing items**: Missing core role features: bug, validation, scenario, run
* **Next action**: Implement expected workflows for qa_specialist role.

### Quality Assurance Reports

* **Route**: `/generated/quality-assurance-reports`
* **Component file**: `apps/primecare_support/lib/features/generated_screens/quality_assurance_reports_screen.dart`
* **Current stage**: Stage 0
* **Progress %**: 0%
* **Visual status**: `INTERACTIVE`
* **Business ready**: `No`
* **Meaningful Interaction Status**: `MEANINGFUL`
* **Screen Body Interactions**: 8
  * **Buttons**: 4
  * **Forms**: 3
  * **Filters**: 1
  * **Table Actions**: 0
  * **Clickable Cards**: 0
* **Global Navigation Count**: 6
* **Business Workflow Score**: 7
* **Role Expectation Score**: 1
* **Missing Business Features**: bug, check, validation, scenario, run
* **Purpose**: Management workspace screen for Quality Assurance Reports module access.
* **Primary user goal**: Review system records and coordinate day-to-day administrative functions.
* **Expected user actions**: Filter records, view items list, click item detail card, click edit/update buttons.
* **Business reason**: Supports general administrative oversight and recordkeeping.
* **Missing items**: Missing core role features: bug, check, validation, scenario, run
* **Next action**: Implement expected workflows for qa_specialist role.

### Quality Assurance Reviews

* **Route**: `/generated/quality-assurance-reviews`
* **Component file**: `apps/primecare_support/lib/features/generated_screens/quality_assurance_reviews_screen.dart`
* **Current stage**: Stage 0
* **Progress %**: 0%
* **Visual status**: `INTERACTIVE`
* **Business ready**: `No`
* **Meaningful Interaction Status**: `MEANINGFUL`
* **Screen Body Interactions**: 8
  * **Buttons**: 4
  * **Forms**: 3
  * **Filters**: 1
  * **Table Actions**: 0
  * **Clickable Cards**: 0
* **Global Navigation Count**: 6
* **Business Workflow Score**: 8
* **Role Expectation Score**: 2
* **Missing Business Features**: bug, validation, scenario, run
* **Purpose**: Management workspace screen for Quality Assurance Reviews module access.
* **Primary user goal**: Review system records and coordinate day-to-day administrative functions.
* **Expected user actions**: Filter records, view items list, click item detail card, click edit/update buttons.
* **Business reason**: Supports general administrative oversight and recordkeeping.
* **Missing items**: Missing core role features: bug, validation, scenario, run
* **Next action**: Implement expected workflows for qa_specialist role.

### Quality Assurance Scorecards

* **Route**: `/generated/quality-assurance-scorecards`
* **Component file**: `apps/primecare_support/lib/features/generated_screens/quality_assurance_scorecards_screen.dart`
* **Current stage**: Stage 0
* **Progress %**: 0%
* **Visual status**: `INTERACTIVE`
* **Business ready**: `Yes`
* **Meaningful Interaction Status**: `MEANINGFUL`
* **Screen Body Interactions**: 8
  * **Buttons**: 4
  * **Forms**: 3
  * **Filters**: 1
  * **Table Actions**: 0
  * **Clickable Cards**: 0
* **Global Navigation Count**: 6
* **Business Workflow Score**: 7
* **Role Expectation Score**: 3
* **Missing Business Features**: bug, scenario, run
* **Purpose**: Management workspace screen for Quality Assurance Scorecards module access.
* **Primary user goal**: Review system records and coordinate day-to-day administrative functions.
* **Expected user actions**: Filter records, view items list, click item detail card, click edit/update buttons.
* **Business reason**: Supports general administrative oversight and recordkeeping.
* **Missing items**: None
* **Next action**: None

### Quality Assurance Metrics

* **Route**: `/generated/quality-assurance-metrics`
* **Component file**: `packages/primecare_ui/lib/src/features/admin/quality_assurance_metrics.dart`
* **Current stage**: Stage 6
* **Progress %**: 60%
* **Visual status**: `NON_INTERACTIVE`
* **Business ready**: `No`
* **Meaningful Interaction Status**: `READ_ONLY_VALID`
* **Screen Body Interactions**: 0
  * **Buttons**: 0
  * **Forms**: 0
  * **Filters**: 0
  * **Table Actions**: 0
  * **Clickable Cards**: 0
* **Global Navigation Count**: 1
* **Business Workflow Score**: 2
* **Role Expectation Score**: 2
* **Missing Business Features**: bug, validation, scenario, run
* **Purpose**: Non-interactive visual placeholder. Screen has no actionable widgets or controls.
* **Primary user goal**: None - no user goals can be accomplished on this screen.
* **Expected user actions**: None
* **Business reason**: Empty stub or placeholder showing no read-only or transactional value.
* **Missing items**: Missing core role features: bug, validation, scenario, run
* **Next action**: Implement expected workflows for qa_specialist role.

## Screens to Fix First

1. **Quality Assurance Audits** (Progress: 0%, Business Score: 7, Role Score: 2)  
   *Reason*: Missing core workflows/features: bug, validation, scenario, run
2. **Quality Assurance Complaints** (Progress: 0%, Business Score: 8, Role Score: 1)  
   *Reason*: Missing core workflows/features: bug, check, validation, scenario, run
3. **Quality Assurance Corrective Actions** (Progress: 0%, Business Score: 7, Role Score: 2)  
   *Reason*: Missing core workflows/features: bug, validation, scenario, run
4. **Quality Assurance Reports** (Progress: 0%, Business Score: 7, Role Score: 1)  
   *Reason*: Missing core workflows/features: bug, check, validation, scenario, run
5. **Quality Assurance Reviews** (Progress: 0%, Business Score: 8, Role Score: 2)  
   *Reason*: Missing core workflows/features: bug, validation, scenario, run
6. **QaAnalyticsScreen** (Progress: 40%, Business Score: 2, Role Score: 1)  
   *Reason*: Missing core workflows/features: bug, check, validation, scenario, run
7. **QaWorkflowScreen** (Progress: 40%, Business Score: 3, Role Score: 1)  
   *Reason*: Missing core workflows/features: bug, check, validation, scenario, run
8. **QualityAssuranceAnalyticsScreen** (Progress: 40%, Business Score: 2, Role Score: 1)  
   *Reason*: Missing core workflows/features: bug, check, validation, scenario, run
9. **QualityAssuranceWorkflowScreen** (Progress: 40%, Business Score: 3, Role Score: 1)  
   *Reason*: Missing core workflows/features: bug, check, validation, scenario, run
10. **QaDashboardScreen** (Progress: 50%, Business Score: 5, Role Score: 2)  
   *Reason*: Missing core workflows/features: test, bug, validation, scenario

## Recommended Build Order

### 1. Must Fix Now (High Priority)
- Quality Assurance Audits (Implement role-specific workflows and transactional features)
- Quality Assurance Complaints (Implement role-specific workflows and transactional features)
- Quality Assurance Corrective Actions (Implement role-specific workflows and transactional features)
- Quality Assurance Reports (Implement role-specific workflows and transactional features)
- Quality Assurance Reviews (Implement role-specific workflows and transactional features)

### 2. Fix Next (Medium Priority)
- None (All screens are functionally complete)

### 3. Polish Later (Low Priority)
- Quality Assurance Compliance Checks (Micro-interactions and design alignment polish)
- Quality Assurance Scorecards (Micro-interactions and design alignment polish)

### 4. Consider Merging / Deleting
- None (Zero duplicate screens identified)
