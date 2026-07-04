# SCREEN DATA CONTEXT: head_of_marketing_performance_reports

Below are the database records from `governance.db` used to configure and build the **Guest - HeadOfMarketingPerformanceReportsScreen** screen.

---

## 1. Screen Record
* **ID**: `853`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `head_of_marketing_performance_reports`
* **Screen Name**: `HeadOfMarketingPerformanceReportsScreen`
* **Route Path**: `/generated/head-of-marketing-performance-reports`
* **Actual File Path**: `apps/primecare_marketing/lib/features/generated_screens/head_of_marketing_performance_reports_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `6`
* **App Code**: `ci`
* **App Name**: `Primecare Clinic`

## 3. Role Record
* **ID**: `13`
* **Role Code**: `guest`
* **Role Name**: `Guest`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to head of marketing performance reports.`
* **User Story**: `As a Guest, I want to access the Head Of Marketing Performance Reports within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Head Of Marketing Performance Reports`
* **Acceptance Criteria**:
- The Head Of Marketing Performance Reports route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `head_of_marketing_performance_reports-screen` (Type: layout, Required: 1)
* **page_title** -> `head_of_marketing_performance_reports-title` (Type: header, Required: 1)
* **primary_content** -> `head_of_marketing_performance_reports-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `7691` (Required: 1)
* Component ID: `7692` (Required: 1)
* Component ID: `7693` (Required: 1)
* Component ID: `7694` (Required: 1)
* Component ID: `7695` (Required: 1)

## 7. API / Data Mapping
* API ID: `5251` (Required: 1)
* API ID: `5252` (Required: 1)
* API ID: `5253` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `head_of_marketing_performance_reports_runtime`
* **Test Name**: `Head Of Marketing Performance Reports Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Head Of Marketing Performance Reports`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/generated/head-of-marketing-performance-reports`)
3. **should_be_visible** (Selector: `head_of_marketing_performance_reports-screen`, Value: `None`)
4. **should_be_visible** (Selector: `head_of_marketing_performance_reports-title`, Value: `None`)
5. **should_be_visible** (Selector: `head_of_marketing_performance_reports-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
