# SCREEN DATA CONTEXT: quality_assurance_reports

Below are the database records from `governance.db` used to configure and build the **Guest - QualityAssuranceReportsScreen** screen.

---

## 1. Screen Record
* **ID**: `884`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `quality_assurance_reports`
* **Screen Name**: `QualityAssuranceReportsScreen`
* **Route Path**: `/generated/quality-assurance-reports`
* **Actual File Path**: `apps/primecare_support/lib/features/generated_screens/quality_assurance_reports_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to quality assurance reports.`
* **User Story**: `As a Guest, I want to access the Quality Assurance Reports within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Quality Assurance Reports`
* **Acceptance Criteria**:
- The Quality Assurance Reports route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `quality_assurance_reports-screen` (Type: layout, Required: 1)
* **page_title** -> `quality_assurance_reports-title` (Type: header, Required: 1)
* **primary_content** -> `quality_assurance_reports-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `7866` (Required: 1)
* Component ID: `7867` (Required: 1)
* Component ID: `7868` (Required: 1)
* Component ID: `7869` (Required: 1)

## 7. API / Data Mapping
* API ID: `5298` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `quality_assurance_reports_runtime`
* **Test Name**: `Quality Assurance Reports Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Quality Assurance Reports`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/generated/quality-assurance-reports`)
3. **should_be_visible** (Selector: `quality_assurance_reports-screen`, Value: `None`)
4. **should_be_visible** (Selector: `quality_assurance_reports-title`, Value: `None`)
5. **should_be_visible** (Selector: `quality_assurance_reports-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
