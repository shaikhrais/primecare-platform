# SCREEN DATA CONTEXT: family_member_analytics

Below are the database records from `governance.db` used to configure and build the **Family Member - FamilyMemberAnalyticsScreen** screen.

---

## 1. Screen Record
* **ID**: `107`
* **App ID**: `1`
* **Role ID**: `64`
* **Screen Code**: `family_member_analytics`
* **Screen Name**: `FamilyMemberAnalyticsScreen`
* **Route Path**: `/common/family-member-analytics`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/common/family_member_analytics_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `64`
* **Role Code**: `family`
* **Role Name**: `Family Member`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Family Member personnel to oversee, audit, and coordinate operations related to familymemberanalyticsscreen.`
* **User Story**: `As a Family Member, I want to access the FamilyMemberAnalyticsScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `FamilyMemberAnalyticsScreen`
* **Acceptance Criteria**:
- The FamilyMemberAnalyticsScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Family Member access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `family_member_analytics-screen` (Type: layout, Required: 1)
* **page_title** -> `family_member_analytics-title` (Type: header, Required: 1)
* **primary_content** -> `family_member_analytics-content` (Type: layout, Required: 1)
* **familymemberanalytics_screen** -> `familymemberanalytics-screen` (Type: layout, Required: 0)
* **familymemberanalytics_btn_2** -> `familymemberanalytics-btn-2` (Type: button, Required: 0)
* **familymemberanalytics_btn_1** -> `familymemberanalytics-btn-1` (Type: button, Required: 0)
* **familymemberanalytics_title** -> `familymemberanalytics-title` (Type: header, Required: 0)
* **familymemberanalytics_content** -> `familymemberanalytics-content` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `115` (Required: 1)
* Component ID: `649` (Required: 1)
* Component ID: `1183` (Required: 1)
* Component ID: `2531` (Required: 1)
* Component ID: `2532` (Required: 1)
* Component ID: `2533` (Required: 1)
* Component ID: `2534` (Required: 1)
* Component ID: `2535` (Required: 1)

## 7. API / Data Mapping
* API ID: `4384` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `family_member_analytics_runtime`
* **Test Name**: `FamilyMemberAnalyticsScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Family Member Analytics`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `family`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Family Member Analytics`)
4. **click_sidebar_link** (Selector: `None`, Value: `Family Member Analytics`)
5. **check_url** (Selector: `None`, Value: `/common/family-member-analytics`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
