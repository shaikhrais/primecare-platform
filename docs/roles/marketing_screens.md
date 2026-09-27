# Head of Marketing

## Role Summary

* **Role key**: `marketing`
* **Role category**: `corporate`
* **Total screens**: 17
* **Business ready screens**: 8
* **Incomplete screens**: 17
* **False progress screens**: 0
* **Zero Screen-Body Interaction screens**: 1
* **Average progress**: 24.1%
* **Average screen-body interactions**: 5.1

## Screen List

| Screen Name | Route Path | Body Interactions | Global Nav | Status | Business Score | Role Score | Missing Business Features | Business Ready |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| HeadOfMarketingDashboardScreen | `/offices/corporate/roles/head_of_marketing/dashboard` | 3 | 0 | `MEANINGFUL` | 3 | 3 | analytics, social-media | **Yes** |
| HeadOfMarketingAnalyticsScreen | `/management/head-of-marketing-analytics` | 2 | 0 | `LOW_INTERACTION` | 4 | 3 | lead, social-media | **Yes** |
| HeadOfMarketingComplianceScreen | `/management/head-of-marketing-compliance` | 2 | 1 | `LOW_INTERACTION` | 6 | 3 | lead, social-media | **Yes** |
| HeadOfMarketingWorkflowScreen | `/management/head-of-marketing-workflow` | 2 | 0 | `LOW_INTERACTION` | 2 | 2 | lead, analytics, social-media | **No** |
| CampaignDashboardScreen | `/management/campaign-dashboard` | 2 | 1 | `LOW_INTERACTION` | 4 | 3 | lead, social-media | **Yes** |
| Marketing Manager Campaigns | `/offices/franchise/roles/marketing_manager/campaigns` | 8 | 6 | `MEANINGFUL` | 7 | 2 | budget, analytics, social-media | **No** |
| Marketing Manager Dashboard | `/offices/franchise/roles/marketing_manager/dashboard` | 8 | 6 | `MEANINGFUL` | 8 | 1 | campaign, budget, analytics, social-media | **No** |
| Head Of Marketing Brand Assets | `/generated/head-of-marketing-brand-assets` | 8 | 6 | `MEANINGFUL` | 8 | 1 | campaign, budget, analytics, social-media | **No** |
| Head Of Marketing Campaigns | `/generated/head-of-marketing-campaigns` | 8 | 6 | `MEANINGFUL` | 7 | 3 | analytics, social-media | **Yes** |
| Head Of Marketing Content Approval | `/generated/head-of-marketing-content-approval` | 8 | 6 | `MEANINGFUL` | 10 | 1 | campaign, budget, analytics, social-media | **No** |
| Head Of Marketing Funnel Analytics | `/generated/head-of-marketing-funnel-analytics` | 8 | 6 | `MEANINGFUL` | 8 | 2 | campaign, budget, social-media | **No** |
| Head Of Marketing Leads | `/generated/head-of-marketing-leads` | 8 | 6 | `MEANINGFUL` | 7 | 1 | campaign, budget, analytics, social-media | **No** |
| Head Of Marketing Performance Reports | `/generated/head-of-marketing-performance-reports` | 8 | 6 | `MEANINGFUL` | 7 | 3 | analytics, social-media | **Yes** |
| Head Of Marketing Regional Campaigns | `/generated/head-of-marketing-regional-campaigns` | 8 | 6 | `MEANINGFUL` | 7 | 2 | budget, analytics, social-media | **No** |
| Marketing R O I Report | `/generated/marketing-r-o-i-report` | 0 | 2 | `READ_ONLY_VALID` | 5 | 3 | budget, social-media | **Yes** |
| Email Marketing Automator | `/generated/email-marketing-automator` | 1 | 2 | `LOW_INTERACTION` | 4 | 0 | campaign, lead, budget, analytics, social-media | **No** |
| HeadOfMarketingDashboardScreen | `packages/primecare_ui/lib/src/screens/management/head_of_marketing_dashboard_screen.dart` | 3 | 0 | `MEANINGFUL` | 3 | 3 | analytics, social-media | **Yes** |

## Screen Details

### HeadOfMarketingDashboardScreen

* **Route**: `/offices/corporate/roles/head_of_marketing/dashboard`
* **Component file**: `packages/primecare_ui/lib/src/features/generated_screens/head_of_marketing_dashboard.dart`
* **Current stage**: Stage 5
* **Progress %**: 50%
* **Visual status**: `INTERACTIVE`
* **Business ready**: `Yes`
* **Meaningful Interaction Status**: `MEANINGFUL`
* **Screen Body Interactions**: 3
  * **Buttons**: 1
  * **Forms**: 1
  * **Filters**: 0
  * **Table Actions**: 1
  * **Clickable Cards**: 0
* **Global Navigation Count**: 0
* **Business Workflow Score**: 3
* **Role Expectation Score**: 3
* **Missing Business Features**: analytics, social-media
* **Purpose**: Management workspace screen for HeadOfMarketingDashboardScreen module access.
* **Primary user goal**: Review system records and coordinate day-to-day administrative functions.
* **Expected user actions**: Filter records, view items list, click item detail card, click edit/update buttons.
* **Business reason**: Supports general administrative oversight and recordkeeping.
* **Missing items**: None
* **Next action**: None

### HeadOfMarketingAnalyticsScreen

* **Route**: `/management/head-of-marketing-analytics`
* **Component file**: `packages/primecare_ui/lib/src/screens/management/head_of_marketing_analytics_screen.dart`
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
* **Business Workflow Score**: 4
* **Role Expectation Score**: 3
* **Missing Business Features**: lead, social-media
* **Purpose**: Business intelligence analytics dashboard for HeadOfMarketingAnalyticsScreen to monitor performance trends.
* **Primary user goal**: Review historical metrics, filter performance reports, and analyze operational trends.
* **Expected user actions**: Select date range filter, export chart data to CSV, switch between metric tab displays.
* **Business reason**: Data-driven performance tracking and resource allocation forecasting.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### HeadOfMarketingComplianceScreen

* **Route**: `/management/head-of-marketing-compliance`
* **Component file**: `packages/primecare_ui/lib/src/screens/management/head_of_marketing_compliance_screen.dart`
* **Current stage**: Stage 5
* **Progress %**: 50%
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
* **Missing Business Features**: lead, social-media
* **Purpose**: Regulatory compliance tracking and audit registry for HeadOfMarketingComplianceScreen protocols.
* **Primary user goal**: Review policy documents, verify training completion status, and log compliance incidents.
* **Expected user actions**: Check off policy read agreements, upload compliance proofs, search audit registers.
* **Business reason**: Mandatory safety oversight, legal compliance, and liability protection.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### HeadOfMarketingWorkflowScreen

* **Route**: `/management/head-of-marketing-workflow`
* **Component file**: `packages/primecare_ui/lib/src/screens/management/head_of_marketing_workflow_screen.dart`
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
* **Role Expectation Score**: 2
* **Missing Business Features**: lead, analytics, social-media
* **Purpose**: Operational workflow configuration and tracking screen for HeadOfMarketingWorkflowScreen workflows.
* **Primary user goal**: Configure process tasks, track live workflow execution states, and review failed process blocks.
* **Expected user actions**: Edit task list nodes, restart failed workflow execution, sign off on completed steps.
* **Business reason**: Operational automation and validation of process steps.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### CampaignDashboardScreen

* **Route**: `/management/campaign-dashboard`
* **Component file**: `packages/primecare_ui/lib/src/screens/management/campaign_dashboard_screen.dart`
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
* **Business Workflow Score**: 4
* **Role Expectation Score**: 3
* **Missing Business Features**: lead, social-media
* **Purpose**: Management workspace screen for CampaignDashboardScreen module access.
* **Primary user goal**: Review system records and coordinate day-to-day administrative functions.
* **Expected user actions**: Filter records, view items list, click item detail card, click edit/update buttons.
* **Business reason**: Supports general administrative oversight and recordkeeping.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### Marketing Manager Campaigns

* **Route**: `/offices/franchise/roles/marketing_manager/campaigns`
* **Component file**: `apps/primecare_franchise/lib/features/marketing_manager/screens/marketing_manager_campaigns_screen.dart`
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
* **Missing Business Features**: budget, analytics, social-media
* **Purpose**: Management workspace screen for Marketing Manager Campaigns module access.
* **Primary user goal**: Review system records and coordinate day-to-day administrative functions.
* **Expected user actions**: Filter records, view items list, click item detail card, click edit/update buttons.
* **Business reason**: Supports general administrative oversight and recordkeeping.
* **Missing items**: Missing core role features: budget, analytics, social-media
* **Next action**: Implement expected workflows for marketing role.

### Marketing Manager Dashboard

* **Route**: `/offices/franchise/roles/marketing_manager/dashboard`
* **Component file**: `apps/primecare_franchise/lib/features/marketing_manager/screens/marketing_manager_dashboard_screen.dart`
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
* **Missing Business Features**: campaign, budget, analytics, social-media
* **Purpose**: Management workspace screen for Marketing Manager Dashboard module access.
* **Primary user goal**: Review system records and coordinate day-to-day administrative functions.
* **Expected user actions**: Filter records, view items list, click item detail card, click edit/update buttons.
* **Business reason**: Supports general administrative oversight and recordkeeping.
* **Missing items**: Missing core role features: campaign, budget, analytics, social-media
* **Next action**: Implement expected workflows for marketing role.

### Head Of Marketing Brand Assets

* **Route**: `/generated/head-of-marketing-brand-assets`
* **Component file**: `apps/primecare_marketing/lib/features/generated_screens/head_of_marketing_brand_assets_screen.dart`
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
* **Missing Business Features**: campaign, budget, analytics, social-media
* **Purpose**: Management workspace screen for Head Of Marketing Brand Assets module access.
* **Primary user goal**: Review system records and coordinate day-to-day administrative functions.
* **Expected user actions**: Filter records, view items list, click item detail card, click edit/update buttons.
* **Business reason**: Supports general administrative oversight and recordkeeping.
* **Missing items**: Missing core role features: campaign, budget, analytics, social-media
* **Next action**: Implement expected workflows for marketing role.

### Head Of Marketing Campaigns

* **Route**: `/generated/head-of-marketing-campaigns`
* **Component file**: `apps/primecare_marketing/lib/features/generated_screens/head_of_marketing_campaigns_screen.dart`
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
* **Missing Business Features**: analytics, social-media
* **Purpose**: Management workspace screen for Head Of Marketing Campaigns module access.
* **Primary user goal**: Review system records and coordinate day-to-day administrative functions.
* **Expected user actions**: Filter records, view items list, click item detail card, click edit/update buttons.
* **Business reason**: Supports general administrative oversight and recordkeeping.
* **Missing items**: None
* **Next action**: None

### Head Of Marketing Content Approval

* **Route**: `/generated/head-of-marketing-content-approval`
* **Component file**: `apps/primecare_marketing/lib/features/generated_screens/head_of_marketing_content_approval_screen.dart`
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
* **Business Workflow Score**: 10
* **Role Expectation Score**: 1
* **Missing Business Features**: campaign, budget, analytics, social-media
* **Purpose**: Management workspace screen for Head Of Marketing Content Approval module access.
* **Primary user goal**: Review system records and coordinate day-to-day administrative functions.
* **Expected user actions**: Filter records, view items list, click item detail card, click edit/update buttons.
* **Business reason**: Supports general administrative oversight and recordkeeping.
* **Missing items**: Missing core role features: campaign, budget, analytics, social-media
* **Next action**: Implement expected workflows for marketing role.

### Head Of Marketing Funnel Analytics

* **Route**: `/generated/head-of-marketing-funnel-analytics`
* **Component file**: `apps/primecare_marketing/lib/features/generated_screens/head_of_marketing_funnel_analytics_screen.dart`
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
* **Missing Business Features**: campaign, budget, social-media
* **Purpose**: Business intelligence analytics dashboard for Head Of Marketing Funnel Analytics to monitor performance trends.
* **Primary user goal**: Review historical metrics, filter performance reports, and analyze operational trends.
* **Expected user actions**: Select date range filter, export chart data to CSV, switch between metric tab displays.
* **Business reason**: Data-driven performance tracking and resource allocation forecasting.
* **Missing items**: Missing core role features: campaign, budget, social-media
* **Next action**: Implement expected workflows for marketing role.

### Head Of Marketing Leads

* **Route**: `/generated/head-of-marketing-leads`
* **Component file**: `apps/primecare_marketing/lib/features/generated_screens/head_of_marketing_leads_screen.dart`
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
* **Missing Business Features**: campaign, budget, analytics, social-media
* **Purpose**: Management workspace screen for Head Of Marketing Leads module access.
* **Primary user goal**: Review system records and coordinate day-to-day administrative functions.
* **Expected user actions**: Filter records, view items list, click item detail card, click edit/update buttons.
* **Business reason**: Supports general administrative oversight and recordkeeping.
* **Missing items**: Missing core role features: campaign, budget, analytics, social-media
* **Next action**: Implement expected workflows for marketing role.

### Head Of Marketing Performance Reports

* **Route**: `/generated/head-of-marketing-performance-reports`
* **Component file**: `apps/primecare_marketing/lib/features/generated_screens/head_of_marketing_performance_reports_screen.dart`
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
* **Missing Business Features**: analytics, social-media
* **Purpose**: Management workspace screen for Head Of Marketing Performance Reports module access.
* **Primary user goal**: Review system records and coordinate day-to-day administrative functions.
* **Expected user actions**: Filter records, view items list, click item detail card, click edit/update buttons.
* **Business reason**: Supports general administrative oversight and recordkeeping.
* **Missing items**: None
* **Next action**: None

### Head Of Marketing Regional Campaigns

* **Route**: `/generated/head-of-marketing-regional-campaigns`
* **Component file**: `apps/primecare_marketing/lib/features/generated_screens/head_of_marketing_regional_campaigns_screen.dart`
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
* **Missing Business Features**: budget, analytics, social-media
* **Purpose**: Management workspace screen for Head Of Marketing Regional Campaigns module access.
* **Primary user goal**: Review system records and coordinate day-to-day administrative functions.
* **Expected user actions**: Filter records, view items list, click item detail card, click edit/update buttons.
* **Business reason**: Supports general administrative oversight and recordkeeping.
* **Missing items**: Missing core role features: budget, analytics, social-media
* **Next action**: Implement expected workflows for marketing role.

### Marketing R O I Report

* **Route**: `/generated/marketing-r-o-i-report`
* **Component file**: `packages/primecare_ui/lib/src/features/analytics/marketing_roi_report.dart`
* **Current stage**: Stage 6
* **Progress %**: 60%
* **Visual status**: `NON_INTERACTIVE`
* **Business ready**: `Yes`
* **Meaningful Interaction Status**: `READ_ONLY_VALID`
* **Screen Body Interactions**: 0
  * **Buttons**: 0
  * **Forms**: 0
  * **Filters**: 0
  * **Table Actions**: 0
  * **Clickable Cards**: 0
* **Global Navigation Count**: 2
* **Business Workflow Score**: 5
* **Role Expectation Score**: 3
* **Missing Business Features**: budget, social-media
* **Purpose**: Non-interactive visual placeholder. Screen has no actionable widgets or controls.
* **Primary user goal**: None - no user goals can be accomplished on this screen.
* **Expected user actions**: None
* **Business reason**: Empty stub or placeholder showing no read-only or transactional value.
* **Missing items**: None
* **Next action**: None

### Email Marketing Automator

* **Route**: `/generated/email-marketing-automator`
* **Component file**: `packages/primecare_ui/lib/src/features/marketing/email_marketing_automator.dart`
* **Current stage**: Stage 6
* **Progress %**: 60%
* **Visual status**: `INTERACTIVE`
* **Business ready**: `No`
* **Meaningful Interaction Status**: `LOW_INTERACTION`
* **Screen Body Interactions**: 1
  * **Buttons**: 0
  * **Forms**: 1
  * **Filters**: 0
  * **Table Actions**: 0
  * **Clickable Cards**: 0
* **Global Navigation Count**: 2
* **Business Workflow Score**: 4
* **Role Expectation Score**: 0
* **Missing Business Features**: campaign, lead, budget, analytics, social-media
* **Purpose**: Management workspace screen for Email Marketing Automator module access.
* **Primary user goal**: Review system records and coordinate day-to-day administrative functions.
* **Expected user actions**: Filter records, view items list, click item detail card, click edit/update buttons.
* **Business reason**: Supports general administrative oversight and recordkeeping.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### HeadOfMarketingDashboardScreen

* **Route**: `packages/primecare_ui/lib/src/screens/management/head_of_marketing_dashboard_screen.dart`
* **Component file**: `packages/primecare_ui/lib/src/features/generated_screens/head_of_marketing_dashboard.dart`
* **Current stage**: Stage 5
* **Progress %**: 50%
* **Visual status**: `INTERACTIVE`
* **Business ready**: `Yes`
* **Meaningful Interaction Status**: `MEANINGFUL`
* **Screen Body Interactions**: 3
  * **Buttons**: 1
  * **Forms**: 1
  * **Filters**: 0
  * **Table Actions**: 1
  * **Clickable Cards**: 0
* **Global Navigation Count**: 0
* **Business Workflow Score**: 3
* **Role Expectation Score**: 3
* **Missing Business Features**: analytics, social-media
* **Purpose**: Management workspace screen for HeadOfMarketingDashboardScreen module access.
* **Primary user goal**: Review system records and coordinate day-to-day administrative functions.
* **Expected user actions**: Filter records, view items list, click item detail card, click edit/update buttons.
* **Business reason**: Supports general administrative oversight and recordkeeping.
* **Missing items**: None
* **Next action**: None

## Screens to Fix First

1. **Marketing Manager Campaigns** (Progress: 0%, Business Score: 7, Role Score: 2)  
   *Reason*: Missing core workflows/features: budget, analytics, social-media
2. **Marketing Manager Dashboard** (Progress: 0%, Business Score: 8, Role Score: 1)  
   *Reason*: Missing core workflows/features: campaign, budget, analytics, social-media
3. **Head Of Marketing Brand Assets** (Progress: 0%, Business Score: 8, Role Score: 1)  
   *Reason*: Missing core workflows/features: campaign, budget, analytics, social-media
4. **Head Of Marketing Content Approval** (Progress: 0%, Business Score: 10, Role Score: 1)  
   *Reason*: Missing core workflows/features: campaign, budget, analytics, social-media
5. **Head Of Marketing Funnel Analytics** (Progress: 0%, Business Score: 8, Role Score: 2)  
   *Reason*: Missing core workflows/features: campaign, budget, social-media
6. **Head Of Marketing Leads** (Progress: 0%, Business Score: 7, Role Score: 1)  
   *Reason*: Missing core workflows/features: campaign, budget, analytics, social-media
7. **Head Of Marketing Regional Campaigns** (Progress: 0%, Business Score: 7, Role Score: 2)  
   *Reason*: Missing core workflows/features: budget, analytics, social-media
8. **HeadOfMarketingWorkflowScreen** (Progress: 40%, Business Score: 2, Role Score: 2)  
   *Reason*: Missing core workflows/features: lead, analytics, social-media
9. **Email Marketing Automator** (Progress: 60%, Business Score: 4, Role Score: 0)  
   *Reason*: Missing core workflows/features: campaign, lead, budget, analytics, social-media

## Recommended Build Order

### 1. Must Fix Now (High Priority)
- Marketing Manager Campaigns (Implement role-specific workflows and transactional features)
- Marketing Manager Dashboard (Implement role-specific workflows and transactional features)
- Head Of Marketing Brand Assets (Implement role-specific workflows and transactional features)
- Head Of Marketing Content Approval (Implement role-specific workflows and transactional features)
- Head Of Marketing Funnel Analytics (Implement role-specific workflows and transactional features)

### 2. Fix Next (Medium Priority)
- None (All screens are functionally complete)

### 3. Polish Later (Low Priority)
- Head Of Marketing Campaigns (Micro-interactions and design alignment polish)
- Head Of Marketing Performance Reports (Micro-interactions and design alignment polish)
- HeadOfMarketingAnalyticsScreen (Micro-interactions and design alignment polish)
- HeadOfMarketingDashboardScreen (Micro-interactions and design alignment polish)
- HeadOfMarketingComplianceScreen (Micro-interactions and design alignment polish)

### 4. Consider Merging / Deleting
- None (Zero duplicate screens identified)
