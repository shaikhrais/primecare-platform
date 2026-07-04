# SCREEN DATA CONTEXT: training_reports

Below are the database records from `governance.db` used to configure and build the **Guest - TrainingReportsScreen** screen.

---

## 1. Screen Record
* **ID**: `783`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `training_reports`
* **Screen Name**: `TrainingReportsScreen`
* **Route Path**: `/generated/training-reports`
* **Actual File Path**: `apps/primecare_corporate/lib/features/training/screens/training_reports_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to training reports.`
* **User Story**: `As a Guest, I want to access the Training Reports within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Training Reports`
* **Acceptance Criteria**:
- The Training Reports route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `training_reports-screen` (Type: layout, Required: 1)
* **page_title** -> `training_reports-title` (Type: header, Required: 1)
* **primary_content** -> `training_reports-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `7288` (Required: 1)
* Component ID: `7289` (Required: 1)
* Component ID: `7290` (Required: 1)
* Component ID: `7291` (Required: 1)

## 7. API / Data Mapping
* API ID: `5171` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `training_reports_runtime`
* **Test Name**: `Training Reports Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Training Reports`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/generated/training-reports`)
3. **should_be_visible** (Selector: `training_reports-screen`, Value: `None`)
4. **should_be_visible** (Selector: `training_reports-title`, Value: `None`)
5. **should_be_visible** (Selector: `training_reports-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
