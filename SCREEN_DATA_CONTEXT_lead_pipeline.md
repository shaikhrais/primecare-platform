# SCREEN DATA CONTEXT: lead_pipeline

Below are the database records from `governance.db` used to configure and build the **Guest - LeadPipelineScreen** screen.

---

## 1. Screen Record
* **ID**: `916`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `lead_pipeline`
* **Screen Name**: `LeadPipelineScreen`
* **Route Path**: `/generated/lead-pipeline`
* **Actual File Path**: `packages/primecare_ui/lib/src/features/admin/lead_pipeline_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to lead pipeline.`
* **User Story**: `As a Guest, I want to access the Lead Pipeline within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Lead Pipeline`
* **Acceptance Criteria**:
- The Lead Pipeline route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `lead_pipeline-screen` (Type: layout, Required: 1)
* **page_title** -> `lead_pipeline-title` (Type: header, Required: 1)
* **primary_content** -> `lead_pipeline-content` (Type: layout, Required: 1)
* **lead_pipeline_screen_iconbutton_button_2** -> `lead_pipeline_screen_iconbutton_button_2` (Type: button, Required: 0)
* **lead_pipeline_screen_iconbutton_button_1** -> `lead_pipeline_screen_iconbutton_button_1` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `8026` (Required: 1)
* Component ID: `8027` (Required: 1)
* Component ID: `8028` (Required: 1)
* Component ID: `8029` (Required: 1)

## 7. API / Data Mapping
* API ID: `5336` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `lead_pipeline_runtime`
* **Test Name**: `Lead Pipeline Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Lead Pipeline`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/generated/lead-pipeline`)
3. **should_be_visible** (Selector: `lead_pipeline-screen`, Value: `None`)
4. **should_be_visible** (Selector: `lead_pipeline-title`, Value: `None`)
5. **should_be_visible** (Selector: `lead_pipeline-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
