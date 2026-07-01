# SCREEN DATA CONTEXT: no_access

Below are the database records from `governance.db` used to configure and build the **Guest - NoAccessScreen** screen.

---

## 1. Screen Record
* **ID**: `822`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `no_access`
* **Screen Name**: `NoAccessScreen`
* **Route Path**: `/generated/no-access`
* **Actual File Path**: `apps/primecare_governance/lib/core/ui/state_widgets.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `6`
* **App Code**: `ci`
* **App Name**: `Primecare Clinic`

## 3. Role Record
* **ID**: `13`
* **Role Code**: `guest`
* **Role Name**: `Guest`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to no access.`
* **User Story**: `As a Guest, I want to access the No Access within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `No Access`
* **Acceptance Criteria**:
- The No Access route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `no_access-screen` (Type: layout, Required: 1)
* **page_title** -> `no_access-title` (Type: header, Required: 1)
* **primary_content** -> `no_access-content` (Type: layout, Required: 1)
* **state_widgets_elevatedbutton_button_1** -> `state_widgets_elevatedbutton_button_1` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `7512` (Required: 1)
* Component ID: `7513` (Required: 1)
* Component ID: `7514` (Required: 1)
* Component ID: `7515` (Required: 1)

## 7. API / Data Mapping
* API ID: `5215` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `no_access_runtime`
* **Test Name**: `No Access Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `No Access`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `No Access`)
4. **click_sidebar_link** (Selector: `None`, Value: `No Access`)
5. **check_url** (Selector: `None`, Value: `/generated/no-access`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
