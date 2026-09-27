# SCREEN DATA CONTEXT: governance_officer_compliance

Below are the database records from `governance.db` used to configure and build the **Governance Officer - GovernanceOfficerComplianceScreen** screen.

---

## 1. Screen Record
* **ID**: `199`
* **App ID**: `1`
* **Role ID**: `36`
* **Screen Code**: `governance_officer_compliance`
* **Screen Name**: `GovernanceOfficerComplianceScreen`
* **Route Path**: `/management/governance-officer-compliance`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/management/governance_officer_compliance_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `36`
* **Role Code**: `governance`
* **Role Name**: `Governance Officer`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Governance Officer personnel to oversee, audit, and coordinate operations related to governanceofficercompliancescreen.`
* **User Story**: `As a Governance Officer, I want to access the GovernanceOfficerComplianceScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `GovernanceOfficerComplianceScreen`
* **Acceptance Criteria**:
- The GovernanceOfficerComplianceScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Governance Officer access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `governance_officer_compliance-screen` (Type: layout, Required: 1)
* **page_title** -> `governance_officer_compliance-title` (Type: header, Required: 1)
* **primary_content** -> `governance_officer_compliance-content` (Type: layout, Required: 1)
* **governanceofficercompliance_screen** -> `governanceofficercompliance-screen` (Type: layout, Required: 0)
* **governanceofficercompliance_btn_3** -> `governanceofficercompliance-btn-3` (Type: button, Required: 0)
* **governanceofficercompliance_content** -> `governanceofficercompliance-content` (Type: layout, Required: 0)
* **governanceofficercompliance_title** -> `governanceofficercompliance-title` (Type: header, Required: 0)
* **governanceofficercompliance_btn_2** -> `governanceofficercompliance-btn-2` (Type: button, Required: 0)
* **governanceofficercompliance_btn_1** -> `governanceofficercompliance-btn-1` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `207` (Required: 1)
* Component ID: `741` (Required: 1)
* Component ID: `1275` (Required: 1)
* Component ID: `3343` (Required: 1)
* Component ID: `3344` (Required: 1)
* Component ID: `3345` (Required: 1)
* Component ID: `3346` (Required: 1)
* Component ID: `3347` (Required: 1)
* Component ID: `3348` (Required: 1)
* Component ID: `3349` (Required: 1)
* Component ID: `3350` (Required: 1)
* Component ID: `3351` (Required: 1)
* Component ID: `3352` (Required: 1)

## 7. API / Data Mapping
* API ID: `4488` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `governance_officer_compliance_runtime`
* **Test Name**: `GovernanceOfficerComplianceScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `GovernanceOfficerComplianceScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `governance`)
2. **visit** (Selector: `None`, Value: `/management/governance-officer-compliance`)
3. **should_be_visible** (Selector: `governance_officer_compliance-screen`, Value: `None`)
4. **should_be_visible** (Selector: `governance_officer_compliance-title`, Value: `None`)
5. **should_be_visible** (Selector: `governance_officer_compliance-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
