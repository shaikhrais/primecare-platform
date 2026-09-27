# SCREEN DATA CONTEXT: hr_staff_files

Below are the database records from `governance.db` used to configure and build the **Guest - HrStaffFilesScreen** screen.

---

## 1. Screen Record
* **ID**: `966`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `hr_staff_files`
* **Screen Name**: `HrStaffFilesScreen`
* **Route Path**: `/generated/hr-staff-files`
* **Actual File Path**: `packages/primecare_ui/lib/src/features/generated_screens/hr_staff_files_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to hr staff files.`
* **User Story**: `As a Guest, I want to access the Hr Staff Files within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Hr Staff Files`
* **Acceptance Criteria**:
- The Hr Staff Files route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `hr_staff_files-screen` (Type: layout, Required: 1)
* **page_title** -> `hr_staff_files-title` (Type: header, Required: 1)
* **primary_content** -> `hr_staff_files-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `8267` (Required: 1)
* Component ID: `8268` (Required: 1)
* Component ID: `8269` (Required: 1)

## 7. API / Data Mapping
* API ID: `5404` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `hr_staff_files_runtime`
* **Test Name**: `Hr Staff Files Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Hr Staff Files`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/generated/hr-staff-files`)
3. **should_be_visible** (Selector: `hr_staff_files-screen`, Value: `None`)
4. **should_be_visible** (Selector: `hr_staff_files-title`, Value: `None`)
5. **should_be_visible** (Selector: `hr_staff_files-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
