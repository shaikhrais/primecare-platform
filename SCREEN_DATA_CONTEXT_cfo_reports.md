# SCREEN DATA CONTEXT: cfo_reports

Below are the database records from `governance.db` used to configure and build the **Guest - CfoReportsScreen** screen.

---

## 1. Screen Record
* **ID**: `719`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `cfo_reports`
* **Screen Name**: `CfoReportsScreen`
* **Route Path**: `/offices/corporate/roles/cfo/reports`
* **Actual File Path**: `apps/primecare_corporate/lib/features/generated_screens/cfo_reports_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to cfo reports.`
* **User Story**: `As a Guest, I want to access the Cfo Reports within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Cfo Reports`
* **Acceptance Criteria**:
- The Cfo Reports route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `cfo_reports-screen` (Type: layout, Required: 1)
* **page_title** -> `cfo_reports-title` (Type: header, Required: 1)
* **primary_content** -> `cfo_reports-content` (Type: layout, Required: 1)
* **cforeportsscreen_screen** -> `cforeportsscreen-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `6946` (Required: 1)
* Component ID: `6947` (Required: 1)
* Component ID: `6948` (Required: 1)
* Component ID: `6949` (Required: 1)
* Component ID: `6950` (Required: 1)

## 7. API / Data Mapping
* API ID: `5097` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `cfo_reports_runtime`
* **Test Name**: `Cfo Reports Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Cfo Reports`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/offices/corporate/roles/cfo/reports`)
3. **should_be_visible** (Selector: `cfo_reports-screen`, Value: `None`)
4. **should_be_visible** (Selector: `cfo_reports-title`, Value: `None`)
5. **should_be_visible** (Selector: `cfo_reports-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
