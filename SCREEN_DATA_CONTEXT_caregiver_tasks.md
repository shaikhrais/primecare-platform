# SCREEN DATA CONTEXT: caregiver_tasks

Below are the database records from `governance.db` used to configure and build the **Caregiver - CaregiverTasksScreen** screen.

---

## 1. Screen Record
* **ID**: `278`
* **App ID**: `5`
* **Role ID**: `12`
* **Screen Code**: `caregiver_tasks`
* **Screen Name**: `CaregiverTasksScreen`
* **Route Path**: `/offices/clinical/roles/caregiver/tasks`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/psw/caregiver_tasks_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `5`
* **App Code**: `cl`
* **App Name**: `Primecare Client`

## 3. Role Record
* **ID**: `12`
* **Role Code**: `caregiver`
* **Role Name**: `Caregiver`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Client module to enable Caregiver personnel to oversee, audit, and coordinate operations related to caregivertasksscreen.`
* **User Story**: `As a Caregiver, I want to access the CaregiverTasksScreen within the Primecare Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `CaregiverTasksScreen`
* **Acceptance Criteria**:
- The CaregiverTasksScreen route loads successfully within the Primecare Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Caregiver access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `caregiver_tasks-screen` (Type: layout, Required: 1)
* **page_title** -> `caregiver_tasks-title` (Type: header, Required: 1)
* **primary_content** -> `caregiver_tasks-content` (Type: layout, Required: 1)
* **caregivertasks_btn_3** -> `caregivertasks-btn-3` (Type: button, Required: 0)
* **caregivertasks_screen** -> `caregivertasks-screen` (Type: layout, Required: 0)
* **caregivertasks_btn_2** -> `caregivertasks-btn-2` (Type: button, Required: 0)
* **caregivertasks_title** -> `caregivertasks-title` (Type: header, Required: 0)
* **caregivertasks_loading** -> `caregivertasks-loading` (Type: loading, Required: 0)
* **caregivertasks_btn_1** -> `caregivertasks-btn-1` (Type: button, Required: 0)
* **caregivertasks_content** -> `caregivertasks-content` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `286` (Required: 1)
* Component ID: `820` (Required: 1)
* Component ID: `1354` (Required: 1)
* Component ID: `4067` (Required: 1)
* Component ID: `4068` (Required: 1)
* Component ID: `4069` (Required: 1)

## 7. API / Data Mapping
* API ID: `4599` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `caregiver_tasks_runtime`
* **Test Name**: `CaregiverTasksScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `CaregiverTasksScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `caregiver`)
2. **visit** (Selector: `None`, Value: `/offices/clinical/roles/caregiver/tasks`)
3. **should_be_visible** (Selector: `caregiver_tasks-screen`, Value: `None`)
4. **should_be_visible** (Selector: `caregiver_tasks-title`, Value: `None`)
5. **should_be_visible** (Selector: `caregiver_tasks-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
