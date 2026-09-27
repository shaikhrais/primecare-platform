# SCREEN DATA CONTEXT: hr_director_hiring_pipeline

Below are the database records from `governance.db` used to configure and build the **HR Director - HrDirectorHiringPipelineScreen** screen.

---

## 1. Screen Record
* **ID**: `310`
* **App ID**: `7`
* **Role ID**: `27`
* **Screen Code**: `hr_director_hiring_pipeline`
* **Screen Name**: `HrDirectorHiringPipelineScreen`
* **Route Path**: `/executive/hr-director-hiring-pipeline`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/executive/hr_director_hiring_pipeline_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `7`
* **App Code**: `co`
* **App Name**: `Primecare Corporate`

## 3. Role Record
* **ID**: `27`
* **Role Code**: `hr_director`
* **Role Name**: `HR Director`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Corporate module to enable HR Director personnel to oversee, audit, and coordinate operations related to hrdirectorhiringpipelinescreen.`
* **User Story**: `As a HR Director, I want to access the HrDirectorHiringPipelineScreen within the Primecare Corporate application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `HrDirectorHiringPipelineScreen`
* **Acceptance Criteria**:
- The HrDirectorHiringPipelineScreen route loads successfully within the Primecare Corporate workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only HR Director access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `hr_director_hiring_pipeline-screen` (Type: layout, Required: 1)
* **page_title** -> `hr_director_hiring_pipeline-title` (Type: header, Required: 1)
* **primary_content** -> `hr_director_hiring_pipeline-content` (Type: layout, Required: 1)
* **hrdirectorhiringpipeline_btn_2** -> `hrdirectorhiringpipeline-btn-2` (Type: button, Required: 0)
* **hrdirectorhiringpipeline_btn_1** -> `hrdirectorhiringpipeline-btn-1` (Type: button, Required: 0)
* **hrdirectorhiringpipeline_content** -> `hrdirectorhiringpipeline-content` (Type: layout, Required: 0)
* **hrdirectorhiringpipeline_title** -> `hrdirectorhiringpipeline-title` (Type: header, Required: 0)
* **hrdirectorhiringpipeline_btn_3** -> `hrdirectorhiringpipeline-btn-3` (Type: button, Required: 0)
* **hrdirectorhiringpipeline_screen** -> `hrdirectorhiringpipeline-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `318` (Required: 1)
* Component ID: `852` (Required: 1)
* Component ID: `1386` (Required: 1)
* Component ID: `4365` (Required: 1)
* Component ID: `4366` (Required: 1)
* Component ID: `4367` (Required: 1)
* Component ID: `4368` (Required: 1)
* Component ID: `4369` (Required: 1)
* Component ID: `4370` (Required: 1)
* Component ID: `4371` (Required: 1)
* Component ID: `4372` (Required: 1)
* Component ID: `4373` (Required: 1)
* Component ID: `4374` (Required: 1)

## 7. API / Data Mapping
* API ID: `4639` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `hr_director_hiring_pipeline_runtime`
* **Test Name**: `HrDirectorHiringPipelineScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `HrDirectorHiringPipelineScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `hr_director`)
2. **visit** (Selector: `None`, Value: `/executive/hr-director-hiring-pipeline`)
3. **should_be_visible** (Selector: `hr_director_hiring_pipeline-screen`, Value: `None`)
4. **should_be_visible** (Selector: `hr_director_hiring_pipeline-title`, Value: `None`)
5. **should_be_visible** (Selector: `hr_director_hiring_pipeline-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
