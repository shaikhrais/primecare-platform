# SCREEN DATA CONTEXT: hr_director_staff_files

Below are the database records from `governance.db` used to configure and build the **HR Director - HrDirectorStaffFilesScreen** screen.

---

## 1. Screen Record
* **ID**: `311`
* **App ID**: `7`
* **Role ID**: `27`
* **Screen Code**: `hr_director_staff_files`
* **Screen Name**: `HrDirectorStaffFilesScreen`
* **Route Path**: `/executive/hr-director-staff-files`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/executive/hr_director_staff_files_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `7`
* **App Code**: `co`
* **App Name**: `Primecare Corporate`

## 3. Role Record
* **ID**: `27`
* **Role Code**: `hr_director`
* **Role Name**: `HR Director`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Corporate module to enable HR Director personnel to oversee, audit, and coordinate operations related to hrdirectorstafffilesscreen.`
* **User Story**: `As a HR Director, I want to access the HrDirectorStaffFilesScreen within the Primecare Corporate application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `HrDirectorStaffFilesScreen`
* **Acceptance Criteria**:
- The HrDirectorStaffFilesScreen route loads successfully within the Primecare Corporate workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only HR Director access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `hr_director_staff_files-screen` (Type: layout, Required: 1)
* **page_title** -> `hr_director_staff_files-title` (Type: header, Required: 1)
* **primary_content** -> `hr_director_staff_files-content` (Type: layout, Required: 1)
* **hrdirectorstafffiles_btn_2** -> `hrdirectorstafffiles-btn-2` (Type: button, Required: 0)
* **hrdirectorstafffiles_screen** -> `hrdirectorstafffiles-screen` (Type: layout, Required: 0)
* **hrdirectorstafffiles_title** -> `hrdirectorstafffiles-title` (Type: header, Required: 0)
* **hrdirectorstafffiles_btn_3** -> `hrdirectorstafffiles-btn-3` (Type: button, Required: 0)
* **hrdirectorstafffiles_content** -> `hrdirectorstafffiles-content` (Type: layout, Required: 0)
* **hrdirectorstafffiles_btn_1** -> `hrdirectorstafffiles-btn-1` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `319` (Required: 1)
* Component ID: `853` (Required: 1)
* Component ID: `1387` (Required: 1)
* Component ID: `4375` (Required: 1)
* Component ID: `4376` (Required: 1)
* Component ID: `4377` (Required: 1)
* Component ID: `4378` (Required: 1)
* Component ID: `4379` (Required: 1)
* Component ID: `4380` (Required: 1)
* Component ID: `4381` (Required: 1)
* Component ID: `4382` (Required: 1)
* Component ID: `4383` (Required: 1)
* Component ID: `4384` (Required: 1)
* Component ID: `4385` (Required: 1)

## 7. API / Data Mapping
* API ID: `4640` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `hr_director_staff_files_runtime`
* **Test Name**: `HrDirectorStaffFilesScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `HR Director Staff Files`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `hr_director`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `HR Director Staff Files`)
4. **click_sidebar_link** (Selector: `None`, Value: `HR Director Staff Files`)
5. **check_url** (Selector: `None`, Value: `/executive/hr-director-staff-files`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
