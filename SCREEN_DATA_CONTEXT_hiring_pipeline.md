# SCREEN DATA CONTEXT: hiring_pipeline

Below are the database records from `governance.db` used to configure and build the **HR Director - HiringPipelineScreen** screen.

---

## 1. Screen Record
* **ID**: `490`
* **App ID**: `5`
* **Role ID**: `27`
* **Screen Code**: `hiring_pipeline`
* **Screen Name**: `HiringPipelineScreen`
* **Route Path**: `/management/hiring-pipeline`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/management/hiring_pipeline_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `5`
* **App Code**: `cl`
* **App Name**: `Primecare Client`

## 3. Role Record
* **ID**: `27`
* **Role Code**: `hr_director`
* **Role Name**: `HR Director`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Client module to enable HR Director personnel to oversee, audit, and coordinate operations related to hiringpipelinescreen.`
* **User Story**: `As a HR Director, I want to access the HiringPipelineScreen within the Primecare Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `HiringPipelineScreen`
* **Acceptance Criteria**:
- The HiringPipelineScreen route loads successfully within the Primecare Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only HR Director access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `hiring_pipeline-screen` (Type: layout, Required: 1)
* **page_title** -> `hiring_pipeline-title` (Type: header, Required: 1)
* **primary_content** -> `hiring_pipeline-content` (Type: layout, Required: 1)
* **hiringpipeline_screen** -> `hiringpipeline-screen` (Type: layout, Required: 0)
* **hiringpipeline_title** -> `hiringpipeline-title` (Type: header, Required: 0)
* **hiringpipeline_btn_1** -> `hiringpipeline-btn-1` (Type: button, Required: 0)
* **hiringpipeline_btn_2** -> `hiringpipeline-btn-2` (Type: button, Required: 0)
* **hiringpipeline_btn_3** -> `hiringpipeline-btn-3` (Type: button, Required: 0)
* **hiringpipeline_content** -> `hiringpipeline-content` (Type: layout, Required: 0)
* **hiringpipeline_loading** -> `hiringpipeline-loading` (Type: loading, Required: 0)

## 6. Component Mapping
* Component ID: `419` (Required: 1)
* Component ID: `953` (Required: 1)
* Component ID: `1487` (Required: 1)
* Component ID: `5283` (Required: 1)
* Component ID: `5284` (Required: 1)
* Component ID: `5285` (Required: 1)
* Component ID: `5286` (Required: 1)
* Component ID: `5287` (Required: 1)
* Component ID: `5288` (Required: 1)
* Component ID: `5289` (Required: 1)
* Component ID: `5290` (Required: 1)
* Component ID: `5291` (Required: 1)
* Component ID: `5292` (Required: 1)

## 7. API / Data Mapping
* API ID: `4807` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `hiring_pipeline_runtime`
* **Test Name**: `HiringPipelineScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `HiringPipelineScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `hr_director`)
2. **visit** (Selector: `None`, Value: `/management/hiring-pipeline`)
3. **should_be_visible** (Selector: `hiring_pipeline-screen`, Value: `None`)
4. **should_be_visible** (Selector: `hiring_pipeline-title`, Value: `None`)
5. **should_be_visible** (Selector: `hiring_pipeline-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
