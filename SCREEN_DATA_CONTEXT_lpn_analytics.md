# SCREEN DATA CONTEXT: lpn_analytics

Below are the database records from `governance.db` used to configure and build the **Licensed Practical Nurse (LPN) - LicensedPracticalNurseLPNAnalyticsScreen** screen.

---

## 1. Screen Record
* **ID**: `615`
* **App ID**: `1`
* **Role ID**: `56`
* **Screen Code**: `lpn_analytics`
* **Screen Name**: `LicensedPracticalNurseLPNAnalyticsScreen`
* **Route Path**: `/rpn/lpn-analytics`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/rpn/lpn_analytics_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `56`
* **Role Code**: `lpn`
* **Role Name**: `Licensed Practical Nurse (LPN)`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Licensed Practical Nurse (LPN) personnel to oversee, audit, and coordinate operations related to licensed practical nurse (lpn) analytics.`
* **User Story**: `As a Licensed Practical Nurse (LPN), I want to access the Licensed Practical Nurse (LPN) Analytics within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Licensed Practical Nurse (LPN) Analytics`
* **Acceptance Criteria**:
- The Licensed Practical Nurse (LPN) Analytics route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Licensed Practical Nurse (LPN) access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `lpn_analytics-screen` (Type: layout, Required: 1)
* **page_title** -> `lpn_analytics-title` (Type: header, Required: 1)
* **primary_content** -> `lpn_analytics-content` (Type: layout, Required: 1)
* **licensed practical nurse (lpn) analytics_btn_1** -> `licensed practical nurse (lpn) analytics-btn-1` (Type: button, Required: 0)
* **licensed practical nurse (lpn) analytics_screen** -> `licensed practical nurse (lpn) analytics-screen` (Type: layout, Required: 0)
* **licensed practical nurse (lpn) analytics_content** -> `licensed practical nurse (lpn) analytics-content` (Type: layout, Required: 0)
* **licensed practical nurse (lpn) analytics_title** -> `licensed practical nurse (lpn) analytics-title` (Type: header, Required: 0)

## 6. Component Mapping
* Component ID: `539` (Required: 1)
* Component ID: `1073` (Required: 1)
* Component ID: `1607` (Required: 1)
* Component ID: `6371` (Required: 1)
* Component ID: `6372` (Required: 1)
* Component ID: `6373` (Required: 1)
* Component ID: `6374` (Required: 1)
* Component ID: `6375` (Required: 1)
* Component ID: `6376` (Required: 1)
* Component ID: `6377` (Required: 1)
* Component ID: `6378` (Required: 1)
* Component ID: `6379` (Required: 1)
* Component ID: `6380` (Required: 1)

## 7. API / Data Mapping
* API ID: `4968` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `lpn_analytics_runtime`
* **Test Name**: `Licensed Practical Nurse (LPN) Analytics Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Licensed Practical Nurse (LPN) Analytics`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `lpn`)
2. **visit** (Selector: `None`, Value: `/rpn/lpn-analytics`)
3. **should_be_visible** (Selector: `lpn_analytics-screen`, Value: `None`)
4. **should_be_visible** (Selector: `lpn_analytics-title`, Value: `None`)
5. **should_be_visible** (Selector: `lpn_analytics-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
