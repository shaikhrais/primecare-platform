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
* **Stage/Status**: `wired`

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
* **Test Name**: `HrDirectorHiringPipelineScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `HR Director Hiring Pipeline`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `hr_director`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `HR Director Hiring Pipeline`)
4. **click_sidebar_link** (Selector: `None`, Value: `HR Director Hiring Pipeline`)
5. **check_url** (Selector: `None`, Value: `/executive/hr-director-hiring-pipeline`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
