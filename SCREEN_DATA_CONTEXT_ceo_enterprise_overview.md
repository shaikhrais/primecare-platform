# SCREEN DATA CONTEXT: ceo_enterprise_overview

Below are the database records from `governance.db` used to configure and build the **Guest - CeoEnterpriseOverviewScreen** screen.

---

## 1. Screen Record
* **ID**: `706`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `ceo_enterprise_overview`
* **Screen Name**: `CeoEnterpriseOverviewScreen`
* **Route Path**: `/offices/corporate/roles/ceo/enterprise-overview`
* **Actual File Path**: `apps/primecare_corporate/lib/features/generated_screens/ceo_enterprise_overview_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to ceo enterprise overview.`
* **User Story**: `As a Guest, I want to access the Ceo Enterprise Overview within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Ceo Enterprise Overview`
* **Acceptance Criteria**:
- The Ceo Enterprise Overview route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `ceo_enterprise_overview-screen` (Type: layout, Required: 1)
* **page_title** -> `ceo_enterprise_overview-title` (Type: header, Required: 1)
* **primary_content** -> `ceo_enterprise_overview-content` (Type: layout, Required: 1)
* **ceoenterpriseoverviewscreen_screen** -> `ceoenterpriseoverviewscreen-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `6873` (Required: 1)
* Component ID: `6874` (Required: 1)
* Component ID: `6875` (Required: 1)
* Component ID: `6876` (Required: 1)
* Component ID: `6877` (Required: 1)
* Component ID: `6878` (Required: 1)
* Component ID: `6879` (Required: 1)

## 7. API / Data Mapping
* API ID: `5082` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `ceo_enterprise_overview_runtime`
* **Test Name**: `Ceo Enterprise Overview Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `CEO Enterprise Overview`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `CEO Enterprise Overview`)
4. **click_sidebar_link** (Selector: `None`, Value: `CEO Enterprise Overview`)
5. **check_url** (Selector: `None`, Value: `/offices/corporate/roles/ceo/enterprise-overview`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
