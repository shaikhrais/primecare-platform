# SCREEN DATA CONTEXT: coo_compliance

Below are the database records from `governance.db` used to configure and build the **Chief Operating Officer (COO) - CooComplianceScreen** screen.

---

## 1. Screen Record
* **ID**: `160`
* **App ID**: `1`
* **Role ID**: `23`
* **Screen Code**: `coo_compliance`
* **Screen Name**: `CooComplianceScreen`
* **Route Path**: `/offices/corporate/roles/coo/compliance-view`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/executive/coo_compliance_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `23`
* **Role Code**: `coo`
* **Role Name**: `Chief Operating Officer (COO)`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Chief Operating Officer (COO) personnel to oversee, audit, and coordinate operations related to coocompliancescreen.`
* **User Story**: `As a Chief Operating Officer (COO), I want to access the CooComplianceScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `CooComplianceScreen`
* **Acceptance Criteria**:
- The CooComplianceScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Chief Operating Officer (COO) access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `coo_compliance-screen` (Type: layout, Required: 1)
* **page_title** -> `coo_compliance-title` (Type: header, Required: 1)
* **primary_content** -> `coo_compliance-content` (Type: layout, Required: 1)
* **coocompliance_content** -> `coocompliance-content` (Type: layout, Required: 0)
* **coocompliance_btn_3** -> `coocompliance-btn-3` (Type: button, Required: 0)
* **coocompliance_btn_1** -> `coocompliance-btn-1` (Type: button, Required: 0)
* **coocompliance_btn_2** -> `coocompliance-btn-2` (Type: button, Required: 0)
* **coocompliance_screen** -> `coocompliance-screen` (Type: layout, Required: 0)
* **coocompliance_loading** -> `coocompliance-loading` (Type: loading, Required: 0)
* **coocompliance_title** -> `coocompliance-title` (Type: header, Required: 0)

## 6. Component Mapping
* Component ID: `168` (Required: 1)
* Component ID: `702` (Required: 1)
* Component ID: `1236` (Required: 1)
* Component ID: `2980` (Required: 1)
* Component ID: `2981` (Required: 1)
* Component ID: `2982` (Required: 1)
* Component ID: `2983` (Required: 1)
* Component ID: `2984` (Required: 1)
* Component ID: `2985` (Required: 1)
* Component ID: `2986` (Required: 1)
* Component ID: `2987` (Required: 1)
* Component ID: `2988` (Required: 1)
* Component ID: `2989` (Required: 1)

## 7. API / Data Mapping
* API ID: `4449` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `coo_compliance_runtime`
* **Test Name**: `CooComplianceScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `CooComplianceScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `coo`)
2. **visit** (Selector: `None`, Value: `/offices/corporate/roles/coo/compliance-view`)
3. **should_be_visible** (Selector: `coo_compliance-screen`, Value: `None`)
4. **should_be_visible** (Selector: `coo_compliance-title`, Value: `None`)
5. **should_be_visible** (Selector: `coo_compliance-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
