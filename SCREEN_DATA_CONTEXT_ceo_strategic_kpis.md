# SCREEN DATA CONTEXT: ceo_strategic_kpis

Below are the database records from `governance.db` used to configure and build the **Guest - CeoStrategicKpisScreen** screen.

---

## 1. Screen Record
* **ID**: `714`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `ceo_strategic_kpis`
* **Screen Name**: `CeoStrategicKpisScreen`
* **Route Path**: `/offices/corporate/roles/ceo/strategic-kpis`
* **Actual File Path**: `apps/primecare_corporate/lib/features/generated_screens/ceo_strategic_kpis_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to ceo strategic kpis.`
* **User Story**: `As a Guest, I want to access the Ceo Strategic Kpis within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Ceo Strategic Kpis`
* **Acceptance Criteria**:
- The Ceo Strategic Kpis route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `ceo_strategic_kpis-screen` (Type: layout, Required: 1)
* **page_title** -> `ceo_strategic_kpis-title` (Type: header, Required: 1)
* **primary_content** -> `ceo_strategic_kpis-content` (Type: layout, Required: 1)
* **ceostrategickpisscreen_screen** -> `ceostrategickpisscreen-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `6917` (Required: 1)
* Component ID: `6918` (Required: 1)
* Component ID: `6919` (Required: 1)
* Component ID: `6920` (Required: 1)
* Component ID: `6921` (Required: 1)

## 7. API / Data Mapping
* API ID: `5092` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `ceo_strategic_kpis_runtime`
* **Test Name**: `Ceo Strategic Kpis Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `CEO Strategic Kpis`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `CEO Strategic Kpis`)
4. **click_sidebar_link** (Selector: `None`, Value: `CEO Strategic Kpis`)
5. **check_url** (Selector: `None`, Value: `/offices/corporate/roles/ceo/strategic-kpis`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
