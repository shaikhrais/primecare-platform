# SCREEN DATA CONTEXT: system_verification_dashboard

Below are the database records from `governance.db` used to configure and build the **System Verification Officer - SystemVerificationDashboardScreen** screen.

---

## 1. Screen Record
* **ID**: `31`
* **App ID**: `5`
* **Role ID**: `18`
* **Screen Code**: `system_verification_dashboard`
* **Screen Name**: `SystemVerificationDashboardScreen`
* **Route Path**: `/common/system-verification-dashboard`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/common/system_verification_dashboard_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Client module to enable System Verification Officer personnel to oversee, audit, and coordinate operations related to systemverificationdashboardscreen.`
* **User Story**: `As a System Verification Officer, I want to access the SystemVerificationDashboardScreen within the Primecare Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `SystemVerificationDashboardScreen`
* **Acceptance Criteria**:
- The SystemVerificationDashboardScreen route loads successfully within the Primecare Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only System Verification Officer access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `system_verification_dashboard-screen` (Type: layout, Required: 1)
* **page_title** -> `system_verification_dashboard-title` (Type: header, Required: 1)
* **primary_content** -> `system_verification_dashboard-content` (Type: layout, Required: 1)
* **systemverificationdashboard_screen** -> `systemverificationdashboard-screen` (Type: layout, Required: 0)
* **systemverificationdashboard_content** -> `systemverificationdashboard-content` (Type: layout, Required: 0)
* **systemverificationdashboard_btn_3** -> `systemverificationdashboard-btn-3` (Type: button, Required: 0)
* **systemverificationdashboard_btn_1** -> `systemverificationdashboard-btn-1` (Type: button, Required: 0)
* **systemverificationdashboard_btn_2** -> `systemverificationdashboard-btn-2` (Type: button, Required: 0)
* **systemverificationdashboard_title** -> `systemverificationdashboard-title` (Type: header, Required: 0)

## 6. Component Mapping
* Component ID: `39` (Required: 1)
* Component ID: `573` (Required: 1)
* Component ID: `1107` (Required: 1)
* Component ID: `1850` (Required: 1)
* Component ID: `1851` (Required: 1)
* Component ID: `1852` (Required: 1)
* Component ID: `1853` (Required: 1)
* Component ID: `1854` (Required: 1)
* Component ID: `1855` (Required: 1)
* Component ID: `1856` (Required: 1)
* Component ID: `1857` (Required: 1)

## 7. API / Data Mapping
* API ID: `4284` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `system_verification_dashboard_runtime`
* **Test Name**: `SystemVerificationDashboardScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `SystemVerificationDashboardScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `system_verification`)
2. **visit** (Selector: `None`, Value: `/common/system-verification-dashboard`)
3. **should_be_visible** (Selector: `system_verification_dashboard-screen`, Value: `None`)
4. **should_be_visible** (Selector: `system_verification_dashboard-title`, Value: `None`)
5. **should_be_visible** (Selector: `system_verification_dashboard-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
