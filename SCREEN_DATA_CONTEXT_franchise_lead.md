# SCREEN DATA CONTEXT: franchise_lead

Below are the database records from `governance.db` used to configure and build the **Head of Business Development - FranchiseLeadScreen** screen.

---

## 1. Screen Record
* **ID**: `495`
* **App ID**: `4`
* **Role ID**: `37`
* **Screen Code**: `franchise_lead`
* **Screen Name**: `FranchiseLeadScreen`
* **Route Path**: `/management/franchise-lead`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/management/franchise_lead_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `4`
* **App Code**: `bd`
* **App Name**: `Primecare Business Development`

## 3. Role Record
* **ID**: `37`
* **Role Code**: `bus_dev`
* **Role Name**: `Head of Business Development`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Business Development module to enable Head of Business Development personnel to oversee, audit, and coordinate operations related to franchiseleadscreen.`
* **User Story**: `As a Head of Business Development, I want to access the FranchiseLeadScreen within the Primecare Business Development application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `FranchiseLeadScreen`
* **Acceptance Criteria**:
- The FranchiseLeadScreen route loads successfully within the Primecare Business Development workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Head of Business Development access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `franchise_lead-screen` (Type: layout, Required: 1)
* **page_title** -> `franchise_lead-title` (Type: header, Required: 1)
* **primary_content** -> `franchise_lead-content` (Type: layout, Required: 1)
* **franchiselead_content** -> `franchiselead-content` (Type: layout, Required: 0)
* **franchiselead_btn_2** -> `franchiselead-btn-2` (Type: button, Required: 0)
* **franchiselead_btn_1** -> `franchiselead-btn-1` (Type: button, Required: 0)
* **franchiselead_screen** -> `franchiselead-screen` (Type: layout, Required: 0)
* **franchiselead_title** -> `franchiselead-title` (Type: header, Required: 0)
* **franchiselead_loading** -> `franchiselead-loading` (Type: loading, Required: 0)
* **franchiselead_btn_3** -> `franchiselead-btn-3` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `424` (Required: 1)
* Component ID: `958` (Required: 1)
* Component ID: `1492` (Required: 1)
* Component ID: `5333` (Required: 1)
* Component ID: `5334` (Required: 1)
* Component ID: `5335` (Required: 1)
* Component ID: `5336` (Required: 1)
* Component ID: `5337` (Required: 1)
* Component ID: `5338` (Required: 1)
* Component ID: `5339` (Required: 1)
* Component ID: `5340` (Required: 1)
* Component ID: `5341` (Required: 1)
* Component ID: `5342` (Required: 1)

## 7. API / Data Mapping
* API ID: `4812` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `franchise_lead_runtime`
* **Test Name**: `FranchiseLeadScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `FranchiseLeadScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `bus_dev`)
2. **visit** (Selector: `None`, Value: `/management/franchise-lead`)
3. **should_be_visible** (Selector: `franchise_lead-screen`, Value: `None`)
4. **should_be_visible** (Selector: `franchise_lead-title`, Value: `None`)
5. **should_be_visible** (Selector: `franchise_lead-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
