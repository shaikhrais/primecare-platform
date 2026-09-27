# Family Member

## Role Summary

* **Role key**: `family`
* **Role category**: `client`
* **Total screens**: 16
* **Business ready screens**: 2
* **Incomplete screens**: 16
* **False progress screens**: 0
* **Zero Screen-Body Interaction screens**: 0
* **Average progress**: 15.0%
* **Average screen-body interactions**: 6.1

## Screen List

| Screen Name | Route Path | Body Interactions | Global Nav | Status | Business Score | Role Score | Missing Business Features | Business Ready |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| FamilyMemberDashboardScreen | `/common/family-member-dashboard` | 2 | 1 | `LOW_INTERACTION` | 5 | 2 | client, care-plan, billing, communication | **No** |
| FamilyMemberAnalyticsScreen | `/common/family-member-analytics` | 2 | 0 | `LOW_INTERACTION` | 2 | 1 | client, update, care-plan, billing, communication | **No** |
| FamilyMemberComplianceScreen | `/common/family-member-compliance` | 2 | 1 | `LOW_INTERACTION` | 4 | 2 | client, care-plan, billing, communication | **No** |
| FamilyMemberWorkflowScreen | `/common/family-member-workflow` | 2 | 0 | `LOW_INTERACTION` | 1 | 1 | client, update, care-plan, billing, communication | **No** |
| FamilyOverviewScreen | `/common/family-overview` | 2 | 1 | `LOW_INTERACTION` | 3 | 1 | member, update, care-plan, billing, communication | **No** |
| Family Billing | `/offices/client/roles/family_member/billing` | 8 | 6 | `MEANINGFUL` | 8 | 1 | member, client, update, care-plan, communication | **No** |
| Family Care Updates | `/offices/client/roles/family_member/care-updates` | 8 | 6 | `MEANINGFUL` | 8 | 2 | member, care-plan, billing, communication | **No** |
| Family Dashboard | `/offices/client/roles/family_member/dashboard` | 8 | 6 | `MEANINGFUL` | 7 | 1 | client, update, care-plan, billing, communication | **No** |
| Family Emergency Contacts | `/offices/client/roles/family_member/emergency-contacts` | 8 | 6 | `MEANINGFUL` | 7 | 0 | member, client, update, care-plan, billing, communication | **No** |
| Family Loved One Schedule | `/offices/client/roles/family_member/loved-one-schedule` | 8 | 6 | `MEANINGFUL` | 7 | 0 | member, client, update, care-plan, billing, communication | **No** |
| Family Profile | `/offices/client/roles/family_member/profile` | 8 | 6 | `MEANINGFUL` | 8 | 3 | member, care-plan, communication | **Yes** |
| Family Member Billing | `/generated/family-member-billing` | 8 | 6 | `MEANINGFUL` | 8 | 2 | client, update, care-plan, communication | **No** |
| Family Member Care Updates | `/generated/family-member-care-updates` | 8 | 6 | `MEANINGFUL` | 8 | 3 | care-plan, billing, communication | **Yes** |
| Family Member Emergency Contacts | `/generated/family-member-emergency-contacts` | 8 | 6 | `MEANINGFUL` | 7 | 1 | client, update, care-plan, billing, communication | **No** |
| Family Member Loved One Schedule | `/generated/family-member-loved-one-schedule` | 8 | 6 | `MEANINGFUL` | 7 | 1 | client, update, care-plan, billing, communication | **No** |
| Family Member Profile | `/generated/family-member-profile` | 8 | 6 | `MEANINGFUL` | 8 | 2 | client, care-plan, billing, communication | **No** |

## Screen Details

### FamilyMemberDashboardScreen

* **Route**: `/common/family-member-dashboard`
* **Component file**: `packages/primecare_ui/lib/src/screens/common/family_member_dashboard_screen.dart`
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
* **Missing Business Features**: client, care-plan, billing, communication
* **Purpose**: Management workspace screen for FamilyMemberDashboardScreen module access.
* **Primary user goal**: Review system records and coordinate day-to-day administrative functions.
* **Expected user actions**: Filter records, view items list, click item detail card, click edit/update buttons.
* **Business reason**: Supports general administrative oversight and recordkeeping.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### FamilyMemberAnalyticsScreen

* **Route**: `/common/family-member-analytics`
* **Component file**: `packages/primecare_ui/lib/src/screens/common/family_member_analytics_screen.dart`
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
* **Missing Business Features**: client, update, care-plan, billing, communication
* **Purpose**: Business intelligence analytics dashboard for FamilyMemberAnalyticsScreen to monitor performance trends.
* **Primary user goal**: Review historical metrics, filter performance reports, and analyze operational trends.
* **Expected user actions**: Select date range filter, export chart data to CSV, switch between metric tab displays.
* **Business reason**: Data-driven performance tracking and resource allocation forecasting.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### FamilyMemberComplianceScreen

* **Route**: `/common/family-member-compliance`
* **Component file**: `packages/primecare_ui/lib/src/screens/common/family_member_compliance_screen.dart`
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
* **Business Workflow Score**: 4
* **Role Expectation Score**: 2
* **Missing Business Features**: client, care-plan, billing, communication
* **Purpose**: Regulatory compliance tracking and audit registry for FamilyMemberComplianceScreen protocols.
* **Primary user goal**: Review policy documents, verify training completion status, and log compliance incidents.
* **Expected user actions**: Check off policy read agreements, upload compliance proofs, search audit registers.
* **Business reason**: Mandatory safety oversight, legal compliance, and liability protection.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### FamilyMemberWorkflowScreen

* **Route**: `/common/family-member-workflow`
* **Component file**: `packages/primecare_ui/lib/src/screens/common/family_member_workflow_screen.dart`
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
* **Business Workflow Score**: 1
* **Role Expectation Score**: 1
* **Missing Business Features**: client, update, care-plan, billing, communication
* **Purpose**: Operational workflow configuration and tracking screen for FamilyMemberWorkflowScreen workflows.
* **Primary user goal**: Configure process tasks, track live workflow execution states, and review failed process blocks.
* **Expected user actions**: Edit task list nodes, restart failed workflow execution, sign off on completed steps.
* **Business reason**: Operational automation and validation of process steps.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### FamilyOverviewScreen

* **Route**: `/common/family-overview`
* **Component file**: `packages/primecare_ui/lib/src/screens/common/family_overview_screen.dart`
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
* **Missing Business Features**: member, update, care-plan, billing, communication
* **Purpose**: Management workspace screen for FamilyOverviewScreen module access.
* **Primary user goal**: Review system records and coordinate day-to-day administrative functions.
* **Expected user actions**: Filter records, view items list, click item detail card, click edit/update buttons.
* **Business reason**: Supports general administrative oversight and recordkeeping.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### Family Billing

* **Route**: `/offices/client/roles/family_member/billing`
* **Component file**: `apps/primecare_client/lib/features/family/screens/family_billing_screen.dart`
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
* **Missing Business Features**: member, client, update, care-plan, communication
* **Purpose**: Management workspace screen for Family Billing module access.
* **Primary user goal**: Review system records and coordinate day-to-day administrative functions.
* **Expected user actions**: Filter records, view items list, click item detail card, click edit/update buttons.
* **Business reason**: Supports general administrative oversight and recordkeeping.
* **Missing items**: Missing core role features: member, client, update, care-plan, communication
* **Next action**: Implement expected workflows for family role.

### Family Care Updates

* **Route**: `/offices/client/roles/family_member/care-updates`
* **Component file**: `apps/primecare_client/lib/features/family/screens/family_care_updates_screen.dart`
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
* **Missing Business Features**: member, care-plan, billing, communication
* **Purpose**: Management workspace screen for Family Care Updates module access.
* **Primary user goal**: Review system records and coordinate day-to-day administrative functions.
* **Expected user actions**: Filter records, view items list, click item detail card, click edit/update buttons.
* **Business reason**: Supports general administrative oversight and recordkeeping.
* **Missing items**: Missing core role features: member, care-plan, billing, communication
* **Next action**: Implement expected workflows for family role.

### Family Dashboard

* **Route**: `/offices/client/roles/family_member/dashboard`
* **Component file**: `apps/primecare_client/lib/features/family/screens/family_dashboard_screen.dart`
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
* **Missing Business Features**: client, update, care-plan, billing, communication
* **Purpose**: Management workspace screen for Family Dashboard module access.
* **Primary user goal**: Review system records and coordinate day-to-day administrative functions.
* **Expected user actions**: Filter records, view items list, click item detail card, click edit/update buttons.
* **Business reason**: Supports general administrative oversight and recordkeeping.
* **Missing items**: Missing core role features: client, update, care-plan, billing, communication
* **Next action**: Implement expected workflows for family role.

### Family Emergency Contacts

* **Route**: `/offices/client/roles/family_member/emergency-contacts`
* **Component file**: `apps/primecare_client/lib/features/family/screens/family_emergency_contacts_screen.dart`
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
* **Role Expectation Score**: 0
* **Missing Business Features**: member, client, update, care-plan, billing, communication
* **Purpose**: Management workspace screen for Family Emergency Contacts module access.
* **Primary user goal**: Review system records and coordinate day-to-day administrative functions.
* **Expected user actions**: Filter records, view items list, click item detail card, click edit/update buttons.
* **Business reason**: Supports general administrative oversight and recordkeeping.
* **Missing items**: Missing core role features: member, client, update, care-plan, billing, communication
* **Next action**: Implement expected workflows for family role.

### Family Loved One Schedule

* **Route**: `/offices/client/roles/family_member/loved-one-schedule`
* **Component file**: `apps/primecare_client/lib/features/family/screens/family_loved_one_schedule_screen.dart`
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
* **Role Expectation Score**: 0
* **Missing Business Features**: member, client, update, care-plan, billing, communication
* **Purpose**: Scheduling administrator workspace to resolve booking conflicts, open shifts, and provider availability.
* **Primary user goal**: Ensure all client shifts are filled, resolve calendar conflicts, and approve booking requests.
* **Expected user actions**: Drag and drop shift blocks, click conflict resolver, approve shift request, notify provider.
* **Business reason**: Core logistics system mapping patient needs to caregiver resources efficiently.
* **Missing items**: Missing core role features: member, client, update, care-plan, billing, communication
* **Next action**: Implement expected workflows for family role.

### Family Profile

* **Route**: `/offices/client/roles/family_member/profile`
* **Component file**: `apps/primecare_client/lib/features/family/screens/family_profile_screen.dart`
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
* **Missing Business Features**: member, care-plan, communication
* **Purpose**: Management workspace screen for Family Profile module access.
* **Primary user goal**: Review system records and coordinate day-to-day administrative functions.
* **Expected user actions**: Filter records, view items list, click item detail card, click edit/update buttons.
* **Business reason**: Supports general administrative oversight and recordkeeping.
* **Missing items**: None
* **Next action**: None

### Family Member Billing

* **Route**: `/generated/family-member-billing`
* **Component file**: `apps/primecare_client/lib/features/generated_screens/family_member_billing_screen.dart`
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
* **Missing Business Features**: client, update, care-plan, communication
* **Purpose**: Management workspace screen for Family Member Billing module access.
* **Primary user goal**: Review system records and coordinate day-to-day administrative functions.
* **Expected user actions**: Filter records, view items list, click item detail card, click edit/update buttons.
* **Business reason**: Supports general administrative oversight and recordkeeping.
* **Missing items**: Missing core role features: client, update, care-plan, communication
* **Next action**: Implement expected workflows for family role.

### Family Member Care Updates

* **Route**: `/generated/family-member-care-updates`
* **Component file**: `apps/primecare_client/lib/features/generated_screens/family_member_care_updates_screen.dart`
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
* **Missing Business Features**: care-plan, billing, communication
* **Purpose**: Management workspace screen for Family Member Care Updates module access.
* **Primary user goal**: Review system records and coordinate day-to-day administrative functions.
* **Expected user actions**: Filter records, view items list, click item detail card, click edit/update buttons.
* **Business reason**: Supports general administrative oversight and recordkeeping.
* **Missing items**: None
* **Next action**: None

### Family Member Emergency Contacts

* **Route**: `/generated/family-member-emergency-contacts`
* **Component file**: `apps/primecare_client/lib/features/generated_screens/family_member_emergency_contacts_screen.dart`
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
* **Missing Business Features**: client, update, care-plan, billing, communication
* **Purpose**: Management workspace screen for Family Member Emergency Contacts module access.
* **Primary user goal**: Review system records and coordinate day-to-day administrative functions.
* **Expected user actions**: Filter records, view items list, click item detail card, click edit/update buttons.
* **Business reason**: Supports general administrative oversight and recordkeeping.
* **Missing items**: Missing core role features: client, update, care-plan, billing, communication
* **Next action**: Implement expected workflows for family role.

### Family Member Loved One Schedule

* **Route**: `/generated/family-member-loved-one-schedule`
* **Component file**: `apps/primecare_client/lib/features/generated_screens/family_member_loved_one_schedule_screen.dart`
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
* **Missing Business Features**: client, update, care-plan, billing, communication
* **Purpose**: Scheduling administrator workspace to resolve booking conflicts, open shifts, and provider availability.
* **Primary user goal**: Ensure all client shifts are filled, resolve calendar conflicts, and approve booking requests.
* **Expected user actions**: Drag and drop shift blocks, click conflict resolver, approve shift request, notify provider.
* **Business reason**: Core logistics system mapping patient needs to caregiver resources efficiently.
* **Missing items**: Missing core role features: client, update, care-plan, billing, communication
* **Next action**: Implement expected workflows for family role.

### Family Member Profile

* **Route**: `/generated/family-member-profile`
* **Component file**: `apps/primecare_client/lib/features/generated_screens/family_member_profile_screen.dart`
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
* **Missing Business Features**: client, care-plan, billing, communication
* **Purpose**: Management workspace screen for Family Member Profile module access.
* **Primary user goal**: Review system records and coordinate day-to-day administrative functions.
* **Expected user actions**: Filter records, view items list, click item detail card, click edit/update buttons.
* **Business reason**: Supports general administrative oversight and recordkeeping.
* **Missing items**: Missing core role features: client, care-plan, billing, communication
* **Next action**: Implement expected workflows for family role.

## Screens to Fix First

1. **Family Billing** (Progress: 0%, Business Score: 8, Role Score: 1)  
   *Reason*: Missing core workflows/features: member, client, update, care-plan, communication
2. **Family Care Updates** (Progress: 0%, Business Score: 8, Role Score: 2)  
   *Reason*: Missing core workflows/features: member, care-plan, billing, communication
3. **Family Dashboard** (Progress: 0%, Business Score: 7, Role Score: 1)  
   *Reason*: Missing core workflows/features: client, update, care-plan, billing, communication
4. **Family Emergency Contacts** (Progress: 0%, Business Score: 7, Role Score: 0)  
   *Reason*: Missing core workflows/features: member, client, update, care-plan, billing, communication
5. **Family Loved One Schedule** (Progress: 0%, Business Score: 7, Role Score: 0)  
   *Reason*: Missing core workflows/features: member, client, update, care-plan, billing, communication
6. **Family Member Billing** (Progress: 0%, Business Score: 8, Role Score: 2)  
   *Reason*: Missing core workflows/features: client, update, care-plan, communication
7. **Family Member Emergency Contacts** (Progress: 0%, Business Score: 7, Role Score: 1)  
   *Reason*: Missing core workflows/features: client, update, care-plan, billing, communication
8. **Family Member Loved One Schedule** (Progress: 0%, Business Score: 7, Role Score: 1)  
   *Reason*: Missing core workflows/features: client, update, care-plan, billing, communication
9. **Family Member Profile** (Progress: 0%, Business Score: 8, Role Score: 2)  
   *Reason*: Missing core workflows/features: client, care-plan, billing, communication
10. **FamilyMemberAnalyticsScreen** (Progress: 40%, Business Score: 2, Role Score: 1)  
   *Reason*: Missing core workflows/features: client, update, care-plan, billing, communication

## Recommended Build Order

### 1. Must Fix Now (High Priority)
- Family Billing (Implement role-specific workflows and transactional features)
- Family Care Updates (Implement role-specific workflows and transactional features)
- Family Dashboard (Implement role-specific workflows and transactional features)
- Family Emergency Contacts (Implement role-specific workflows and transactional features)
- Family Loved One Schedule (Implement role-specific workflows and transactional features)

### 2. Fix Next (Medium Priority)
- None (All screens are functionally complete)

### 3. Polish Later (Low Priority)
- Family Profile (Micro-interactions and design alignment polish)
- Family Member Care Updates (Micro-interactions and design alignment polish)

### 4. Consider Merging / Deleting
- None (Zero duplicate screens identified)
