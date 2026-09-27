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
* **Stage/Status**: `template_created`

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
* **Test Name**: `ComplianceManagerAnalyticsScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `ComplianceManagerAnalyticsScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `compliance`)
2. **visit** (Selector: `None`, Value: `/management/compliance-manager-analytics`)
3. **should_be_visible** (Selector: `compliance_manager_analytics-screen`, Value: `None`)
4. **should_be_visible** (Selector: `compliance_manager_analytics-title`, Value: `None`)
5. **should_be_visible** (Selector: `compliance_manager_analytics-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
