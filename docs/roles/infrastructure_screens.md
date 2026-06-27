# Infrastructure Auditor

## Role Summary

* **Role key**: `infrastructure`
* **Role category**: `common`
* **Total screens**: 5
* **Business ready screens**: 0
* **Incomplete screens**: 5
* **False progress screens**: 0
* **Zero Screen-Body Interaction screens**: 0
* **Average progress**: 44.0%
* **Average screen-body interactions**: 3.2

## Screen List

| Screen Name | Route Path | Body Interactions | Global Nav | Status | Business Score | Role Score | Missing Business Features | Business Ready |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| InfrastructureDashboardScreen | `/common/infrastructure-dashboard` | 2 | 1 | `LOW_INTERACTION` | 5 | 1 | server, network, hardware, maintenance | **No** |
| InfrastructureAnalyticsScreen | `/common/infrastructure-analytics` | 2 | 1 | `LOW_INTERACTION` | 3 | 2 | server, hardware, maintenance | **No** |
| InfrastructureComplianceScreen | `/common/infrastructure-compliance` | 2 | 1 | `LOW_INTERACTION` | 5 | 1 | server, network, hardware, maintenance | **No** |
| InfrastructureWorkflowScreen | `/common/infrastructure-workflow` | 2 | 1 | `LOW_INTERACTION` | 4 | 2 | server, hardware, maintenance | **No** |
| It Admin Dashboard | `/offices/corporate/roles/it_admin/dashboard` | 8 | 6 | `MEANINGFUL` | 7 | 2 | network, hardware, maintenance | **No** |

## Screen Details

### InfrastructureDashboardScreen

* **Route**: `/common/infrastructure-dashboard`
* **Component file**: `packages/primecare_ui/lib/src/screens/common/infrastructure_dashboard_screen.dart`
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
* **Role Expectation Score**: 1
* **Missing Business Features**: server, network, hardware, maintenance
* **Purpose**: Management workspace screen for InfrastructureDashboardScreen module access.
* **Primary user goal**: Review system records and coordinate day-to-day administrative functions.
* **Expected user actions**: Filter records, view items list, click item detail card, click edit/update buttons.
* **Business reason**: Supports general administrative oversight and recordkeeping.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### InfrastructureAnalyticsScreen

* **Route**: `/common/infrastructure-analytics`
* **Component file**: `packages/primecare_ui/lib/src/screens/staff/infrastructure_analytics_screen.dart`
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
* **Missing Business Features**: server, hardware, maintenance
* **Purpose**: Business intelligence analytics dashboard for InfrastructureAnalyticsScreen to monitor performance trends.
* **Primary user goal**: Review historical metrics, filter performance reports, and analyze operational trends.
* **Expected user actions**: Select date range filter, export chart data to CSV, switch between metric tab displays.
* **Business reason**: Data-driven performance tracking and resource allocation forecasting.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### InfrastructureComplianceScreen

* **Route**: `/common/infrastructure-compliance`
* **Component file**: `packages/primecare_ui/lib/src/screens/common/infrastructure_compliance_screen.dart`
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
* **Role Expectation Score**: 1
* **Missing Business Features**: server, network, hardware, maintenance
* **Purpose**: Regulatory compliance tracking and audit registry for InfrastructureComplianceScreen protocols.
* **Primary user goal**: Review policy documents, verify training completion status, and log compliance incidents.
* **Expected user actions**: Check off policy read agreements, upload compliance proofs, search audit registers.
* **Business reason**: Mandatory safety oversight, legal compliance, and liability protection.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### InfrastructureWorkflowScreen

* **Route**: `/common/infrastructure-workflow`
* **Component file**: `packages/primecare_ui/lib/src/screens/staff/infrastructure_workflow_screen.dart`
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
* **Role Expectation Score**: 2
* **Missing Business Features**: server, hardware, maintenance
* **Purpose**: Operational workflow configuration and tracking screen for InfrastructureWorkflowScreen workflows.
* **Primary user goal**: Configure process tasks, track live workflow execution states, and review failed process blocks.
* **Expected user actions**: Edit task list nodes, restart failed workflow execution, sign off on completed steps.
* **Business reason**: Operational automation and validation of process steps.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### It Admin Dashboard

* **Route**: `/offices/corporate/roles/it_admin/dashboard`
* **Component file**: `apps/primecare_corporate/lib/features/itadmin/screens/it_admin_dashboard_screen.dart`
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
* **Missing Business Features**: network, hardware, maintenance
* **Purpose**: Management workspace screen for It Admin Dashboard module access.
* **Primary user goal**: Review system records and coordinate day-to-day administrative functions.
* **Expected user actions**: Filter records, view items list, click item detail card, click edit/update buttons.
* **Business reason**: Supports general administrative oversight and recordkeeping.
* **Missing items**: Missing core role features: network, hardware, maintenance
* **Next action**: Implement expected workflows for infrastructure role.

## Screens to Fix First

1. **It Admin Dashboard** (Progress: 0%, Business Score: 7, Role Score: 2)  
   *Reason*: Missing core workflows/features: network, hardware, maintenance
2. **InfrastructureDashboardScreen** (Progress: 50%, Business Score: 5, Role Score: 1)  
   *Reason*: Missing core workflows/features: server, network, hardware, maintenance
3. **InfrastructureComplianceScreen** (Progress: 50%, Business Score: 5, Role Score: 1)  
   *Reason*: Missing core workflows/features: server, network, hardware, maintenance
4. **InfrastructureAnalyticsScreen** (Progress: 60%, Business Score: 3, Role Score: 2)  
   *Reason*: Missing core workflows/features: server, hardware, maintenance
5. **InfrastructureWorkflowScreen** (Progress: 60%, Business Score: 4, Role Score: 2)  
   *Reason*: Missing core workflows/features: server, hardware, maintenance

## Recommended Build Order

### 1. Must Fix Now (High Priority)
- It Admin Dashboard (Implement role-specific workflows and transactional features)
- InfrastructureDashboardScreen (Implement role-specific workflows and transactional features)
- InfrastructureComplianceScreen (Implement role-specific workflows and transactional features)
- InfrastructureAnalyticsScreen (Implement role-specific workflows and transactional features)
- InfrastructureWorkflowScreen (Implement role-specific workflows and transactional features)

### 2. Fix Next (Medium Priority)
- None (All screens are functionally complete)

### 3. Polish Later (Low Priority)
- None (All screens fully completed and polished)

### 4. Consider Merging / Deleting
- None (Zero duplicate screens identified)
