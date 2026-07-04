# SCREEN DATA CONTEXT: vulnerable_population_registry

Below are the database records from `governance.db` used to configure and build the **Guest - VulnerablePopulationRegistryScreen** screen.

---

## 1. Screen Record
* **ID**: `1007`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `vulnerable_population_registry`
* **Screen Name**: `VulnerablePopulationRegistryScreen`
* **Route Path**: `/generated/vulnerable-population-registry`
* **Actual File Path**: `packages/primecare_ui/lib/src/features/public_health/vulnerable_population_registry.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to vulnerable population registry.`
* **User Story**: `As a Guest, I want to access the Vulnerable Population Registry within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Vulnerable Population Registry`
* **Acceptance Criteria**:
- The Vulnerable Population Registry route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `vulnerable_population_registry-screen` (Type: layout, Required: 1)
* **page_title** -> `vulnerable_population_registry-title` (Type: header, Required: 1)
* **primary_content** -> `vulnerable_population_registry-content` (Type: layout, Required: 1)
* **registry_search** -> `registry-search` (Type: custom, Required: 0)
* **registry_btn_report** -> `registry-btn-report` (Type: button, Required: 0)
* **registry_btn_add** -> `registry-btn-add` (Type: button, Required: 0)
* **registry_age_field** -> `registry-age-field` (Type: field, Required: 0)
* **registry_risk_field** -> `registry-risk-field` (Type: field, Required: 0)
* **registry_name_field** -> `registry-name-field` (Type: field, Required: 0)

## 6. Component Mapping
* Component ID: `8520` (Required: 1)
* Component ID: `8521` (Required: 1)
* Component ID: `8522` (Required: 1)
* Component ID: `8523` (Required: 1)
* Component ID: `8524` (Required: 1)
* Component ID: `8525` (Required: 1)
* Component ID: `8526` (Required: 1)
* Component ID: `8527` (Required: 1)

## 7. API / Data Mapping
* API ID: `5469` (Required: 1)
* API ID: `5470` (Required: 1)
* API ID: `5471` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `vulnerable_population_registry_runtime`
* **Test Name**: `Vulnerable Population Registry Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Vulnerable Population Registry`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/generated/vulnerable-population-registry`)
3. **should_be_visible** (Selector: `vulnerable_population_registry-screen`, Value: `None`)
4. **should_be_visible** (Selector: `vulnerable_population_registry-title`, Value: `None`)
5. **should_be_visible** (Selector: `vulnerable_population_registry-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
