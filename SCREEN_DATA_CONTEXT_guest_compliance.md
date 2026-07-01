# SCREEN DATA CONTEXT: guest_compliance

Below are the database records from `governance.db` used to configure and build the **Guest - GuestComplianceScreen** screen.

---

## 1. Screen Record
* **ID**: `114`
* **App ID**: `1`
* **Role ID**: `13`
* **Screen Code**: `guest_compliance`
* **Screen Name**: `GuestComplianceScreen`
* **Route Path**: `/common/guest-compliance`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/common/guest_compliance_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `13`
* **Role Code**: `guest`
* **Role Name**: `Guest`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Guest personnel to oversee, audit, and coordinate operations related to guestcompliancescreen.`
* **User Story**: `As a Guest, I want to access the GuestComplianceScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `GuestComplianceScreen`
* **Acceptance Criteria**:
- The GuestComplianceScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `guest_compliance-screen` (Type: layout, Required: 1)
* **page_title** -> `guest_compliance-title` (Type: header, Required: 1)
* **primary_content** -> `guest_compliance-content` (Type: layout, Required: 1)
* **guestcompliance_loading** -> `guestcompliance-loading` (Type: loading, Required: 0)
* **guestcompliance_btn_3** -> `guestcompliance-btn-3` (Type: button, Required: 0)
* **guestcompliance_screen** -> `guestcompliance-screen` (Type: layout, Required: 0)
* **guestcompliance_title** -> `guestcompliance-title` (Type: header, Required: 0)
* **guestcompliance_btn_4** -> `guestcompliance-btn-4` (Type: button, Required: 0)
* **guestcompliance_btn_2** -> `guestcompliance-btn-2` (Type: button, Required: 0)
* **guestcompliance_btn_5** -> `guestcompliance-btn-5` (Type: button, Required: 0)
* **guestcompliance_content** -> `guestcompliance-content` (Type: layout, Required: 0)
* **guestcompliance_btn_1** -> `guestcompliance-btn-1` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `122` (Required: 1)
* Component ID: `656` (Required: 1)
* Component ID: `1190` (Required: 1)
* Component ID: `2578` (Required: 1)
* Component ID: `2579` (Required: 1)
* Component ID: `2580` (Required: 1)
* Component ID: `2581` (Required: 1)
* Component ID: `2582` (Required: 1)
* Component ID: `2583` (Required: 1)

## 7. API / Data Mapping
* API ID: `4391` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `guest_compliance_runtime`
* **Test Name**: `GuestComplianceScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Guest Compliance`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Guest Compliance`)
4. **click_sidebar_link** (Selector: `None`, Value: `Guest Compliance`)
5. **check_url** (Selector: `None`, Value: `/common/guest-compliance`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
