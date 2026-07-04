# SCREEN DATA CONTEXT: cfo_compliance

Below are the database records from `governance.db` used to configure and build the **Chief Financial Officer (CFO) - CfoComplianceScreen** screen.

---

## 1. Screen Record
* **ID**: `154`
* **App ID**: `1`
* **Role ID**: `21`
* **Screen Code**: `cfo_compliance`
* **Screen Name**: `CfoComplianceScreen`
* **Route Path**: `/executive/cfo-compliance`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/executive/cfo_compliance_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `21`
* **Role Code**: `cfo`
* **Role Name**: `Chief Financial Officer (CFO)`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Chief Financial Officer (CFO) personnel to oversee, audit, and coordinate operations related to cfocompliancescreen.`
* **User Story**: `As a Chief Financial Officer (CFO), I want to access the CfoComplianceScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `CfoComplianceScreen`
* **Acceptance Criteria**:
- The CfoComplianceScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Chief Financial Officer (CFO) access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `cfo_compliance-screen` (Type: layout, Required: 1)
* **page_title** -> `cfo_compliance-title` (Type: header, Required: 1)
* **primary_content** -> `cfo_compliance-content` (Type: layout, Required: 1)
* **cfocompliance_btn_2** -> `cfocompliance-btn-2` (Type: button, Required: 0)
* **cfocompliance_btn_3** -> `cfocompliance-btn-3` (Type: button, Required: 0)
* **cfocompliance_loading** -> `cfocompliance-loading` (Type: loading, Required: 0)
* **cfocompliance_btn_1** -> `cfocompliance-btn-1` (Type: button, Required: 0)
* **cfocompliance_title** -> `cfocompliance-title` (Type: header, Required: 0)
* **cfocompliance_content** -> `cfocompliance-content` (Type: layout, Required: 0)
* **cfocompliance_screen** -> `cfocompliance-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `162` (Required: 1)
* Component ID: `696` (Required: 1)
* Component ID: `1230` (Required: 1)
* Component ID: `2920` (Required: 1)
* Component ID: `2921` (Required: 1)
* Component ID: `2922` (Required: 1)
* Component ID: `2923` (Required: 1)
* Component ID: `2924` (Required: 1)
* Component ID: `2925` (Required: 1)
* Component ID: `2926` (Required: 1)
* Component ID: `2927` (Required: 1)
* Component ID: `2928` (Required: 1)
* Component ID: `2929` (Required: 1)

## 7. API / Data Mapping
* API ID: `4437` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `cfo_compliance_runtime`
* **Test Name**: `CfoComplianceScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `CfoComplianceScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `cfo`)
2. **visit** (Selector: `None`, Value: `/executive/cfo-compliance`)
3. **should_be_visible** (Selector: `cfo_compliance-screen`, Value: `None`)
4. **should_be_visible** (Selector: `cfo_compliance-title`, Value: `None`)
5. **should_be_visible** (Selector: `cfo_compliance-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
