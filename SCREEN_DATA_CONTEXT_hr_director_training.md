# SCREEN DATA CONTEXT: hr_director_training

Below are the database records from `governance.db` used to configure and build the **HR Director - HrDirectorTrainingScreen** screen.

---

## 1. Screen Record
* **ID**: `312`
* **App ID**: `7`
* **Role ID**: `27`
* **Screen Code**: `hr_director_training`
* **Screen Name**: `HrDirectorTrainingScreen`
* **Route Path**: `/executive/hr-director-training`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/executive/hr_director_training_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Corporate module to enable HR Director personnel to oversee, audit, and coordinate operations related to hrdirectortrainingscreen.`
* **User Story**: `As a HR Director, I want to access the HrDirectorTrainingScreen within the Primecare Corporate application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `HrDirectorTrainingScreen`
* **Acceptance Criteria**:
- The HrDirectorTrainingScreen route loads successfully within the Primecare Corporate workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only HR Director access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `hr_director_training-screen` (Type: layout, Required: 1)
* **page_title** -> `hr_director_training-title` (Type: header, Required: 1)
* **primary_content** -> `hr_director_training-content` (Type: layout, Required: 1)
* **hrdirectortraining_title** -> `hrdirectortraining-title` (Type: header, Required: 0)
* **hrdirectortraining_btn_1** -> `hrdirectortraining-btn-1` (Type: button, Required: 0)
* **hrdirectortraining_screen** -> `hrdirectortraining-screen` (Type: layout, Required: 0)
* **hrdirectortraining_btn_3** -> `hrdirectortraining-btn-3` (Type: button, Required: 0)
* **hrdirectortraining_content** -> `hrdirectortraining-content` (Type: layout, Required: 0)
* **hrdirectortraining_btn_2** -> `hrdirectortraining-btn-2` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `320` (Required: 1)
* Component ID: `854` (Required: 1)
* Component ID: `1388` (Required: 1)
* Component ID: `4386` (Required: 1)
* Component ID: `4387` (Required: 1)
* Component ID: `4388` (Required: 1)
* Component ID: `4389` (Required: 1)
* Component ID: `4390` (Required: 1)
* Component ID: `4391` (Required: 1)
* Component ID: `4392` (Required: 1)
* Component ID: `4393` (Required: 1)
* Component ID: `4394` (Required: 1)
* Component ID: `4395` (Required: 1)
* Component ID: `4396` (Required: 1)

## 7. API / Data Mapping
* API ID: `4641` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `hr_director_training_runtime`
* **Test Name**: `HrDirectorTrainingScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `HR Director Training`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `hr_director`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `HR Director Training`)
4. **click_sidebar_link** (Selector: `None`, Value: `HR Director Training`)
5. **check_url** (Selector: `None`, Value: `/executive/hr-director-training`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
