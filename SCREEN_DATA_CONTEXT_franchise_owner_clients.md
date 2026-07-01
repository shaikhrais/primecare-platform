# SCREEN DATA CONTEXT: franchise_owner_clients

Below are the database records from `governance.db` used to configure and build the **Franchise Owner - FranchiseOwnerClientsScreen** screen.

---

## 1. Screen Record
* **ID**: `323`
* **App ID**: `9`
* **Role ID**: `29`
* **Screen Code**: `franchise_owner_clients`
* **Screen Name**: `FranchiseOwnerClientsScreen`
* **Route Path**: `/offices/franchise/roles/franchise_owner/clients`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/executive/franchise_owner_clients_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Franchise module to enable Franchise Owner personnel to oversee, audit, and coordinate operations related to franchiseownerclientsscreen.`
* **User Story**: `As a Franchise Owner, I want to access the FranchiseOwnerClientsScreen within the Primecare Franchise application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `FranchiseOwnerClientsScreen`
* **Acceptance Criteria**:
- The FranchiseOwnerClientsScreen route loads successfully within the Primecare Franchise workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Franchise Owner access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `franchise_owner_clients-screen` (Type: layout, Required: 1)
* **page_title** -> `franchise_owner_clients-title` (Type: header, Required: 1)
* **primary_content** -> `franchise_owner_clients-content` (Type: layout, Required: 1)
* **franchiseownerclients_title** -> `franchiseownerclients-title` (Type: header, Required: 0)
* **franchiseownerclients_content** -> `franchiseownerclients-content` (Type: layout, Required: 0)
* **franchiseownerclients_btn_1** -> `franchiseownerclients-btn-1` (Type: button, Required: 0)
* **franchiseownerclients_screen** -> `franchiseownerclients-screen` (Type: layout, Required: 0)
* **franchiseownerclients_btn_2** -> `franchiseownerclients-btn-2` (Type: button, Required: 0)
* **franchiseownerclients_btn_3** -> `franchiseownerclients-btn-3` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `331` (Required: 1)
* Component ID: `865` (Required: 1)
* Component ID: `1399` (Required: 1)
* Component ID: `4481` (Required: 1)
* Component ID: `4482` (Required: 1)
* Component ID: `4483` (Required: 1)
* Component ID: `4484` (Required: 1)
* Component ID: `4485` (Required: 1)
* Component ID: `4486` (Required: 1)
* Component ID: `4487` (Required: 1)
* Component ID: `4488` (Required: 1)
* Component ID: `4489` (Required: 1)
* Component ID: `4490` (Required: 1)

## 7. API / Data Mapping
* API ID: `4652` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `franchise_owner_clients_runtime`
* **Test Name**: `FranchiseOwnerClientsScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Franchise Owner Clients`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `owner`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Franchise Owner Clients`)
4. **click_sidebar_link** (Selector: `None`, Value: `Franchise Owner Clients`)
5. **check_url** (Selector: `None`, Value: `/offices/franchise/roles/franchise_owner/clients`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
