# SCREEN DATA CONTEXT: cns_analytics

Below are the database records from `governance.db` used to configure and build the **Clinical Nurse Specialist - ClinicalNurseSpecialistAnalyticsScreen** screen.

---

## 1. Screen Record
* **ID**: `601`
* **App ID**: `1`
* **Role ID**: `10`
* **Screen Code**: `cns_analytics`
* **Screen Name**: `ClinicalNurseSpecialistAnalyticsScreen`
* **Route Path**: `/rn/cns-analytics`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/rn/cns_analytics_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `10`
* **Role Code**: `cns`
* **Role Name**: `Clinical Nurse Specialist`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Clinical Nurse Specialist personnel to oversee, audit, and coordinate operations related to clinical nurse specialist analytics.`
* **User Story**: `As a Clinical Nurse Specialist, I want to access the Clinical Nurse Specialist Analytics within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Clinical Nurse Specialist Analytics`
* **Acceptance Criteria**:
- The Clinical Nurse Specialist Analytics route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Clinical Nurse Specialist access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `cns_analytics-screen` (Type: layout, Required: 1)
* **page_title** -> `cns_analytics-title` (Type: header, Required: 1)
* **primary_content** -> `cns_analytics-content` (Type: layout, Required: 1)
* **clinical nurse specialist analytics_title** -> `clinical nurse specialist analytics-title` (Type: header, Required: 0)
* **clinical nurse specialist analytics_screen** -> `clinical nurse specialist analytics-screen` (Type: layout, Required: 0)
* **clinical nurse specialist analytics_btn_1** -> `clinical nurse specialist analytics-btn-1` (Type: button, Required: 0)
* **clinical nurse specialist analytics_btn_2** -> `clinical nurse specialist analytics-btn-2` (Type: button, Required: 0)
* **clinical nurse specialist analytics_content** -> `clinical nurse specialist analytics-content` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `525` (Required: 1)
* Component ID: `1059` (Required: 1)
* Component ID: `1593` (Required: 1)
* Component ID: `6257` (Required: 1)
* Component ID: `6258` (Required: 1)
* Component ID: `6259` (Required: 1)
* Component ID: `6260` (Required: 1)
* Component ID: `6261` (Required: 1)
* Component ID: `6262` (Required: 1)
* Component ID: `6263` (Required: 1)
* Component ID: `6264` (Required: 1)
* Component ID: `6265` (Required: 1)
* Component ID: `6266` (Required: 1)

## 7. API / Data Mapping
* API ID: `4950` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `cns_analytics_runtime`
* **Test Name**: `Clinical Nurse Specialist Analytics Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Clinical Nurse Specialist Analytics`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `cns`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Clinical Nurse Specialist Analytics`)
4. **click_sidebar_link** (Selector: `None`, Value: `Clinical Nurse Specialist Analytics`)
5. **check_url** (Selector: `None`, Value: `/rn/cns-analytics`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
