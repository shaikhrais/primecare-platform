# SCREEN DATA CONTEXT: service_quality

Below are the database records from `governance.db` used to configure and build the **Chief Operating Officer (COO) - ServiceQualityScreen** screen.

---

## 1. Screen Record
* **ID**: `473`
* **App ID**: `7`
* **Role ID**: `23`
* **Screen Code**: `service_quality`
* **Screen Name**: `ServiceQualityScreen`
* **Route Path**: `/executive/service-quality`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/executive/service_quality_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `7`
* **App Code**: `co`
* **App Name**: `Primecare Corporate`

## 3. Role Record
* **ID**: `23`
* **Role Code**: `coo`
* **Role Name**: `Chief Operating Officer (COO)`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Corporate module to enable Chief Operating Officer (COO) personnel to oversee, audit, and coordinate operations related to servicequalityscreen.`
* **User Story**: `As a Chief Operating Officer (COO), I want to access the ServiceQualityScreen within the Primecare Corporate application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `ServiceQualityScreen`
* **Acceptance Criteria**:
- The ServiceQualityScreen route loads successfully within the Primecare Corporate workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Chief Operating Officer (COO) access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `service_quality-screen` (Type: layout, Required: 1)
* **page_title** -> `service_quality-title` (Type: header, Required: 1)
* **primary_content** -> `service_quality-content` (Type: layout, Required: 1)
* **servicequality_loading** -> `servicequality-loading` (Type: loading, Required: 0)
* **servicequality_content** -> `servicequality-content` (Type: layout, Required: 0)
* **servicequality_screen** -> `servicequality-screen` (Type: layout, Required: 0)
* **servicequality_btn_1** -> `servicequality-btn-1` (Type: button, Required: 0)
* **servicequality_btn_2** -> `servicequality-btn-2` (Type: button, Required: 0)
* **servicequality_btn_3** -> `servicequality-btn-3` (Type: button, Required: 0)
* **servicequality_title** -> `servicequality-title` (Type: header, Required: 0)

## 6. Component Mapping
* Component ID: `402` (Required: 1)
* Component ID: `936` (Required: 1)
* Component ID: `1470` (Required: 1)
* Component ID: `5113` (Required: 1)
* Component ID: `5114` (Required: 1)
* Component ID: `5115` (Required: 1)
* Component ID: `5116` (Required: 1)
* Component ID: `5117` (Required: 1)
* Component ID: `5118` (Required: 1)
* Component ID: `5119` (Required: 1)
* Component ID: `5120` (Required: 1)
* Component ID: `5121` (Required: 1)
* Component ID: `5122` (Required: 1)

## 7. API / Data Mapping
* API ID: `4788` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `service_quality_runtime`
* **Test Name**: `ServiceQualityScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `ServiceQualityScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `coo`)
2. **visit** (Selector: `None`, Value: `/executive/service-quality`)
3. **should_be_visible** (Selector: `service_quality-screen`, Value: `None`)
4. **should_be_visible** (Selector: `service_quality-title`, Value: `None`)
5. **should_be_visible** (Selector: `service_quality-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
