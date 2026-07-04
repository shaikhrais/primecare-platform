# SCREEN DATA CONTEXT: file_verification_dashboard

Below are the database records from `governance.db` used to configure and build the **Governance Officer - FileVerificationDashboardScreen** screen.

---

## 1. Screen Record
* **ID**: `587`
* **App ID**: `10`
* **Role ID**: `36`
* **Screen Code**: `file_verification_dashboard`
* **Screen Name**: `FileVerificationDashboardScreen`
* **Route Path**: `/common/file-verification-dashboard`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/common/file_verification_dashboard_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `10`
* **App Code**: `go`
* **App Name**: `Primecare Governance`

## 3. Role Record
* **ID**: `36`
* **Role Code**: `governance`
* **Role Name**: `Governance Officer`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Governance module to enable Governance Officer personnel to oversee, audit, and coordinate operations related to fileverificationdashboardscreen.`
* **User Story**: `As a Governance Officer, I want to access the FileVerificationDashboardScreen within the Primecare Governance application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `FileVerificationDashboardScreen`
* **Acceptance Criteria**:
- The FileVerificationDashboardScreen route loads successfully within the Primecare Governance workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Governance Officer access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `file_verification_dashboard-screen` (Type: layout, Required: 1)
* **page_title** -> `file_verification_dashboard-title` (Type: header, Required: 1)
* **primary_content** -> `file_verification_dashboard-content` (Type: layout, Required: 1)
* **fileverificationdashboard_content** -> `fileverificationdashboard-content` (Type: layout, Required: 0)
* **fileverificationdashboard_btn_3** -> `fileverificationdashboard-btn-3` (Type: button, Required: 0)
* **fileverificationdashboard_screen** -> `fileverificationdashboard-screen` (Type: layout, Required: 0)
* **fileverificationdashboard_btn_2** -> `fileverificationdashboard-btn-2` (Type: button, Required: 0)
* **fileverificationdashboard_title** -> `fileverificationdashboard-title` (Type: header, Required: 0)
* **fileverificationdashboard_btn_1** -> `fileverificationdashboard-btn-1` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `511` (Required: 1)
* Component ID: `1045` (Required: 1)
* Component ID: `1579` (Required: 1)
* Component ID: `6123` (Required: 1)
* Component ID: `6124` (Required: 1)
* Component ID: `6125` (Required: 1)
* Component ID: `6126` (Required: 1)
* Component ID: `6127` (Required: 1)
* Component ID: `6128` (Required: 1)
* Component ID: `6129` (Required: 1)
* Component ID: `6130` (Required: 1)
* Component ID: `6131` (Required: 1)
* Component ID: `6132` (Required: 1)

## 7. API / Data Mapping
* API ID: `4936` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `file_verification_dashboard_runtime`
* **Test Name**: `FileVerificationDashboardScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `FileVerificationDashboardScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `governance`)
2. **visit** (Selector: `None`, Value: `/common/file-verification-dashboard`)
3. **should_be_visible** (Selector: `file_verification_dashboard-screen`, Value: `None`)
4. **should_be_visible** (Selector: `file_verification_dashboard-title`, Value: `None`)
5. **should_be_visible** (Selector: `file_verification_dashboard-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
