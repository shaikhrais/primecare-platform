# SCREEN DATA CONTEXT: partnership_manager_analytics

Below are the database records from `governance.db` used to configure and build the **Partnership Manager - PartnershipManagerAnalyticsScreen** screen.

---

## 1. Screen Record
* **ID**: `213`
* **App ID**: `1`
* **Role ID**: `41`
* **Screen Code**: `partnership_manager_analytics`
* **Screen Name**: `PartnershipManagerAnalyticsScreen`
* **Route Path**: `/management/partnership-manager-analytics`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/management/partnership_manager_analytics_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `41`
* **Role Code**: `partnership`
* **Role Name**: `Partnership Manager`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Partnership Manager personnel to oversee, audit, and coordinate operations related to partnershipmanageranalyticsscreen.`
* **User Story**: `As a Partnership Manager, I want to access the PartnershipManagerAnalyticsScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `PartnershipManagerAnalyticsScreen`
* **Acceptance Criteria**:
- The PartnershipManagerAnalyticsScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Partnership Manager access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `partnership_manager_analytics-screen` (Type: layout, Required: 1)
* **page_title** -> `partnership_manager_analytics-title` (Type: header, Required: 1)
* **primary_content** -> `partnership_manager_analytics-content` (Type: layout, Required: 1)
* **partnershipmanageranalytics_content** -> `partnershipmanageranalytics-content` (Type: layout, Required: 0)
* **partnershipmanageranalytics_btn_1** -> `partnershipmanageranalytics-btn-1` (Type: button, Required: 0)
* **partnershipmanageranalytics_title** -> `partnershipmanageranalytics-title` (Type: header, Required: 0)
* **partnershipmanageranalytics_screen** -> `partnershipmanageranalytics-screen` (Type: layout, Required: 0)
* **partnershipmanageranalytics_btn_2** -> `partnershipmanageranalytics-btn-2` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `221` (Required: 1)
* Component ID: `755` (Required: 1)
* Component ID: `1289` (Required: 1)
* Component ID: `3481` (Required: 1)
* Component ID: `3482` (Required: 1)
* Component ID: `3483` (Required: 1)
* Component ID: `3484` (Required: 1)
* Component ID: `3485` (Required: 1)
* Component ID: `3486` (Required: 1)
* Component ID: `3487` (Required: 1)
* Component ID: `3488` (Required: 1)

## 7. API / Data Mapping
* API ID: `4502` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `partnership_manager_analytics_runtime`
* **Test Name**: `PartnershipManagerAnalyticsScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `PartnershipManagerAnalyticsScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `partnership`)
2. **visit** (Selector: `None`, Value: `/management/partnership-manager-analytics`)
3. **should_be_visible** (Selector: `partnership_manager_analytics-screen`, Value: `None`)
4. **should_be_visible** (Selector: `partnership_manager_analytics-title`, Value: `None`)
5. **should_be_visible** (Selector: `partnership_manager_analytics-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
