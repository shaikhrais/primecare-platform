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
* **Test Name**: `Environmental Health Hazards Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Environmental Health Hazards`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/generated/environmental-health-hazards`)
3. **should_be_visible** (Selector: `environmental_health_hazards-screen`, Value: `None`)
4. **should_be_visible** (Selector: `environmental_health_hazards-title`, Value: `None`)
5. **should_be_visible** (Selector: `environmental_health_hazards-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
