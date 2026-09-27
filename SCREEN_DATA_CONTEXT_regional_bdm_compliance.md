# SCREEN DATA CONTEXT: regional_bdm_compliance

Below are the database records from `governance.db` used to configure and build the **Regional BDM - RegionalBdmComplianceScreen** screen.

---

## 1. Screen Record
* **ID**: `217`
* **App ID**: `1`
* **Role ID**: `42`
* **Screen Code**: `regional_bdm_compliance`
* **Screen Name**: `RegionalBdmComplianceScreen`
* **Route Path**: `/management/regional-bdm-compliance`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/management/regional_bdm_compliance_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `42`
* **Role Code**: `regional_bdm`
* **Role Name**: `Regional BDM`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Regional BDM personnel to oversee, audit, and coordinate operations related to regionalbdmcompliancescreen.`
* **User Story**: `As a Regional BDM, I want to access the RegionalBdmComplianceScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `RegionalBdmComplianceScreen`
* **Acceptance Criteria**:
- The RegionalBdmComplianceScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Regional BDM access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `regional_bdm_compliance-screen` (Type: layout, Required: 1)
* **page_title** -> `regional_bdm_compliance-title` (Type: header, Required: 1)
* **primary_content** -> `regional_bdm_compliance-content` (Type: layout, Required: 1)
* **regionalbdmcompliance_btn_3** -> `regionalbdmcompliance-btn-3` (Type: button, Required: 0)
* **regionalbdmcompliance_title** -> `regionalbdmcompliance-title` (Type: header, Required: 0)
* **regionalbdmcompliance_btn_1** -> `regionalbdmcompliance-btn-1` (Type: button, Required: 0)
* **regionalbdmcompliance_screen** -> `regionalbdmcompliance-screen` (Type: layout, Required: 0)
* **regionalbdmcompliance_btn_2** -> `regionalbdmcompliance-btn-2` (Type: button, Required: 0)
* **regionalbdmcompliance_content** -> `regionalbdmcompliance-content` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `225` (Required: 1)
* Component ID: `759` (Required: 1)
* Component ID: `1293` (Required: 1)
* Component ID: `3517` (Required: 1)
* Component ID: `3518` (Required: 1)
* Component ID: `3519` (Required: 1)
* Component ID: `3520` (Required: 1)
* Component ID: `3521` (Required: 1)
* Component ID: `3522` (Required: 1)
* Component ID: `3523` (Required: 1)
* Component ID: `3524` (Required: 1)

## 7. API / Data Mapping
* API ID: `4506` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `regional_bdm_compliance_runtime`
* **Test Name**: `RegionalBdmComplianceScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `RegionalBdmComplianceScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `regional_bdm`)
2. **visit** (Selector: `None`, Value: `/management/regional-bdm-compliance`)
3. **should_be_visible** (Selector: `regional_bdm_compliance-screen`, Value: `None`)
4. **should_be_visible** (Selector: `regional_bdm_compliance-title`, Value: `None`)
5. **should_be_visible** (Selector: `regional_bdm_compliance-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
