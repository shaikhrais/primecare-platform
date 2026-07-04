# SCREEN DATA CONTEXT: leadership_reports

Below are the database records from `governance.db` used to configure and build the **Guest - LeadershipReportsScreen** screen.

---

## 1. Screen Record
* **ID**: `830`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `leadership_reports`
* **Screen Name**: `LeadershipReportsScreen`
* **Route Path**: `/generated/offices/corporate/roles/ceo/leadership-reports`
* **Actual File Path**: `apps/primecare_governance/lib/features/executive/screens/leadership_reports_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to leadership reports.`
* **User Story**: `As a Guest, I want to access the Leadership Reports within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Leadership Reports`
* **Acceptance Criteria**:
- The Leadership Reports route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `leadership_reports-screen` (Type: layout, Required: 1)
* **page_title** -> `leadership_reports-title` (Type: header, Required: 1)
* **primary_content** -> `leadership_reports-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `7557` (Required: 1)
* Component ID: `7558` (Required: 1)
* Component ID: `7559` (Required: 1)
* Component ID: `7560` (Required: 1)
* Component ID: `7561` (Required: 1)

## 7. API / Data Mapping
* API ID: `5227` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `leadership_reports_runtime`
* **Test Name**: `Leadership Reports Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Leadership Reports`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/generated/offices/corporate/roles/ceo/leadership-reports`)
3. **should_be_visible** (Selector: `leadership_reports-screen`, Value: `None`)
4. **should_be_visible** (Selector: `leadership_reports-title`, Value: `None`)
5. **should_be_visible** (Selector: `leadership_reports-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
