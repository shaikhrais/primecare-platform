# SCREEN DATA CONTEXT: head_of_marketing_workflow

Below are the database records from `governance.db` used to configure and build the **Head of Marketing - HeadOfMarketingWorkflowScreen** screen.

---

## 1. Screen Record
* **ID**: `206`
* **App ID**: `1`
* **Role ID**: `38`
* **Screen Code**: `head_of_marketing_workflow`
* **Screen Name**: `HeadOfMarketingWorkflowScreen`
* **Route Path**: `/management/head-of-marketing-workflow`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/management/head_of_marketing_workflow_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `38`
* **Role Code**: `marketing`
* **Role Name**: `Head of Marketing`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Head of Marketing personnel to oversee, audit, and coordinate operations related to headofmarketingworkflowscreen.`
* **User Story**: `As a Head of Marketing, I want to access the HeadOfMarketingWorkflowScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `HeadOfMarketingWorkflowScreen`
* **Acceptance Criteria**:
- The HeadOfMarketingWorkflowScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Head of Marketing access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `head_of_marketing_workflow-screen` (Type: layout, Required: 1)
* **page_title** -> `head_of_marketing_workflow-title` (Type: header, Required: 1)
* **primary_content** -> `head_of_marketing_workflow-content` (Type: layout, Required: 1)
* **headofmarketingworkflow_btn_1** -> `headofmarketingworkflow-btn-1` (Type: button, Required: 0)
* **headofmarketingworkflow_content** -> `headofmarketingworkflow-content` (Type: layout, Required: 0)
* **headofmarketingworkflow_title** -> `headofmarketingworkflow-title` (Type: header, Required: 0)
* **headofmarketingworkflow_btn_2** -> `headofmarketingworkflow-btn-2` (Type: button, Required: 0)
* **headofmarketingworkflow_screen** -> `headofmarketingworkflow-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `214` (Required: 1)
* Component ID: `748` (Required: 1)
* Component ID: `1282` (Required: 1)
* Component ID: `3413` (Required: 1)
* Component ID: `3414` (Required: 1)
* Component ID: `3415` (Required: 1)
* Component ID: `3416` (Required: 1)
* Component ID: `3417` (Required: 1)
* Component ID: `3418` (Required: 1)
* Component ID: `3419` (Required: 1)
* Component ID: `3420` (Required: 1)
* Component ID: `3421` (Required: 1)
* Component ID: `3422` (Required: 1)

## 7. API / Data Mapping
* API ID: `4495` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `head_of_marketing_workflow_runtime`
* **Test Name**: `HeadOfMarketingWorkflowScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `HeadOfMarketingWorkflowScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `marketing`)
2. **visit** (Selector: `None`, Value: `/management/head-of-marketing-workflow`)
3. **should_be_visible** (Selector: `head_of_marketing_workflow-screen`, Value: `None`)
4. **should_be_visible** (Selector: `head_of_marketing_workflow-title`, Value: `None`)
5. **should_be_visible** (Selector: `head_of_marketing_workflow-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
