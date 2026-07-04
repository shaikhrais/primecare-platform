# SCREEN DATA CONTEXT: partnership_manager_reports

Below are the database records from `governance.db` used to configure and build the **Guest - PartnershipManagerReportsScreen** screen.

---

## 1. Screen Record
* **ID**: `643`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `partnership_manager_reports`
* **Screen Name**: `PartnershipManagerReportsScreen`
* **Route Path**: `/offices/business_development/roles/partnership_manager/reports`
* **Actual File Path**: `apps/primecare_business_development/lib/features/partnership/screens/partnership_manager_reports_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to partnership manager reports.`
* **User Story**: `As a Guest, I want to access the Partnership Manager Reports within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Partnership Manager Reports`
* **Acceptance Criteria**:
- The Partnership Manager Reports route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `partnership_manager_reports-screen` (Type: layout, Required: 1)
* **page_title** -> `partnership_manager_reports-title` (Type: header, Required: 1)
* **primary_content** -> `partnership_manager_reports-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `6542` (Required: 1)
* Component ID: `6543` (Required: 1)
* Component ID: `6544` (Required: 1)
* Component ID: `6545` (Required: 1)
* Component ID: `6546` (Required: 1)

## 7. API / Data Mapping
* API ID: `5002` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `partnership_manager_reports_runtime`
* **Test Name**: `Partnership Manager Reports Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Partnership Manager Reports`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/offices/business_development/roles/partnership_manager/reports`)
3. **should_be_visible** (Selector: `partnership_manager_reports-screen`, Value: `None`)
4. **should_be_visible** (Selector: `partnership_manager_reports-title`, Value: `None`)
5. **should_be_visible** (Selector: `partnership_manager_reports-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
