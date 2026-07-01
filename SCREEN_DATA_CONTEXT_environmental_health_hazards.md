# SCREEN DATA CONTEXT: environmental_health_hazards

Below are the database records from `governance.db` used to configure and build the **Guest - EnvironmentalHealthHazardsScreen** screen.

---

## 1. Screen Record
* **ID**: `999`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `environmental_health_hazards`
* **Screen Name**: `EnvironmentalHealthHazardsScreen`
* **Route Path**: `/generated/environmental-health-hazards`
* **Actual File Path**: `packages/primecare_ui/lib/src/features/public_health/environmental_health_hazards.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to environmental health hazards.`
* **User Story**: `As a Guest, I want to access the Environmental Health Hazards within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Environmental Health Hazards`
* **Acceptance Criteria**:
- The Environmental Health Hazards route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `environmental_health_hazards-screen` (Type: layout, Required: 1)
* **page_title** -> `environmental_health_hazards-title` (Type: header, Required: 1)
* **primary_content** -> `environmental_health_hazards-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `8467` (Required: 1)
* Component ID: `8468` (Required: 1)
* Component ID: `8469` (Required: 1)
* Component ID: `8470` (Required: 1)
* Component ID: `8471` (Required: 1)

## 7. API / Data Mapping
* API ID: `5461` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `environmental_health_hazards_runtime`
* **Test Name**: `Environmental Health Hazards Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Environmental Health Hazards`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Environmental Health Hazards`)
4. **click_sidebar_link** (Selector: `None`, Value: `Environmental Health Hazards`)
5. **check_url** (Selector: `None`, Value: `/generated/environmental-health-hazards`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
