# SCREEN DATA CONTEXT: ceo_region_performance

Below are the database records from `governance.db` used to configure and build the **Guest - CeoRegionPerformanceScreen** screen.

---

## 1. Screen Record
* **ID**: `711`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `ceo_region_performance`
* **Screen Name**: `CeoRegionPerformanceScreen`
* **Route Path**: `/offices/corporate/roles/ceo/region-performance`
* **Actual File Path**: `apps/primecare_corporate/lib/features/generated_screens/ceo_region_performance_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to ceo region performance.`
* **User Story**: `As a Guest, I want to access the Ceo Region Performance within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Ceo Region Performance`
* **Acceptance Criteria**:
- The Ceo Region Performance route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `ceo_region_performance-screen` (Type: layout, Required: 1)
* **page_title** -> `ceo_region_performance-title` (Type: header, Required: 1)
* **primary_content** -> `ceo_region_performance-content` (Type: layout, Required: 1)
* **ceoregionperformancescreen_screen** -> `ceoregionperformancescreen-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `6902` (Required: 1)
* Component ID: `6903` (Required: 1)
* Component ID: `6904` (Required: 1)
* Component ID: `6905` (Required: 1)
* Component ID: `6906` (Required: 1)
* Component ID: `6907` (Required: 1)

## 7. API / Data Mapping
* API ID: `5087` (Required: 1)
* API ID: `5088` (Required: 1)
* API ID: `5089` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `ceo_region_performance_runtime`
* **Test Name**: `Ceo Region Performance Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `CEO Region Performance`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `CEO Region Performance`)
4. **click_sidebar_link** (Selector: `None`, Value: `CEO Region Performance`)
5. **check_url** (Selector: `None`, Value: `/offices/corporate/roles/ceo/region-performance`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
