# SCREEN DATA CONTEXT: open_shift

Below are the database records from `governance.db` used to configure and build the **Shift Supervisor - OpenShiftScreen** screen.

---

## 1. Screen Record
* **ID**: `515`
* **App ID**: `5`
* **Role ID**: `60`
* **Screen Code**: `open_shift`
* **Screen Name**: `OpenShiftScreen`
* **Route Path**: `/staff/open-shift`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/staff/open_shift_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `5`
* **App Code**: `cl`
* **App Name**: `Primecare Client`

## 3. Role Record
* **ID**: `60`
* **Role Code**: `scheduler`
* **Role Name**: `Shift Supervisor`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Client module to enable Shift Supervisor personnel to oversee, audit, and coordinate operations related to openshiftscreen.`
* **User Story**: `As a Shift Supervisor, I want to access the OpenShiftScreen within the Primecare Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `OpenShiftScreen`
* **Acceptance Criteria**:
- The OpenShiftScreen route loads successfully within the Primecare Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Shift Supervisor access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `open_shift-screen` (Type: layout, Required: 1)
* **page_title** -> `open_shift-title` (Type: header, Required: 1)
* **primary_content** -> `open_shift-content` (Type: layout, Required: 1)
* **openshift_btn_5** -> `openshift-btn-5` (Type: button, Required: 0)
* **openshift_loading** -> `openshift-loading` (Type: loading, Required: 0)
* **openshift_btn_4** -> `openshift-btn-4` (Type: button, Required: 0)
* **openshift_content** -> `openshift-content` (Type: layout, Required: 0)
* **openshift_btn_2** -> `openshift-btn-2` (Type: button, Required: 0)
* **openshift_title** -> `openshift-title` (Type: header, Required: 0)
* **openshift_screen** -> `openshift-screen` (Type: layout, Required: 0)
* **openshift_btn_3** -> `openshift-btn-3` (Type: button, Required: 0)
* **openshift_btn_1** -> `openshift-btn-1` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `444` (Required: 1)
* Component ID: `978` (Required: 1)
* Component ID: `1512` (Required: 1)
* Component ID: `5526` (Required: 1)
* Component ID: `5527` (Required: 1)
* Component ID: `5528` (Required: 1)
* Component ID: `5529` (Required: 1)
* Component ID: `5530` (Required: 1)
* Component ID: `5531` (Required: 1)
* Component ID: `5532` (Required: 1)
* Component ID: `5533` (Required: 1)
* Component ID: `5534` (Required: 1)
* Component ID: `5535` (Required: 1)

## 7. API / Data Mapping
* API ID: `4831` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `open_shift_runtime`
* **Test Name**: `OpenShiftScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `OpenShiftScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `scheduler`)
2. **visit** (Selector: `None`, Value: `/staff/open-shift`)
3. **should_be_visible** (Selector: `open_shift-screen`, Value: `None`)
4. **should_be_visible** (Selector: `open_shift-title`, Value: `None`)
5. **should_be_visible** (Selector: `open_shift-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
