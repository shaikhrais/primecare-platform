# SCREEN DATA CONTEXT: operations_manager_compliance

Below are the database records from `governance.db` used to configure and build the **Operations Manager - OperationsManagerComplianceScreen** screen.

---

## 1. Screen Record
* **ID**: `211`
* **App ID**: `1`
* **Role ID**: `40`
* **Screen Code**: `operations_manager_compliance`
* **Screen Name**: `OperationsManagerComplianceScreen`
* **Route Path**: `/management/operations-manager-compliance`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/management/operations_manager_compliance_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `40`
* **Role Code**: `ops_manager`
* **Role Name**: `Operations Manager`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Operations Manager personnel to oversee, audit, and coordinate operations related to operationsmanagercompliancescreen.`
* **User Story**: `As a Operations Manager, I want to access the OperationsManagerComplianceScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `OperationsManagerComplianceScreen`
* **Acceptance Criteria**:
- The OperationsManagerComplianceScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Operations Manager access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `operations_manager_compliance-screen` (Type: layout, Required: 1)
* **page_title** -> `operations_manager_compliance-title` (Type: header, Required: 1)
* **primary_content** -> `operations_manager_compliance-content` (Type: layout, Required: 1)
* **operationsmanagercompliance_btn_1** -> `operationsmanagercompliance-btn-1` (Type: button, Required: 0)
* **operationsmanagercompliance_title** -> `operationsmanagercompliance-title` (Type: header, Required: 0)
* **operationsmanagercompliance_content** -> `operationsmanagercompliance-content` (Type: layout, Required: 0)
* **operationsmanagercompliance_btn_3** -> `operationsmanagercompliance-btn-3` (Type: button, Required: 0)
* **operationsmanagercompliance_btn_2** -> `operationsmanagercompliance-btn-2` (Type: button, Required: 0)
* **operationsmanagercompliance_screen** -> `operationsmanagercompliance-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `219` (Required: 1)
* Component ID: `753` (Required: 1)
* Component ID: `1287` (Required: 1)
* Component ID: `3461` (Required: 1)
* Component ID: `3462` (Required: 1)
* Component ID: `3463` (Required: 1)
* Component ID: `3464` (Required: 1)
* Component ID: `3465` (Required: 1)
* Component ID: `3466` (Required: 1)
* Component ID: `3467` (Required: 1)
* Component ID: `3468` (Required: 1)
* Component ID: `3469` (Required: 1)
* Component ID: `3470` (Required: 1)

## 7. API / Data Mapping
* API ID: `4500` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `operations_manager_compliance_runtime`
* **Test Name**: `OperationsManagerComplianceScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `OperationsManagerComplianceScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `ops_manager`)
2. **visit** (Selector: `None`, Value: `/management/operations-manager-compliance`)
3. **should_be_visible** (Selector: `operations_manager_compliance-screen`, Value: `None`)
4. **should_be_visible** (Selector: `operations_manager_compliance-title`, Value: `None`)
5. **should_be_visible** (Selector: `operations_manager_compliance-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
