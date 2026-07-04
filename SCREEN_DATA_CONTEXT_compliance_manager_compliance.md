# SCREEN DATA CONTEXT: compliance_manager_compliance

Below are the database records from `governance.db` used to configure and build the **Compliance Manager - ComplianceManagerComplianceScreen** screen.

---

## 1. Screen Record
* **ID**: `190`
* **App ID**: `1`
* **Role ID**: `33`
* **Screen Code**: `compliance_manager_compliance`
* **Screen Name**: `ComplianceManagerComplianceScreen`
* **Route Path**: `/management/compliance-manager-compliance`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/management/compliance_manager_compliance_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `33`
* **Role Code**: `compliance`
* **Role Name**: `Compliance Manager`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Compliance Manager personnel to oversee, audit, and coordinate operations related to compliancemanagercompliancescreen.`
* **User Story**: `As a Compliance Manager, I want to access the ComplianceManagerComplianceScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `ComplianceManagerComplianceScreen`
* **Acceptance Criteria**:
- The ComplianceManagerComplianceScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Compliance Manager access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `compliance_manager_compliance-screen` (Type: layout, Required: 1)
* **page_title** -> `compliance_manager_compliance-title` (Type: header, Required: 1)
* **primary_content** -> `compliance_manager_compliance-content` (Type: layout, Required: 1)
* **compliancemanagercompliance_btn_2** -> `compliancemanagercompliance-btn-2` (Type: button, Required: 0)
* **compliancemanagercompliance_btn_1** -> `compliancemanagercompliance-btn-1` (Type: button, Required: 0)
* **compliancemanagercompliance_btn_3** -> `compliancemanagercompliance-btn-3` (Type: button, Required: 0)
* **compliancemanagercompliance_title** -> `compliancemanagercompliance-title` (Type: header, Required: 0)
* **compliancemanagercompliance_content** -> `compliancemanagercompliance-content` (Type: layout, Required: 0)
* **compliancemanagercompliance_screen** -> `compliancemanagercompliance-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `198` (Required: 1)
* Component ID: `732` (Required: 1)
* Component ID: `1266` (Required: 1)
* Component ID: `3256` (Required: 1)
* Component ID: `3257` (Required: 1)
* Component ID: `3258` (Required: 1)
* Component ID: `3259` (Required: 1)
* Component ID: `3260` (Required: 1)
* Component ID: `3261` (Required: 1)
* Component ID: `3262` (Required: 1)

## 7. API / Data Mapping
* API ID: `4479` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `compliance_manager_compliance_runtime`
* **Test Name**: `ComplianceManagerComplianceScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `ComplianceManagerComplianceScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `compliance`)
2. **visit** (Selector: `None`, Value: `/management/compliance-manager-compliance`)
3. **should_be_visible** (Selector: `compliance_manager_compliance-screen`, Value: `None`)
4. **should_be_visible** (Selector: `compliance_manager_compliance-title`, Value: `None`)
5. **should_be_visible** (Selector: `compliance_manager_compliance-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
