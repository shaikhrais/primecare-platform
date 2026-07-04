# SCREEN DATA CONTEXT: territory_expansion_manager_territory_map

Below are the database records from `governance.db` used to configure and build the **Guest - TerritoryExpansionManagerTerritoryMapScreen** screen.

---

## 1. Screen Record
* **ID**: `652`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `territory_expansion_manager_territory_map`
* **Screen Name**: `TerritoryExpansionManagerTerritoryMapScreen`
* **Route Path**: `/offices/business_development/roles/territory_expansion_manager/territory-map`
* **Actual File Path**: `apps/primecare_business_development/lib/features/expansion/screens/territory_expansion_manager_territory_map_screen.dart`
* **Stage/Status**: `template_created`

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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to territory expansion manager territory map.`
* **User Story**: `As a Guest, I want to access the Territory Expansion Manager Territory Map within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Territory Expansion Manager Territory Map`
* **Acceptance Criteria**:
- The Territory Expansion Manager Territory Map route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `territory_expansion_manager_territory_map-screen` (Type: layout, Required: 1)
* **page_title** -> `territory_expansion_manager_territory_map-title` (Type: header, Required: 1)
* **primary_content** -> `territory_expansion_manager_territory_map-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `6589` (Required: 1)
* Component ID: `6590` (Required: 1)
* Component ID: `6591` (Required: 1)
* Component ID: `6592` (Required: 1)
* Component ID: `6593` (Required: 1)

## 7. API / Data Mapping
* API ID: `5011` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `territory_expansion_manager_territory_map_runtime`
* **Test Name**: `Territory Expansion Manager Territory Map Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Territory Expansion Manager Territory Map`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/offices/business_development/roles/territory_expansion_manager/territory-map`)
3. **should_be_visible** (Selector: `territory_expansion_manager_territory_map-screen`, Value: `None`)
4. **should_be_visible** (Selector: `territory_expansion_manager_territory_map-title`, Value: `None`)
5. **should_be_visible** (Selector: `territory_expansion_manager_territory_map-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
