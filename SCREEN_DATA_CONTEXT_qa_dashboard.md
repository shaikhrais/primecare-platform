# SCREEN DATA CONTEXT: qa_dashboard

Below are the database records from `governance.db` used to configure and build the **System Verification Officer - QaDashboardScreen** screen.

---

## 1. Screen Record
* **ID**: `27`
* **App ID**: `5`
* **Role ID**: `18`
* **Screen Code**: `qa_dashboard`
* **Screen Name**: `QaDashboardScreen`
* **Route Path**: `/offices/support/roles/quality_assurance/dashboard`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/common/qa_dashboard_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `5`
* **App Code**: `cl`
* **App Name**: `Primecare Client`

## 3. Role Record
* **ID**: `18`
* **Role Code**: `system_verification`
* **Role Name**: `System Verification Officer`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Client module to enable System Verification Officer personnel to oversee, audit, and coordinate operations related to qadashboardscreen.`
* **User Story**: `As a System Verification Officer, I want to access the QaDashboardScreen within the Primecare Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `QaDashboardScreen`
* **Acceptance Criteria**:
- The QaDashboardScreen route loads successfully within the Primecare Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only System Verification Officer access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `qa_dashboard-screen` (Type: layout, Required: 1)
* **page_title** -> `qa_dashboard-title` (Type: header, Required: 1)
* **primary_content** -> `qa_dashboard-content` (Type: layout, Required: 1)
* **qadashboard_btn_3** -> `qadashboard-btn-3` (Type: button, Required: 0)
* **qadashboard_content** -> `qadashboard-content` (Type: layout, Required: 0)
* **qadashboard_btn_2** -> `qadashboard-btn-2` (Type: button, Required: 0)
* **qadashboard_screen** -> `qadashboard-screen` (Type: layout, Required: 0)
* **qadashboard_loading** -> `qadashboard-loading` (Type: loading, Required: 0)
* **qadashboard_btn_1** -> `qadashboard-btn-1` (Type: button, Required: 0)
* **qadashboard_title** -> `qadashboard-title` (Type: header, Required: 0)

## 6. Component Mapping
* Component ID: `35` (Required: 1)
* Component ID: `569` (Required: 1)
* Component ID: `1103` (Required: 1)
* Component ID: `1816` (Required: 1)
* Component ID: `1817` (Required: 1)
* Component ID: `1818` (Required: 1)
* Component ID: `1819` (Required: 1)
* Component ID: `1820` (Required: 1)
* Component ID: `1821` (Required: 1)
* Component ID: `1822` (Required: 1)
* Component ID: `1823` (Required: 1)
* Component ID: `1824` (Required: 1)
* Component ID: `1825` (Required: 1)

## 7. API / Data Mapping
* API ID: `4280` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `qa_dashboard_runtime`
* **Test Name**: `QaDashboardScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `QaDashboardScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `system_verification`)
2. **visit** (Selector: `None`, Value: `/offices/support/roles/quality_assurance/dashboard`)
3. **should_be_visible** (Selector: `qa_dashboard-screen`, Value: `None`)
4. **should_be_visible** (Selector: `qa_dashboard-title`, Value: `None`)
5. **should_be_visible** (Selector: `qa_dashboard-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
