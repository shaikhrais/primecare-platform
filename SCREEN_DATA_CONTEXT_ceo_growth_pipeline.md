# SCREEN DATA CONTEXT: ceo_growth_pipeline

Below are the database records from `governance.db` used to configure and build the **Guest - CeoGrowthPipelineScreen** screen.

---

## 1. Screen Record
* **ID**: `708`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `ceo_growth_pipeline`
* **Screen Name**: `CeoGrowthPipelineScreen`
* **Route Path**: `/offices/corporate/roles/ceo/growth-pipeline`
* **Actual File Path**: `apps/primecare_corporate/lib/features/generated_screens/ceo_growth_pipeline_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to ceo growth pipeline.`
* **User Story**: `As a Guest, I want to access the Ceo Growth Pipeline within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Ceo Growth Pipeline`
* **Acceptance Criteria**:
- The Ceo Growth Pipeline route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `ceo_growth_pipeline-screen` (Type: layout, Required: 1)
* **page_title** -> `ceo_growth_pipeline-title` (Type: header, Required: 1)
* **primary_content** -> `ceo_growth_pipeline-content` (Type: layout, Required: 1)
* **ceogrowthpipelinescreen_screen** -> `ceogrowthpipelinescreen-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `6887` (Required: 1)
* Component ID: `6888` (Required: 1)
* Component ID: `6889` (Required: 1)
* Component ID: `6890` (Required: 1)
* Component ID: `6891` (Required: 1)

## 7. API / Data Mapping
* API ID: `5084` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `ceo_growth_pipeline_runtime`
* **Test Name**: `Ceo Growth Pipeline Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Ceo Growth Pipeline`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/offices/corporate/roles/ceo/growth-pipeline`)
3. **should_be_visible** (Selector: `ceo_growth_pipeline-screen`, Value: `None`)
4. **should_be_visible** (Selector: `ceo_growth_pipeline-title`, Value: `None`)
5. **should_be_visible** (Selector: `ceo_growth_pipeline-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
