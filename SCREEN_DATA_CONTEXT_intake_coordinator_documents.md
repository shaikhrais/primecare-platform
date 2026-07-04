# SCREEN DATA CONTEXT: intake_coordinator_documents

Below are the database records from `governance.db` used to configure and build the **Volunteer Coordinator - IntakeCoordinatorDocumentsScreen** screen.

---

## 1. Screen Record
* **ID**: `386`
* **App ID**: `5`
* **Role ID**: `48`
* **Screen Code**: `intake_coordinator_documents`
* **Screen Name**: `IntakeCoordinatorDocumentsScreen`
* **Route Path**: `/executive/intake-coordinator-documents`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/executive/intake_coordinator_documents_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `5`
* **App Code**: `cl`
* **App Name**: `Primecare Client`

## 3. Role Record
* **ID**: `48`
* **Role Code**: `volunteer_coordinator`
* **Role Name**: `Volunteer Coordinator`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Client module to enable Volunteer Coordinator personnel to oversee, audit, and coordinate operations related to intakecoordinatordocumentsscreen.`
* **User Story**: `As a Volunteer Coordinator, I want to access the IntakeCoordinatorDocumentsScreen within the Primecare Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `IntakeCoordinatorDocumentsScreen`
* **Acceptance Criteria**:
- The IntakeCoordinatorDocumentsScreen route loads successfully within the Primecare Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Volunteer Coordinator access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `intake_coordinator_documents-screen` (Type: layout, Required: 1)
* **page_title** -> `intake_coordinator_documents-title` (Type: header, Required: 1)
* **primary_content** -> `intake_coordinator_documents-content` (Type: layout, Required: 1)
* **intakecoordinatordocuments_btn_1** -> `intakecoordinatordocuments-btn-1` (Type: button, Required: 0)
* **intakecoordinatordocuments_btn_2** -> `intakecoordinatordocuments-btn-2` (Type: button, Required: 0)
* **intakecoordinatordocuments_btn_3** -> `intakecoordinatordocuments-btn-3` (Type: button, Required: 0)
* **intakecoordinatordocuments_title** -> `intakecoordinatordocuments-title` (Type: header, Required: 0)
* **intakecoordinatordocuments_content** -> `intakecoordinatordocuments-content` (Type: layout, Required: 0)
* **intakecoordinatordocuments_screen** -> `intakecoordinatordocuments-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `392` (Required: 1)
* Component ID: `926` (Required: 1)
* Component ID: `1460` (Required: 1)
* Component ID: `5020` (Required: 1)
* Component ID: `5021` (Required: 1)
* Component ID: `5022` (Required: 1)
* Component ID: `5023` (Required: 1)
* Component ID: `5024` (Required: 1)
* Component ID: `5025` (Required: 1)
* Component ID: `5026` (Required: 1)
* Component ID: `5027` (Required: 1)
* Component ID: `5028` (Required: 1)
* Component ID: `5029` (Required: 1)

## 7. API / Data Mapping
* API ID: `4775` (Required: 1)
* API ID: `4776` (Required: 1)
* API ID: `4777` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `intake_coordinator_documents_runtime`
* **Test Name**: `IntakeCoordinatorDocumentsScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `IntakeCoordinatorDocumentsScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `volunteer_coordinator`)
2. **visit** (Selector: `None`, Value: `/executive/intake-coordinator-documents`)
3. **should_be_visible** (Selector: `intake_coordinator_documents-screen`, Value: `None`)
4. **should_be_visible** (Selector: `intake_coordinator_documents-title`, Value: `None`)
5. **should_be_visible** (Selector: `intake_coordinator_documents-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
