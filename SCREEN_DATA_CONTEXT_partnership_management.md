# SCREEN DATA CONTEXT: partnership_management

Below are the database records from `governance.db` used to configure and build the **Head of Business Development - PartnershipManagementScreen** screen.

---

## 1. Screen Record
* **ID**: `496`
* **App ID**: `4`
* **Role ID**: `37`
* **Screen Code**: `partnership_management`
* **Screen Name**: `PartnershipManagementScreen`
* **Route Path**: `/management/partnership-management`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/management/partnership_management_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `4`
* **App Code**: `bd`
* **App Name**: `Primecare Business Development`

## 3. Role Record
* **ID**: `37`
* **Role Code**: `bus_dev`
* **Role Name**: `Head of Business Development`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Business Development module to enable Head of Business Development personnel to oversee, audit, and coordinate operations related to partnershipmanagementscreen.`
* **User Story**: `As a Head of Business Development, I want to access the PartnershipManagementScreen within the Primecare Business Development application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `PartnershipManagementScreen`
* **Acceptance Criteria**:
- The PartnershipManagementScreen route loads successfully within the Primecare Business Development workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Head of Business Development access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `partnership_management-screen` (Type: layout, Required: 1)
* **page_title** -> `partnership_management-title` (Type: header, Required: 1)
* **primary_content** -> `partnership_management-content` (Type: layout, Required: 1)
* **partnershipmanagement_btn_1** -> `partnershipmanagement-btn-1` (Type: button, Required: 0)
* **partnershipmanagement_content** -> `partnershipmanagement-content` (Type: layout, Required: 0)
* **partnershipmanagement_btn_3** -> `partnershipmanagement-btn-3` (Type: button, Required: 0)
* **partnershipmanagement_title** -> `partnershipmanagement-title` (Type: header, Required: 0)
* **partnershipmanagement_btn_2** -> `partnershipmanagement-btn-2` (Type: button, Required: 0)
* **partnershipmanagement_screen** -> `partnershipmanagement-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `425` (Required: 1)
* Component ID: `959` (Required: 1)
* Component ID: `1493` (Required: 1)
* Component ID: `5343` (Required: 1)
* Component ID: `5344` (Required: 1)
* Component ID: `5345` (Required: 1)
* Component ID: `5346` (Required: 1)
* Component ID: `5347` (Required: 1)
* Component ID: `5348` (Required: 1)
* Component ID: `5349` (Required: 1)
* Component ID: `5350` (Required: 1)
* Component ID: `5351` (Required: 1)
* Component ID: `5352` (Required: 1)

## 7. API / Data Mapping
* API ID: `4813` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `partnership_management_runtime`
* **Test Name**: `PartnershipManagementScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Partnership Management`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `bus_dev`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Partnership Management`)
4. **click_sidebar_link** (Selector: `None`, Value: `Partnership Management`)
5. **check_url** (Selector: `None`, Value: `/management/partnership-management`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
