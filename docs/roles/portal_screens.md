# Portal User

## Role Summary

* **Role key**: `portal`
* **Role category**: `client`
* **Total screens**: 7
* **Business ready screens**: 0
* **Incomplete screens**: 7
* **False progress screens**: 0
* **Zero Screen-Body Interaction screens**: 0
* **Average progress**: 57.1%
* **Average screen-body interactions**: 2.7

## Screen List

| Screen Name | Route Path | Body Interactions | Global Nav | Status | Business Score | Role Score | Missing Business Features | Business Ready |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| PortalDashboardScreen | `/common/portal-dashboard` | 4 | 1 | `MEANINGFUL` | 5 | 0 | message, notification, profile, billing, schedule | **No** |
| PortalAnalyticsScreen | `/common/portal-analytics` | 2 | 1 | `LOW_INTERACTION` | 2 | 1 | message, profile, billing, schedule | **No** |
| PortalWorkflowScreen | `/common/portal-workflow` | 2 | 1 | `LOW_INTERACTION` | 2 | 0 | message, notification, profile, billing, schedule | **No** |
| Medical Library Access Portal | `/generated/medical-library-access-portal` | 1 | 2 | `LOW_INTERACTION` | 3 | 1 | notification, profile, billing, schedule | **No** |
| App Notification | `/generated/app-notification` | 3 | 0 | `MEANINGFUL` | 3 | 2 | profile, billing, schedule | **No** |
| Gamification Profile | `/generated/gamification-profile` | 2 | 0 | `LOW_INTERACTION` | 6 | 2 | message, billing, schedule | **No** |
| Adverse Event Reporting Portal | `/generated/adverse-event-reporting-portal` | 5 | 0 | `MEANINGFUL` | 5 | 0 | message, notification, profile, billing, schedule | **No** |

## Screen Details

### PortalDashboardScreen

* **Route**: `/common/portal-dashboard`
* **Component file**: `packages/primecare_ui/lib/src/screens/common/portal_dashboard_screen.dart`
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
* **Role Expectation Score**: 0
* **Missing Business Features**: message, notification, profile, billing, schedule
* **Purpose**: Management workspace screen for PortalDashboardScreen module access.
* **Primary user goal**: Review system records and coordinate day-to-day administrative functions.
* **Expected user actions**: Filter records, view items list, click item detail card, click edit/update buttons.
* **Business reason**: Supports general administrative oversight and recordkeeping.
* **Missing items**: Missing core role features: message, notification, profile, billing, schedule
* **Next action**: Implement expected workflows for portal role.

### PortalAnalyticsScreen

* **Route**: `/common/portal-analytics`
* **Component file**: `packages/primecare_ui/lib/src/screens/common/portal_analytics_screen.dart`
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
* **Business Workflow Score**: 2
* **Role Expectation Score**: 1
* **Missing Business Features**: message, profile, billing, schedule
* **Purpose**: Business intelligence analytics dashboard for PortalAnalyticsScreen to monitor performance trends.
* **Primary user goal**: Review historical metrics, filter performance reports, and analyze operational trends.
* **Expected user actions**: Select date range filter, export chart data to CSV, switch between metric tab displays.
* **Business reason**: Data-driven performance tracking and resource allocation forecasting.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### PortalWorkflowScreen

* **Route**: `/common/portal-workflow`
* **Component file**: `packages/primecare_ui/lib/src/screens/common/portal_workflow_screen.dart`
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
* **Business Workflow Score**: 2
* **Role Expectation Score**: 0
* **Missing Business Features**: message, notification, profile, billing, schedule
* **Purpose**: Operational workflow configuration and tracking screen for PortalWorkflowScreen workflows.
* **Primary user goal**: Configure process tasks, track live workflow execution states, and review failed process blocks.
* **Expected user actions**: Edit task list nodes, restart failed workflow execution, sign off on completed steps.
* **Business reason**: Operational automation and validation of process steps.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### Medical Library Access Portal

* **Route**: `/generated/medical-library-access-portal`
* **Component file**: `packages/primecare_ui/lib/src/features/education/medical_library_access_portal.dart`
* **Current stage**: Stage 6
* **Progress %**: 60%
* **Visual status**: `INTERACTIVE`
* **Business ready**: `No`
* **Meaningful Interaction Status**: `LOW_INTERACTION`
* **Screen Body Interactions**: 1
  * **Buttons**: 0
  * **Forms**: 0
  * **Filters**: 0
  * **Table Actions**: 0
  * **Clickable Cards**: 1
* **Global Navigation Count**: 2
* **Business Workflow Score**: 3
* **Role Expectation Score**: 1
* **Missing Business Features**: notification, profile, billing, schedule
* **Purpose**: Management workspace screen for Medical Library Access Portal module access.
* **Primary user goal**: Review system records and coordinate day-to-day administrative functions.
* **Expected user actions**: Filter records, view items list, click item detail card, click edit/update buttons.
* **Business reason**: Supports general administrative oversight and recordkeeping.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### App Notification

* **Route**: `/generated/app-notification`
* **Component file**: `packages/primecare_ui/lib/src/features/operations/app_notification_screen.dart`
* **Current stage**: Stage 2
* **Progress %**: 20%
* **Visual status**: `INTERACTIVE`
* **Business ready**: `No`
* **Meaningful Interaction Status**: `MEANINGFUL`
* **Screen Body Interactions**: 3
  * **Buttons**: 1
  * **Forms**: 2
  * **Filters**: 0
  * **Table Actions**: 0
  * **Clickable Cards**: 0
* **Global Navigation Count**: 0
* **Business Workflow Score**: 3
* **Role Expectation Score**: 2
* **Missing Business Features**: profile, billing, schedule
* **Purpose**: Management workspace screen for App Notification module access.
* **Primary user goal**: Review system records and coordinate day-to-day administrative functions.
* **Expected user actions**: Filter records, view items list, click item detail card, click edit/update buttons.
* **Business reason**: Supports general administrative oversight and recordkeeping.
* **Missing items**: Missing core role features: profile, billing, schedule
* **Next action**: Implement expected workflows for portal role.

### Gamification Profile

* **Route**: `/generated/gamification-profile`
* **Component file**: `packages/primecare_ui/lib/src/features/operations/gamification_profile_screen.dart`
* **Current stage**: Stage 6
* **Progress %**: 60%
* **Visual status**: `INTERACTIVE`
* **Business ready**: `No`
* **Meaningful Interaction Status**: `LOW_INTERACTION`
* **Screen Body Interactions**: 2
  * **Buttons**: 0
  * **Forms**: 2
  * **Filters**: 0
  * **Table Actions**: 0
  * **Clickable Cards**: 0
* **Global Navigation Count**: 0
* **Business Workflow Score**: 6
* **Role Expectation Score**: 2
* **Missing Business Features**: message, billing, schedule
* **Purpose**: Management workspace screen for Gamification Profile module access.
* **Primary user goal**: Review system records and coordinate day-to-day administrative functions.
* **Expected user actions**: Filter records, view items list, click item detail card, click edit/update buttons.
* **Business reason**: Supports general administrative oversight and recordkeeping.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### Adverse Event Reporting Portal

* **Route**: `/generated/adverse-event-reporting-portal`
* **Component file**: `packages/primecare_ui/lib/src/features/research/adverse_event_reporting_portal.dart`
* **Current stage**: Stage 9
* **Progress %**: 90%
* **Visual status**: `INTERACTIVE`
* **Business ready**: `No`
* **Meaningful Interaction Status**: `MEANINGFUL`
* **Screen Body Interactions**: 5
  * **Buttons**: 1
  * **Forms**: 3
  * **Filters**: 0
  * **Table Actions**: 0
  * **Clickable Cards**: 1
* **Global Navigation Count**: 0
* **Business Workflow Score**: 5
* **Role Expectation Score**: 0
* **Missing Business Features**: message, notification, profile, billing, schedule
* **Purpose**: Management workspace screen for Adverse Event Reporting Portal module access.
* **Primary user goal**: Review system records and coordinate day-to-day administrative functions.
* **Expected user actions**: Filter records, view items list, click item detail card, click edit/update buttons.
* **Business reason**: Supports general administrative oversight and recordkeeping.
* **Missing items**: Missing core role features: message, notification, profile, billing, schedule
* **Next action**: Implement expected workflows for portal role.

## Screens to Fix First

1. **App Notification** (Progress: 20%, Business Score: 3, Role Score: 2)  
   *Reason*: Missing core workflows/features: profile, billing, schedule
2. **PortalDashboardScreen** (Progress: 50%, Business Score: 5, Role Score: 0)  
   *Reason*: Missing core workflows/features: message, notification, profile, billing, schedule
3. **PortalAnalyticsScreen** (Progress: 60%, Business Score: 2, Role Score: 1)  
   *Reason*: Missing core workflows/features: message, profile, billing, schedule
4. **PortalWorkflowScreen** (Progress: 60%, Business Score: 2, Role Score: 0)  
   *Reason*: Missing core workflows/features: message, notification, profile, billing, schedule
5. **Medical Library Access Portal** (Progress: 60%, Business Score: 3, Role Score: 1)  
   *Reason*: Missing core workflows/features: notification, profile, billing, schedule
6. **Gamification Profile** (Progress: 60%, Business Score: 6, Role Score: 2)  
   *Reason*: Missing core workflows/features: message, billing, schedule
7. **Adverse Event Reporting Portal** (Progress: 90%, Business Score: 5, Role Score: 0)  
   *Reason*: Missing core workflows/features: message, notification, profile, billing, schedule

## Recommended Build Order

### 1. Must Fix Now (High Priority)
- App Notification (Implement role-specific workflows and transactional features)
- PortalDashboardScreen (Implement role-specific workflows and transactional features)
- PortalAnalyticsScreen (Implement role-specific workflows and transactional features)
- PortalWorkflowScreen (Implement role-specific workflows and transactional features)
- Medical Library Access Portal (Implement role-specific workflows and transactional features)

### 2. Fix Next (Medium Priority)
- None (All screens are functionally complete)

### 3. Polish Later (Low Priority)
- None (All screens fully completed and polished)

### 4. Consider Merging / Deleting
- None (Zero duplicate screens identified)
