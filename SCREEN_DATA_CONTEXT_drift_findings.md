# SCREEN DATA CONTEXT: drift_findings

Below are the database records from `governance.db` used to configure and build the **Governance Officer - DriftFindingsScreen** screen.

---

## 1. Screen Record
* **ID**: `581`
* **App ID**: `10`
* **Role ID**: `36`
* **Screen Code**: `drift_findings`
* **Screen Name**: `DriftFindingsScreen`
* **Route Path**: `/common/drift-findings`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/common/drift_findings_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `10`
* **App Code**: `go`
* **App Name**: `Primecare Governance`

## 3. Role Record
* **ID**: `36`
* **Role Code**: `governance`
* **Role Name**: `Governance Officer`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Governance module to enable Governance Officer personnel to oversee, audit, and coordinate operations related to driftfindingsscreen.`
* **User Story**: `As a Governance Officer, I want to access the DriftFindingsScreen within the Primecare Governance application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `DriftFindingsScreen`
* **Acceptance Criteria**:
- The DriftFindingsScreen route loads successfully within the Primecare Governance workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Governance Officer access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `drift_findings-screen` (Type: layout, Required: 1)
* **page_title** -> `drift_findings-title` (Type: header, Required: 1)
* **primary_content** -> `drift_findings-content` (Type: layout, Required: 1)
* **driftfindings_screen** -> `driftfindings-screen` (Type: layout, Required: 0)
* **driftfindings_btn_2** -> `driftfindings-btn-2` (Type: button, Required: 0)
* **driftfindings_btn_3** -> `driftfindings-btn-3` (Type: button, Required: 0)
* **driftfindings_btn_1** -> `driftfindings-btn-1` (Type: button, Required: 0)
* **driftfindings_loading** -> `driftfindings-loading` (Type: loading, Required: 0)
* **driftfindings_title** -> `driftfindings-title` (Type: header, Required: 0)
* **driftfindings_content** -> `driftfindings-content` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `505` (Required: 1)
* Component ID: `1039` (Required: 1)
* Component ID: `1573` (Required: 1)
* Component ID: `6063` (Required: 1)
* Component ID: `6064` (Required: 1)
* Component ID: `6065` (Required: 1)
* Component ID: `6066` (Required: 1)
* Component ID: `6067` (Required: 1)
* Component ID: `6068` (Required: 1)
* Component ID: `6069` (Required: 1)
* Component ID: `6070` (Required: 1)
* Component ID: `6071` (Required: 1)
* Component ID: `6072` (Required: 1)

## 7. API / Data Mapping
* API ID: `4928` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `drift_findings_runtime`
* **Test Name**: `DriftFindingsScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `DriftFindingsScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `governance`)
2. **visit** (Selector: `None`, Value: `/common/drift-findings`)
3. **should_be_visible** (Selector: `drift_findings-screen`, Value: `None`)
4. **should_be_visible** (Selector: `drift_findings-title`, Value: `None`)
5. **should_be_visible** (Selector: `drift_findings-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
