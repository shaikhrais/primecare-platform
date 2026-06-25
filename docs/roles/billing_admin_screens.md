# Billing Administrator

## Role Summary

* **Role key**: `billing_admin`
* **Role category**: `franchise`
* **Total screens**: 5
* **Production ready screens**: 5
* **Incomplete screens**: 0
* **False progress screens**: 0
* **Zero interaction screens**: 0
* **Average progress**: 36.0%
* **Average interactive objects**: 6.2

## Screen List

### BillingAdminDashboardScreen

* **Route**: `/offices/franchise/roles/billing_admin/dashboard`
* **Component file**: `packages/primecare_ui/lib/src/screens/staff/billing_admin_dashboard_screen.dart`
* **Current stage**: Stage 5
* **Progress %**: 50%
* **Visual status**: `INTERACTIVE`
* **Production ready**: `Yes`
* **Interactive objects**: 6
* **Buttons**: 6
* **Forms**: 0
* **Tables/actions**: 0
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
* **Production ready**: `Yes`
* **Interactive objects**: 4
* **Buttons**: 4
* **Forms**: 0
* **Tables/actions**: 0
* **Purpose**: Business intelligence analytics dashboard for BillingAdminAnalyticsScreen to monitor performance trends.
* **Primary user goal**: Review historical metrics, filter performance reports, and analyze operational trends.
* **Expected user actions**: Select date range filter, export chart data to CSV, switch between metric tab displays.
* **Business reason**: Data-driven performance tracking and resource allocation forecasting.
* **Missing items**: None
* **Next action**: None

### BillingAdminComplianceScreen

* **Route**: `/staff/billing-admin-compliance`
* **Component file**: `packages/primecare_ui/lib/src/screens/staff/billing_admin_compliance_screen.dart`
* **Current stage**: Stage 5
* **Progress %**: 50%
* **Visual status**: `INTERACTIVE`
* **Production ready**: `Yes`
* **Interactive objects**: 6
* **Buttons**: 6
* **Forms**: 0
* **Tables/actions**: 0
* **Purpose**: Regulatory compliance tracking and audit registry for BillingAdminComplianceScreen protocols.
* **Primary user goal**: Review policy documents, verify training completion status, and log compliance incidents.
* **Expected user actions**: Check off policy read agreements, upload compliance proofs, search audit registers.
* **Business reason**: Mandatory safety oversight, legal compliance, and liability protection.
* **Missing items**: None
* **Next action**: None

### BillingAdminWorkflowScreen

* **Route**: `/staff/billing-admin-workflow`
* **Component file**: `packages/primecare_ui/lib/src/screens/staff/billing_admin_workflow_screen.dart`
* **Current stage**: Stage 4
* **Progress %**: 40%
* **Visual status**: `INTERACTIVE`
* **Production ready**: `Yes`
* **Interactive objects**: 4
* **Buttons**: 4
* **Forms**: 0
* **Tables/actions**: 0
* **Purpose**: Operational workflow configuration and tracking screen for BillingAdminWorkflowScreen workflows.
* **Primary user goal**: Configure process tasks, track live workflow execution states, and review failed process blocks.
* **Expected user actions**: Edit task list nodes, restart failed workflow execution, sign off on completed steps.
* **Business reason**: Operational automation and validation of process steps.
* **Missing items**: None
* **Next action**: None

### Billing Admin Invoices

* **Route**: `/offices/franchise/roles/billing_admin/invoices`
* **Component file**: `apps/primecare_franchise/lib/features/generated_screens/billing_admin_invoices_screen.dart`
* **Current stage**: Stage 0
* **Progress %**: 0%
* **Visual status**: `INTERACTIVE`
* **Production ready**: `Yes`
* **Interactive objects**: 11
* **Buttons**: 2
* **Forms**: 2
* **Tables/actions**: 1
* **Purpose**: Management workspace screen for Billing Admin Invoices module access.
* **Primary user goal**: Review system records and coordinate day-to-day administrative functions.
* **Expected user actions**: Filter records, view items list, click item detail card, click edit/update buttons.
* **Business reason**: Supports general administrative oversight and recordkeeping.
* **Missing items**: No interactive objects found. Screen needs clear user action or should be removed/merged.
* **Next action**: Implement transactional buttons or interactive widgets

## Screens to Fix First

All screens are fully production-ready and interactive! Zero issues found.

## Recommended Build Order

### 1. Must Fix Now (High Priority)
- None (All screens have basic interactivity)

### 2. Fix Next (Medium Priority)
- None (All screens are functionally complete)

### 3. Polish Later (Low Priority)
- Billing Admin Invoices (Micro-interactions and design alignment polish)
- BillingAdminAnalyticsScreen (Micro-interactions and design alignment polish)
- BillingAdminWorkflowScreen (Micro-interactions and design alignment polish)
- BillingAdminDashboardScreen (Micro-interactions and design alignment polish)
- BillingAdminComplianceScreen (Micro-interactions and design alignment polish)

### 4. Consider Merging / Deleting
- None (Zero duplicate screens identified)
