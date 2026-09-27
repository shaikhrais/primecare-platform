# SCREEN DATA CONTEXT: territory_sales_manager_pipeline

Below are the database records from `governance.db` used to configure and build the **Guest - TerritorySalesManagerPipelineScreen** screen.

---

## 1. Screen Record
* **ID**: `867`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `territory_sales_manager_pipeline`
* **Screen Name**: `TerritorySalesManagerPipelineScreen`
* **Route Path**: `/generated/territory-sales-manager-pipeline`
* **Actual File Path**: `apps/primecare_marketing/lib/features/generated_screens/territory_sales_manager_pipeline_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to territory sales manager pipeline.`
* **User Story**: `As a Guest, I want to access the Territory Sales Manager Pipeline within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Territory Sales Manager Pipeline`
* **Acceptance Criteria**:
- The Territory Sales Manager Pipeline route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `territory_sales_manager_pipeline-screen` (Type: layout, Required: 1)
* **page_title** -> `territory_sales_manager_pipeline-title` (Type: header, Required: 1)
* **primary_content** -> `territory_sales_manager_pipeline-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `7767` (Required: 1)
* Component ID: `7768` (Required: 1)
* Component ID: `7769` (Required: 1)
* Component ID: `7770` (Required: 1)
* Component ID: `7771` (Required: 1)
* Component ID: `7772` (Required: 1)
* Component ID: `7773` (Required: 1)

## 7. API / Data Mapping
* API ID: `5269` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `territory_sales_manager_pipeline_runtime`
* **Test Name**: `Territory Sales Manager Pipeline Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Territory Sales Manager Pipeline`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/generated/territory-sales-manager-pipeline`)
3. **should_be_visible** (Selector: `territory_sales_manager_pipeline-screen`, Value: `None`)
4. **should_be_visible** (Selector: `territory_sales_manager_pipeline-title`, Value: `None`)
5. **should_be_visible** (Selector: `territory_sales_manager_pipeline-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
