# SCREEN DATA CONTEXT: system_verification_analytics

Below are the database records from `governance.db` used to configure and build the **System Verification Officer - SystemVerificationAnalyticsScreen** screen.

---

## 1. Screen Record
* **ID**: `146`
* **App ID**: `1`
* **Role ID**: `18`
* **Screen Code**: `system_verification_analytics`
* **Screen Name**: `SystemVerificationAnalyticsScreen`
* **Route Path**: `/common/system-verification-analytics`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/common/system_verification_analytics_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `18`
* **Role Code**: `system_verification`
* **Role Name**: `System Verification Officer`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable System Verification Officer personnel to oversee, audit, and coordinate operations related to systemverificationanalyticsscreen.`
* **User Story**: `As a System Verification Officer, I want to access the SystemVerificationAnalyticsScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `SystemVerificationAnalyticsScreen`
* **Acceptance Criteria**:
- The SystemVerificationAnalyticsScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only System Verification Officer access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `system_verification_analytics-screen` (Type: layout, Required: 1)
* **page_title** -> `system_verification_analytics-title` (Type: header, Required: 1)
* **primary_content** -> `system_verification_analytics-content` (Type: layout, Required: 1)
* **systemverificationanalytics_content** -> `systemverificationanalytics-content` (Type: layout, Required: 0)
* **systemverificationanalytics_btn_2** -> `systemverificationanalytics-btn-2` (Type: button, Required: 0)
* **systemverificationanalytics_title** -> `systemverificationanalytics-title` (Type: header, Required: 0)
* **systemverificationanalytics_screen** -> `systemverificationanalytics-screen` (Type: layout, Required: 0)
* **systemverificationanalytics_btn_1** -> `systemverificationanalytics-btn-1` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `154` (Required: 1)
* Component ID: `688` (Required: 1)
* Component ID: `1222` (Required: 1)
* Component ID: `2854` (Required: 1)
* Component ID: `2855` (Required: 1)
* Component ID: `2856` (Required: 1)
* Component ID: `2857` (Required: 1)
* Component ID: `2858` (Required: 1)
* Component ID: `2859` (Required: 1)
* Component ID: `2860` (Required: 1)
* Component ID: `2861` (Required: 1)

## 7. API / Data Mapping
* API ID: `4429` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `system_verification_analytics_runtime`
* **Test Name**: `SystemVerificationAnalyticsScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `System Verification Analytics`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `system_verification`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `System Verification Analytics`)
4. **click_sidebar_link** (Selector: `None`, Value: `System Verification Analytics`)
5. **check_url** (Selector: `None`, Value: `/common/system-verification-analytics`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
