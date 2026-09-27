# SCREEN DATA CONTEXT: quality_assurance_dashboard

Below are the database records from `governance.db` used to configure and build the **System Verification Officer - QualityAssuranceDashboardScreen** screen.

---

## 1. Screen Record
* **ID**: `70`
* **App ID**: `5`
* **Role ID**: `18`
* **Screen Code**: `quality_assurance_dashboard`
* **Screen Name**: `QualityAssuranceDashboardScreen`
* **Route Path**: `/staff/quality-assurance-dashboard`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/staff/quality_assurance_dashboard_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Client module to enable System Verification Officer personnel to oversee, audit, and coordinate operations related to qualityassurancedashboardscreen.`
* **User Story**: `As a System Verification Officer, I want to access the QualityAssuranceDashboardScreen within the Primecare Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `QualityAssuranceDashboardScreen`
* **Acceptance Criteria**:
- The QualityAssuranceDashboardScreen route loads successfully within the Primecare Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only System Verification Officer access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `quality_assurance_dashboard-screen` (Type: layout, Required: 1)
* **page_title** -> `quality_assurance_dashboard-title` (Type: header, Required: 1)
* **primary_content** -> `quality_assurance_dashboard-content` (Type: layout, Required: 1)
* **qualityassurancedashboard_btn_1** -> `qualityassurancedashboard-btn-1` (Type: button, Required: 0)
* **qualityassurancedashboard_loading** -> `qualityassurancedashboard-loading` (Type: loading, Required: 0)
* **qualityassurancedashboard_screen** -> `qualityassurancedashboard-screen` (Type: layout, Required: 0)
* **qualityassurancedashboard_btn_3** -> `qualityassurancedashboard-btn-3` (Type: button, Required: 0)
* **qualityassurancedashboard_btn_2** -> `qualityassurancedashboard-btn-2` (Type: button, Required: 0)
* **qualityassurancedashboard_title** -> `qualityassurancedashboard-title` (Type: header, Required: 0)

## 6. Component Mapping
* Component ID: `78` (Required: 1)
* Component ID: `612` (Required: 1)
* Component ID: `1146` (Required: 1)
* Component ID: `2202` (Required: 1)
* Component ID: `2203` (Required: 1)
* Component ID: `2204` (Required: 1)
* Component ID: `2205` (Required: 1)
* Component ID: `2206` (Required: 1)
* Component ID: `2207` (Required: 1)
* Component ID: `2208` (Required: 1)
* Component ID: `2209` (Required: 1)
* Component ID: `2210` (Required: 1)

## 7. API / Data Mapping
* API ID: `4335` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `quality_assurance_dashboard_runtime`
* **Test Name**: `QualityAssuranceDashboardScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `QualityAssuranceDashboardScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `system_verification`)
2. **visit** (Selector: `None`, Value: `/staff/quality-assurance-dashboard`)
3. **should_be_visible** (Selector: `quality_assurance_dashboard-screen`, Value: `None`)
4. **should_be_visible** (Selector: `quality_assurance_dashboard-title`, Value: `None`)
5. **should_be_visible** (Selector: `quality_assurance_dashboard-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
