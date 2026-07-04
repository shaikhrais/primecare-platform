# SCREEN DATA CONTEXT: infrastructure_compliance

Below are the database records from `governance.db` used to configure and build the **Infrastructure Auditor - InfrastructureComplianceScreen** screen.

---

## 1. Screen Record
* **ID**: `117`
* **App ID**: `1`
* **Role ID**: `17`
* **Screen Code**: `infrastructure_compliance`
* **Screen Name**: `InfrastructureComplianceScreen`
* **Route Path**: `/common/infrastructure-compliance`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/common/infrastructure_compliance_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Infrastructure Auditor personnel to oversee, audit, and coordinate operations related to infrastructurecompliancescreen.`
* **User Story**: `As a Infrastructure Auditor, I want to access the InfrastructureComplianceScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `InfrastructureComplianceScreen`
* **Acceptance Criteria**:
- The InfrastructureComplianceScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Infrastructure Auditor access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `infrastructure_compliance-screen` (Type: layout, Required: 1)
* **page_title** -> `infrastructure_compliance-title` (Type: header, Required: 1)
* **primary_content** -> `infrastructure_compliance-content` (Type: layout, Required: 1)
* **infrastructurecompliance_btn_2** -> `infrastructurecompliance-btn-2` (Type: button, Required: 0)
* **infrastructurecompliance_btn_1** -> `infrastructurecompliance-btn-1` (Type: button, Required: 0)
* **infrastructurecompliance_title** -> `infrastructurecompliance-title` (Type: header, Required: 0)
* **infrastructurecompliance_content** -> `infrastructurecompliance-content` (Type: layout, Required: 0)
* **infrastructurecompliance_screen** -> `infrastructurecompliance-screen` (Type: layout, Required: 0)
* **infrastructurecompliance_btn_3** -> `infrastructurecompliance-btn-3` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `125` (Required: 1)
* Component ID: `659` (Required: 1)
* Component ID: `1193` (Required: 1)
* Component ID: `2598` (Required: 1)
* Component ID: `2599` (Required: 1)
* Component ID: `2600` (Required: 1)
* Component ID: `2601` (Required: 1)
* Component ID: `2602` (Required: 1)
* Component ID: `2603` (Required: 1)
* Component ID: `2604` (Required: 1)
* Component ID: `2605` (Required: 1)
* Component ID: `2606` (Required: 1)
* Component ID: `2607` (Required: 1)

## 7. API / Data Mapping
* API ID: `4394` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `infrastructure_compliance_runtime`
* **Test Name**: `InfrastructureComplianceScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `InfrastructureComplianceScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `infrastructure`)
2. **visit** (Selector: `None`, Value: `/common/infrastructure-compliance`)
3. **should_be_visible** (Selector: `infrastructure_compliance-screen`, Value: `None`)
4. **should_be_visible** (Selector: `infrastructure_compliance-title`, Value: `None`)
5. **should_be_visible** (Selector: `infrastructure_compliance-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
