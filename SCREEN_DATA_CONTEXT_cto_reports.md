# SCREEN DATA CONTEXT: cto_reports

Below are the database records from `governance.db` used to configure and build the **Guest - CtoReportsScreen** screen.

---

## 1. Screen Record
* **ID**: `755`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `cto_reports`
* **Screen Name**: `CtoReportsScreen`
* **Route Path**: `/offices/corporate/roles/cto/reports`
* **Actual File Path**: `apps/primecare_corporate/lib/features/generated_screens/cto_reports_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to cto reports.`
* **User Story**: `As a Guest, I want to access the Cto Reports within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Cto Reports`
* **Acceptance Criteria**:
- The Cto Reports route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `cto_reports-screen` (Type: layout, Required: 1)
* **page_title** -> `cto_reports-title` (Type: header, Required: 1)
* **primary_content** -> `cto_reports-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `7147` (Required: 1)
* Component ID: `7148` (Required: 1)
* Component ID: `7149` (Required: 1)
* Component ID: `7150` (Required: 1)
* Component ID: `7151` (Required: 1)

## 7. API / Data Mapping
* API ID: `5145` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `cto_reports_runtime`
* **Test Name**: `Cto Reports Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Cto Reports`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/offices/corporate/roles/cto/reports`)
3. **should_be_visible** (Selector: `cto_reports-screen`, Value: `None`)
4. **should_be_visible** (Selector: `cto_reports-title`, Value: `None`)
5. **should_be_visible** (Selector: `cto_reports-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
