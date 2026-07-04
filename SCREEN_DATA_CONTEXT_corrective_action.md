# SCREEN DATA CONTEXT: corrective_action

Below are the database records from `governance.db` used to configure and build the **Compliance Manager - CorrectiveActionScreen** screen.

---

## 1. Screen Record
* **ID**: `489`
* **App ID**: `5`
* **Role ID**: `33`
* **Screen Code**: `corrective_action`
* **Screen Name**: `CorrectiveActionScreen`
* **Route Path**: `/management/corrective-action`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/management/corrective_action_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `5`
* **App Code**: `cl`
* **App Name**: `Primecare Client`

## 3. Role Record
* **ID**: `33`
* **Role Code**: `compliance`
* **Role Name**: `Compliance Manager`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Client module to enable Compliance Manager personnel to oversee, audit, and coordinate operations related to correctiveactionscreen.`
* **User Story**: `As a Compliance Manager, I want to access the CorrectiveActionScreen within the Primecare Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `CorrectiveActionScreen`
* **Acceptance Criteria**:
- The CorrectiveActionScreen route loads successfully within the Primecare Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Compliance Manager access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `corrective_action-screen` (Type: layout, Required: 1)
* **page_title** -> `corrective_action-title` (Type: header, Required: 1)
* **primary_content** -> `corrective_action-content` (Type: layout, Required: 1)
* **correctiveaction_btn_1** -> `correctiveaction-btn-1` (Type: button, Required: 0)
* **correctiveaction_content** -> `correctiveaction-content` (Type: layout, Required: 0)
* **correctiveaction_title** -> `correctiveaction-title` (Type: header, Required: 0)
* **correctiveaction_btn_2** -> `correctiveaction-btn-2` (Type: button, Required: 0)
* **correctiveaction_screen** -> `correctiveaction-screen` (Type: layout, Required: 0)
* **correctiveaction_btn_3** -> `correctiveaction-btn-3` (Type: button, Required: 0)
* **correctiveaction_loading** -> `correctiveaction-loading` (Type: loading, Required: 0)

## 6. Component Mapping
* Component ID: `418` (Required: 1)
* Component ID: `952` (Required: 1)
* Component ID: `1486` (Required: 1)
* Component ID: `5273` (Required: 1)
* Component ID: `5274` (Required: 1)
* Component ID: `5275` (Required: 1)
* Component ID: `5276` (Required: 1)
* Component ID: `5277` (Required: 1)
* Component ID: `5278` (Required: 1)
* Component ID: `5279` (Required: 1)
* Component ID: `5280` (Required: 1)
* Component ID: `5281` (Required: 1)
* Component ID: `5282` (Required: 1)

## 7. API / Data Mapping
* API ID: `4806` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `corrective_action_runtime`
* **Test Name**: `CorrectiveActionScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `CorrectiveActionScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `compliance`)
2. **visit** (Selector: `None`, Value: `/management/corrective-action`)
3. **should_be_visible** (Selector: `corrective_action-screen`, Value: `None`)
4. **should_be_visible** (Selector: `corrective_action-title`, Value: `None`)
5. **should_be_visible** (Selector: `corrective_action-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
