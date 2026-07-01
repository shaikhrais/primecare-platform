# SCREEN DATA CONTEXT: compliance_manager_analytics

Below are the database records from `governance.db` used to configure and build the **Compliance Manager - ComplianceManagerAnalyticsScreen** screen.

---

## 1. Screen Record
* **ID**: `189`
* **App ID**: `1`
* **Role ID**: `33`
* **Screen Code**: `compliance_manager_analytics`
* **Screen Name**: `ComplianceManagerAnalyticsScreen`
* **Route Path**: `/management/compliance-manager-analytics`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/management/compliance_manager_analytics_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `33`
* **Role Code**: `compliance`
* **Role Name**: `Compliance Manager`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Compliance Manager personnel to oversee, audit, and coordinate operations related to compliancemanageranalyticsscreen.`
* **User Story**: `As a Compliance Manager, I want to access the ComplianceManagerAnalyticsScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `ComplianceManagerAnalyticsScreen`
* **Acceptance Criteria**:
- The ComplianceManagerAnalyticsScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Compliance Manager access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `compliance_manager_analytics-screen` (Type: layout, Required: 1)
* **page_title** -> `compliance_manager_analytics-title` (Type: header, Required: 1)
* **primary_content** -> `compliance_manager_analytics-content` (Type: layout, Required: 1)
* **compliancemanageranalytics_btn_2** -> `compliancemanageranalytics-btn-2` (Type: button, Required: 0)
* **compliancemanageranalytics_btn_1** -> `compliancemanageranalytics-btn-1` (Type: button, Required: 0)
* **compliancemanageranalytics_title** -> `compliancemanageranalytics-title` (Type: header, Required: 0)
* **compliancemanageranalytics_content** -> `compliancemanageranalytics-content` (Type: layout, Required: 0)
* **compliancemanageranalytics_screen** -> `compliancemanageranalytics-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `197` (Required: 1)
* Component ID: `731` (Required: 1)
* Component ID: `1265` (Required: 1)
* Component ID: `3246` (Required: 1)
* Component ID: `3247` (Required: 1)
* Component ID: `3248` (Required: 1)
* Component ID: `3249` (Required: 1)
* Component ID: `3250` (Required: 1)
* Component ID: `3251` (Required: 1)
* Component ID: `3252` (Required: 1)
* Component ID: `3253` (Required: 1)
* Component ID: `3254` (Required: 1)
* Component ID: `3255` (Required: 1)

## 7. API / Data Mapping
* API ID: `4478` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `compliance_manager_analytics_runtime`
* **Test Name**: `ComplianceManagerAnalyticsScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Compliance Manager Analytics`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `compliance`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Compliance Manager Analytics`)
4. **click_sidebar_link** (Selector: `None`, Value: `Compliance Manager Analytics`)
5. **check_url** (Selector: `None`, Value: `/management/compliance-manager-analytics`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
