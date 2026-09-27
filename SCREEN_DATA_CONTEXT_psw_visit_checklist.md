# SCREEN DATA CONTEXT: psw_visit_checklist

Below are the database records from `governance.db` used to configure and build the **Guest - PswVisitChecklistScreen** screen.

---

## 1. Screen Record
* **ID**: `693`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `psw_visit_checklist`
* **Screen Name**: `PswVisitChecklistScreen`
* **Route Path**: `/generated/psw-visit-checklist`
* **Actual File Path**: `apps/primecare_clinic/lib/features/generated_screens/psw_visit_checklist_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to psw visit checklist.`
* **User Story**: `As a Guest, I want to access the Psw Visit Checklist within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Psw Visit Checklist`
* **Acceptance Criteria**:
- The Psw Visit Checklist route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `psw_visit_checklist-screen` (Type: layout, Required: 1)
* **page_title** -> `psw_visit_checklist-title` (Type: header, Required: 1)
* **primary_content** -> `psw_visit_checklist-content` (Type: layout, Required: 1)
* **pswvisitchecklistscreen_screen** -> `pswvisitchecklistscreen-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `6806` (Required: 1)
* Component ID: `6807` (Required: 1)
* Component ID: `6808` (Required: 1)
* Component ID: `6809` (Required: 1)
* Component ID: `6810` (Required: 1)

## 7. API / Data Mapping
* API ID: `5061` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `psw_visit_checklist_runtime`
* **Test Name**: `Psw Visit Checklist Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Psw Visit Checklist`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/generated/psw-visit-checklist`)
3. **should_be_visible** (Selector: `psw_visit_checklist-screen`, Value: `None`)
4. **should_be_visible** (Selector: `psw_visit_checklist-title`, Value: `None`)
5. **should_be_visible** (Selector: `psw_visit_checklist-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
