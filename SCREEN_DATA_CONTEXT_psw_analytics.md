# SCREEN DATA CONTEXT: psw_analytics

Below are the database records from `governance.db` used to configure and build the **Personal Support Worker (PSW) - PswAnalyticsScreen** screen.

---

## 1. Screen Record
* **ID**: `231`
* **App ID**: `1`
* **Role ID**: `51`
* **Screen Code**: `psw_analytics`
* **Screen Name**: `PswAnalyticsScreen`
* **Route Path**: `/offices/clinical/roles/psw/reports`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/psw/psw_analytics_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `51`
* **Role Code**: `psw`
* **Role Name**: `Personal Support Worker (PSW)`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Personal Support Worker (PSW) personnel to oversee, audit, and coordinate operations related to pswanalyticsscreen.`
* **User Story**: `As a Personal Support Worker (PSW), I want to access the PswAnalyticsScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `PswAnalyticsScreen`
* **Acceptance Criteria**:
- The PswAnalyticsScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Personal Support Worker (PSW) access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `psw_analytics-screen` (Type: layout, Required: 1)
* **page_title** -> `psw_analytics-title` (Type: header, Required: 1)
* **primary_content** -> `psw_analytics-content` (Type: layout, Required: 1)
* **pswanalytics_btn_3** -> `pswanalytics-btn-3` (Type: button, Required: 0)
* **pswanalytics_content** -> `pswanalytics-content` (Type: layout, Required: 0)
* **pswanalytics_btn_2** -> `pswanalytics-btn-2` (Type: button, Required: 0)
* **pswanalytics_btn_1** -> `pswanalytics-btn-1` (Type: button, Required: 0)
* **pswanalytics_btn_4** -> `pswanalytics-btn-4` (Type: button, Required: 0)
* **psw_analytics_screen_textfield_input_2** -> `psw_analytics_screen_textfield_input_2` (Type: field, Required: 0)
* **psw_analytics_screen_textfield_input_1** -> `psw_analytics_screen_textfield_input_1` (Type: field, Required: 0)
* **pswanalytics_screen** -> `pswanalytics-screen` (Type: layout, Required: 0)
* **pswanalytics_title** -> `pswanalytics-title` (Type: header, Required: 0)

## 6. Component Mapping
* Component ID: `239` (Required: 1)
* Component ID: `773` (Required: 1)
* Component ID: `1307` (Required: 1)
* Component ID: `3646` (Required: 1)
* Component ID: `3647` (Required: 1)
* Component ID: `3648` (Required: 1)
* Component ID: `3649` (Required: 1)
* Component ID: `3650` (Required: 1)
* Component ID: `3651` (Required: 1)

## 7. API / Data Mapping
* API ID: `4520` (Required: 1)
* API ID: `4521` (Required: 1)
* API ID: `4522` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `psw_analytics_runtime`
* **Test Name**: `Psw Analytics Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Psw Analytics`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `psw`)
2. **visit** (Selector: `None`, Value: `/offices/clinical/roles/psw/reports`)
3. **should_be_visible** (Selector: `psw_analytics-screen`, Value: `None`)
4. **should_be_visible** (Selector: `psw_analytics-title`, Value: `None`)
5. **should_be_visible** (Selector: `psw_analytics-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
