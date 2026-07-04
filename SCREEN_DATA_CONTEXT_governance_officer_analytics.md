# SCREEN DATA CONTEXT: governance_officer_analytics

Below are the database records from `governance.db` used to configure and build the **Governance Officer - GovernanceOfficerAnalyticsScreen** screen.

---

## 1. Screen Record
* **ID**: `198`
* **App ID**: `1`
* **Role ID**: `36`
* **Screen Code**: `governance_officer_analytics`
* **Screen Name**: `GovernanceOfficerAnalyticsScreen`
* **Route Path**: `/management/governance-officer-analytics`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/management/governance_officer_analytics_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `36`
* **Role Code**: `governance`
* **Role Name**: `Governance Officer`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Governance Officer personnel to oversee, audit, and coordinate operations related to governanceofficeranalyticsscreen.`
* **User Story**: `As a Governance Officer, I want to access the GovernanceOfficerAnalyticsScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `GovernanceOfficerAnalyticsScreen`
* **Acceptance Criteria**:
- The GovernanceOfficerAnalyticsScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Governance Officer access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `governance_officer_analytics-screen` (Type: layout, Required: 1)
* **page_title** -> `governance_officer_analytics-title` (Type: header, Required: 1)
* **primary_content** -> `governance_officer_analytics-content` (Type: layout, Required: 1)
* **governanceofficeranalytics_screen** -> `governanceofficeranalytics-screen` (Type: layout, Required: 0)
* **governanceofficeranalytics_btn_1** -> `governanceofficeranalytics-btn-1` (Type: button, Required: 0)
* **governanceofficeranalytics_title** -> `governanceofficeranalytics-title` (Type: header, Required: 0)
* **governanceofficeranalytics_btn_2** -> `governanceofficeranalytics-btn-2` (Type: button, Required: 0)
* **governanceofficeranalytics_content** -> `governanceofficeranalytics-content` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `206` (Required: 1)
* Component ID: `740` (Required: 1)
* Component ID: `1274` (Required: 1)
* Component ID: `3333` (Required: 1)
* Component ID: `3334` (Required: 1)
* Component ID: `3335` (Required: 1)
* Component ID: `3336` (Required: 1)
* Component ID: `3337` (Required: 1)
* Component ID: `3338` (Required: 1)
* Component ID: `3339` (Required: 1)
* Component ID: `3340` (Required: 1)
* Component ID: `3341` (Required: 1)
* Component ID: `3342` (Required: 1)

## 7. API / Data Mapping
* API ID: `4487` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `governance_officer_analytics_runtime`
* **Test Name**: `GovernanceOfficerAnalyticsScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `GovernanceOfficerAnalyticsScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `governance`)
2. **visit** (Selector: `None`, Value: `/management/governance-officer-analytics`)
3. **should_be_visible** (Selector: `governance_officer_analytics-screen`, Value: `None`)
4. **should_be_visible** (Selector: `governance_officer_analytics-title`, Value: `None`)
5. **should_be_visible** (Selector: `governance_officer_analytics-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
