# SCREEN DATA CONTEXT: architecture_planning_compliance

Below are the database records from `governance.db` used to configure and build the **Infrastructure Auditor - ArchitecturePlanningComplianceScreen** screen.

---

## 1. Screen Record
* **ID**: `87`
* **App ID**: `1`
* **Role ID**: `17`
* **Screen Code**: `architecture_planning_compliance`
* **Screen Name**: `ArchitecturePlanningComplianceScreen`
* **Route Path**: `/common/architecture-planning-compliance`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/common/architecture_planning_compliance_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `17`
* **Role Code**: `infrastructure`
* **Role Name**: `Infrastructure Auditor`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Infrastructure Auditor personnel to oversee, audit, and coordinate operations related to architectureplanningcompliancescreen.`
* **User Story**: `As a Infrastructure Auditor, I want to access the ArchitecturePlanningComplianceScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `ArchitecturePlanningComplianceScreen`
* **Acceptance Criteria**:
- The ArchitecturePlanningComplianceScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Infrastructure Auditor access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `architecture_planning_compliance-screen` (Type: layout, Required: 1)
* **page_title** -> `architecture_planning_compliance-title` (Type: header, Required: 1)
* **primary_content** -> `architecture_planning_compliance-content` (Type: layout, Required: 1)
* **architectureplanningcompliance_content** -> `architectureplanningcompliance-content` (Type: layout, Required: 0)
* **architectureplanningcompliance_btn_1** -> `architectureplanningcompliance-btn-1` (Type: button, Required: 0)
* **architectureplanningcompliance_screen** -> `architectureplanningcompliance-screen` (Type: layout, Required: 0)
* **architectureplanningcompliance_btn_2** -> `architectureplanningcompliance-btn-2` (Type: button, Required: 0)
* **architectureplanningcompliance_title** -> `architectureplanningcompliance-title` (Type: header, Required: 0)

## 6. Component Mapping
* Component ID: `95` (Required: 1)
* Component ID: `629` (Required: 1)
* Component ID: `1163` (Required: 1)
* Component ID: `2354` (Required: 1)
* Component ID: `2355` (Required: 1)
* Component ID: `2356` (Required: 1)
* Component ID: `2357` (Required: 1)
* Component ID: `2358` (Required: 1)
* Component ID: `2359` (Required: 1)
* Component ID: `2360` (Required: 1)

## 7. API / Data Mapping
* API ID: `4364` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `architecture_planning_compliance_runtime`
* **Test Name**: `ArchitecturePlanningComplianceScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `ArchitecturePlanningComplianceScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `infrastructure`)
2. **visit** (Selector: `None`, Value: `/common/architecture-planning-compliance`)
3. **should_be_visible** (Selector: `architecture_planning_compliance-screen`, Value: `None`)
4. **should_be_visible** (Selector: `architecture_planning_compliance-title`, Value: `None`)
5. **should_be_visible** (Selector: `architecture_planning_compliance-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
