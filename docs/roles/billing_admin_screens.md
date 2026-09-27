# Billing Administrator

## Role Summary

* **Role key**: `billing_admin`
* **Role category**: `franchise`
* **Total screens**: 5
* **Business ready screens**: 2
* **Incomplete screens**: 5
* **False progress screens**: 0
* **Zero Screen-Body Interaction screens**: 0
* **Average progress**: 36.0%
* **Average screen-body interactions**: 4.4

## Screen List

| Screen Name | Route Path | Body Interactions | Global Nav | Status | Business Score | Role Score | Missing Business Features | Business Ready |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| BillingAdminDashboardScreen | `/offices/franchise/roles/billing_admin/dashboard` | 4 | 1 | `MEANINGFUL` | 5 | 3 | claim, insurance, payment | **Yes** |
| BillingAdminAnalyticsScreen | `/staff/billing-admin-analytics` | 3 | 0 | `MEANINGFUL` | 3 | 1 | claim, insurance, invoice, payment, reconciliation | **No** |
| BillingAdminComplianceScreen | `/staff/billing-admin-compliance` | 4 | 1 | `MEANINGFUL` | 4 | 1 | claim, insurance, invoice, payment, reconciliation | **No** |
| BillingAdminWorkflowScreen | `/staff/billing-admin-workflow` | 3 | 0 | `MEANINGFUL` | 2 | 1 | claim, insurance, invoice, payment, reconciliation | **No** |
| Billing Admin Invoices | `/offices/franchise/roles/billing_admin/invoices` | 8 | 6 | `MEANINGFUL` | 7 | 3 | claim, insurance, reconciliation | **Yes** |

## Screen Details

### BillingAdminDashboardScreen

* **Route**: `/offices/franchise/roles/billing_admin/dashboard`
* **Component file**: `packages/primecare_ui/lib/src/screens/staff/billing_admin_dashboard_screen.dart`
* **Current stage**: Stage 5
* **Progress %**: 50%
* **Visual status**: `INTERACTIVE`
* **Business ready**: `Yes`
* **Meaningful Interaction Status**: `MEANINGFUL`
* **Screen Body Interactions**: 4
  * **Buttons**: 4
  * **Forms**: 0
  * **Filters**: 0
  * **Table Actions**: 0
  * **Clickable Cards**: 0
* **Global Navigation Count**: 1
* **Business Workflow Score**: 5
* **Role Expectation Score**: 3
* **Missing Business Features**: claim, insurance, payment
* **Purpose**: Management workspace screen for BillingAdminDashboardScreen module access.
* **Primary user goal**: Review system records and coordinate day-to-day administrative functions.
* **Expected user actions**: Filter records, view items list, click item detail card, click edit/update buttons.
* **Business reason**: Supports general administrative oversight and recordkeeping.
* **Missing items**: None
* **Next action**: None

### BillingAdminAnalyticsScreen

* **Route**: `/staff/billing-admin-analytics`
* **Component file**: `packages/primecare_ui/lib/src/screens/staff/billing_admin_analytics_screen.dart`
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
* **Missing Business Features**: claim, insurance, invoice, payment, reconciliation
* **Purpose**: Business intelligence analytics dashboard for BillingAdminAnalyticsScreen to monitor performance trends.
* **Primary user goal**: Review historical metrics, filter performance reports, and analyze operational trends.
* **Expected user actions**: Select date range filter, export chart data to CSV, switch between metric tab displays.
* **Business reason**: Data-driven performance tracking and resource allocation forecasting.
* **Missing items**: Missing core role features: claim, insurance, invoice, payment, reconciliation
* **Next action**: Implement expected workflows for billing_admin role.

### BillingAdminComplianceScreen

* **Route**: `/staff/billing-admin-compliance`
* **Component file**: `packages/primecare_ui/lib/src/screens/staff/billing_admin_compliance_screen.dart`
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
* **Business Workflow Score**: 4
* **Role Expectation Score**: 1
* **Missing Business Features**: claim, insurance, invoice, payment, reconciliation
* **Purpose**: Regulatory compliance tracking and audit registry for BillingAdminComplianceScreen protocols.
* **Primary user goal**: Review policy documents, verify training completion status, and log compliance incidents.
* **Expected user actions**: Check off policy read agreements, upload compliance proofs, search audit registers.
* **Business reason**: Mandatory safety oversight, legal compliance, and liability protection.
* **Missing items**: Missing core role features: claim, insurance, invoice, payment, reconciliation
* **Next action**: Implement expected workflows for billing_admin role.

### BillingAdminWorkflowScreen

* **Route**: `/staff/billing-admin-workflow`
* **Component file**: `packages/primecare_ui/lib/src/screens/staff/billing_admin_workflow_screen.dart`
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
* **Missing Business Features**: claim, insurance, invoice, payment, reconciliation
* **Purpose**: Operational workflow configuration and tracking screen for BillingAdminWorkflowScreen workflows.
* **Primary user goal**: Configure process tasks, track live workflow execution states, and review failed process blocks.
* **Expected user actions**: Edit task list nodes, restart failed workflow execution, sign off on completed steps.
* **Business reason**: Operational automation and validation of process steps.
* **Missing items**: Missing core role features: claim, insurance, invoice, payment, reconciliation
* **Next action**: Implement expected workflows for billing_admin role.

### Billing Admin Invoices

* **Route**: `/offices/franchise/roles/billing_admin/invoices`
* **Component file**: `apps/primecare_franchise/lib/features/generated_screens/billing_admin_invoices_screen.dart`
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
* **Missing Business Features**: claim, insurance, reconciliation
* **Purpose**: Management workspace screen for Billing Admin Invoices module access.
* **Primary user goal**: Review system records and coordinate day-to-day administrative functions.
* **Expected user actions**: Filter records, view items list, click item detail card, click edit/update buttons.
* **Business reason**: Supports general administrative oversight and recordkeeping.
* **Missing items**: None
* **Next action**: None

## Screens to Fix First

1. **BillingAdminAnalyticsScreen** (Progress: 40%, Business Score: 3, Role Score: 1)  
   *Reason*: Missing core workflows/features: claim, insurance, invoice, payment, reconciliation
2. **BillingAdminWorkflowScreen** (Progress: 40%, Business Score: 2, Role Score: 1)  
   *Reason*: Missing core workflows/features: claim, insurance, invoice, payment, reconciliation
3. **BillingAdminComplianceScreen** (Progress: 50%, Business Score: 4, Role Score: 1)  
   *Reason*: Missing core workflows/features: claim, insurance, invoice, payment, reconciliation

## Recommended Build Order

### 1. Must Fix Now (High Priority)
- BillingAdminAnalyticsScreen (Implement role-specific workflows and transactional features)
- BillingAdminWorkflowScreen (Implement role-specific workflows and transactional features)
- BillingAdminComplianceScreen (Implement role-specific workflows and transactional features)

### 2. Fix Next (Medium Priority)
- None (All screens are functionally complete)

### 3. Polish Later (Low Priority)
- Billing Admin Invoices (Micro-interactions and design alignment polish)
- BillingAdminDashboardScreen (Micro-interactions and design alignment polish)

### 4. Consider Merging / Deleting
- None (Zero duplicate screens identified)
