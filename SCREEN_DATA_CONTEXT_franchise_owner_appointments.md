# SCREEN DATA CONTEXT: franchise_owner_appointments

Below are the database records from `governance.db` used to configure and build the **Franchise Owner - FranchiseOwnerAppointmentsScreen** screen.

---

## 1. Screen Record
* **ID**: `324`
* **App ID**: `9`
* **Role ID**: `29`
* **Screen Code**: `franchise_owner_appointments`
* **Screen Name**: `FranchiseOwnerAppointmentsScreen`
* **Route Path**: `/offices/franchise/roles/franchise_owner/appointments`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/executive/franchise_owner_appointments_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `9`
* **App Code**: `fr`
* **App Name**: `Primecare Franchise`

## 3. Role Record
* **ID**: `29`
* **Role Code**: `owner`
* **Role Name**: `Franchise Owner`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Franchise module to enable Franchise Owner personnel to oversee, audit, and coordinate operations related to franchiseownerappointmentsscreen.`
* **User Story**: `As a Franchise Owner, I want to access the FranchiseOwnerAppointmentsScreen within the Primecare Franchise application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `FranchiseOwnerAppointmentsScreen`
* **Acceptance Criteria**:
- The FranchiseOwnerAppointmentsScreen route loads successfully within the Primecare Franchise workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Franchise Owner access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `franchise_owner_appointments-screen` (Type: layout, Required: 1)
* **page_title** -> `franchise_owner_appointments-title` (Type: header, Required: 1)
* **primary_content** -> `franchise_owner_appointments-content` (Type: layout, Required: 1)
* **franchiseownerappointments_screen** -> `franchiseownerappointments-screen` (Type: layout, Required: 0)
* **franchiseownerappointments_title** -> `franchiseownerappointments-title` (Type: header, Required: 0)
* **franchiseownerappointments_btn_1** -> `franchiseownerappointments-btn-1` (Type: button, Required: 0)
* **franchiseownerappointments_btn_2** -> `franchiseownerappointments-btn-2` (Type: button, Required: 0)
* **franchiseownerappointments_content** -> `franchiseownerappointments-content` (Type: layout, Required: 0)
* **franchiseownerappointments_btn_3** -> `franchiseownerappointments-btn-3` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `332` (Required: 1)
* Component ID: `866` (Required: 1)
* Component ID: `1400` (Required: 1)
* Component ID: `4491` (Required: 1)
* Component ID: `4492` (Required: 1)
* Component ID: `4493` (Required: 1)
* Component ID: `4494` (Required: 1)
* Component ID: `4495` (Required: 1)
* Component ID: `4496` (Required: 1)
* Component ID: `4497` (Required: 1)
* Component ID: `4498` (Required: 1)
* Component ID: `4499` (Required: 1)

## 7. API / Data Mapping
* API ID: `4653` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `franchise_owner_appointments_runtime`
* **Test Name**: `FranchiseOwnerAppointmentsScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Franchise Owner Appointments`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `owner`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Franchise Owner Appointments`)
4. **click_sidebar_link** (Selector: `None`, Value: `Franchise Owner Appointments`)
5. **check_url** (Selector: `None`, Value: `/offices/franchise/roles/franchise_owner/appointments`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
