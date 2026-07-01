# SCREEN DATA CONTEXT: hr_hiring_dashboard

Below are the database records from `governance.db` used to configure and build the **Talent Acquisition Manager - HrHiringDashboardScreen** screen.

---

## 1. Screen Record
* **ID**: `67`
* **App ID**: `5`
* **Role ID**: `45`
* **Screen Code**: `hr_hiring_dashboard`
* **Screen Name**: `HrHiringDashboardScreen`
* **Route Path**: `/offices/corporate/roles/hr_hiring/dashboard`
* **Actual File Path**: `packages/primecare_ui/lib/src/features/generated_screens/hr_hiring_dashboard.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `5`
* **App Code**: `cl`
* **App Name**: `Primecare Client`

## 3. Role Record
* **ID**: `45`
* **Role Code**: `hr_hiring`
* **Role Name**: `Talent Acquisition Manager`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Client module to enable Talent Acquisition Manager personnel to oversee, audit, and coordinate operations related to hrhiringdashboardscreen.`
* **User Story**: `As a Talent Acquisition Manager, I want to access the HrHiringDashboardScreen within the Primecare Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `HrHiringDashboardScreen`
* **Acceptance Criteria**:
- The HrHiringDashboardScreen route loads successfully within the Primecare Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Talent Acquisition Manager access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `hr_hiring_dashboard-screen` (Type: layout, Required: 1)
* **page_title** -> `hr_hiring_dashboard-title` (Type: header, Required: 1)
* **primary_content** -> `hr_hiring_dashboard-content` (Type: layout, Required: 1)
* **hr_hiring_dashboard_textfield_input_1** -> `hr_hiring_dashboard_textfield_input_1` (Type: field, Required: 0)
* **hr_hiring_dashboard_textbutton_button_1** -> `hr_hiring_dashboard_textbutton_button_1` (Type: button, Required: 0)
* **hr_hiring_dashboard_textfield_input_2** -> `hr_hiring_dashboard_textfield_input_2` (Type: field, Required: 0)
* **hr_hiring_dashboard_elevatedbutton_button_4** -> `hr_hiring_dashboard_elevatedbutton_button_4` (Type: button, Required: 0)
* **hr_hiring_dashboard_elevatedbutton_button_3** -> `hr_hiring_dashboard_elevatedbutton_button_3` (Type: button, Required: 0)
* **hr_hiring_dashboard_textfield_input_3** -> `hr_hiring_dashboard_textfield_input_3` (Type: field, Required: 0)
* **hr_hiring_dashboard_elevatedbutton_button_1** -> `hr_hiring_dashboard_elevatedbutton_button_1` (Type: button, Required: 0)
* **hr_hiring_dashboard_elevatedbutton_button_2** -> `hr_hiring_dashboard_elevatedbutton_button_2` (Type: button, Required: 0)
* **hr_hiring_dashboard_textbutton_button_2** -> `hr_hiring_dashboard_textbutton_button_2` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `75` (Required: 1)
* Component ID: `609` (Required: 1)
* Component ID: `1143` (Required: 1)
* Component ID: `2174` (Required: 1)
* Component ID: `2175` (Required: 1)
* Component ID: `2176` (Required: 1)
* Component ID: `2177` (Required: 1)
* Component ID: `2178` (Required: 1)
* Component ID: `2179` (Required: 1)
* Component ID: `2180` (Required: 1)
* Component ID: `2181` (Required: 1)
* Component ID: `2182` (Required: 1)
* Component ID: `2183` (Required: 1)

## 7. API / Data Mapping
* API ID: `4328` (Required: 1)
* API ID: `4329` (Required: 1)
* API ID: `4330` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `hr_hiring_dashboard_runtime`
* **Test Name**: `HrHiringDashboardScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `HR Hiring Dashboard`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `hr_hiring`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `HR Hiring Dashboard`)
4. **click_sidebar_link** (Selector: `None`, Value: `HR Hiring Dashboard`)
5. **check_url** (Selector: `None`, Value: `/offices/corporate/roles/hr_hiring/dashboard`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
