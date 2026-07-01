# SCREEN DATA CONTEXT: regional_performance

Below are the database records from `governance.db` used to configure and build the **Guest - RegionalPerformanceScreen** screen.

---

## 1. Screen Record
* **ID**: `832`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `regional_performance`
* **Screen Name**: `RegionalPerformanceScreen`
* **Route Path**: `/generated/offices/corporate/roles/ceo/region-performance`
* **Actual File Path**: `apps/primecare_governance/lib/features/executive/screens/regional_performance_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to regional performance.`
* **User Story**: `As a Guest, I want to access the Regional Performance within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Regional Performance`
* **Acceptance Criteria**:
- The Regional Performance route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `regional_performance-screen` (Type: layout, Required: 1)
* **page_title** -> `regional_performance-title` (Type: header, Required: 1)
* **primary_content** -> `regional_performance-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `7569` (Required: 1)
* Component ID: `7570` (Required: 1)
* Component ID: `7571` (Required: 1)
* Component ID: `7572` (Required: 1)
* Component ID: `7573` (Required: 1)

## 7. API / Data Mapping
* API ID: `5229` (Required: 1)
* API ID: `5230` (Required: 1)
* API ID: `5231` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `regional_performance_runtime`
* **Test Name**: `Regional Performance Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Regional Performance`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Regional Performance`)
4. **click_sidebar_link** (Selector: `None`, Value: `Regional Performance`)
5. **check_url** (Selector: `None`, Value: `/generated/offices/corporate/roles/ceo/region-performance`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
