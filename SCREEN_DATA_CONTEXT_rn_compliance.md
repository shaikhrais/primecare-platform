# SCREEN DATA CONTEXT: rn_compliance

Below are the database records from `governance.db` used to configure and build the **Registered Nurse (RN) - RnComplianceScreen** screen.

---

## 1. Screen Record
* **ID**: `242`
* **App ID**: `1`
* **Role ID**: `8`
* **Screen Code**: `rn_compliance`
* **Screen Name**: `RnComplianceScreen`
* **Route Path**: `/offices/clinical/roles/rn/rn-compliance`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/rn/rn_compliance_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `8`
* **Role Code**: `rn`
* **Role Name**: `Registered Nurse (RN)`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Registered Nurse (RN) personnel to oversee, audit, and coordinate operations related to rncompliancescreen.`
* **User Story**: `As a Registered Nurse (RN), I want to access the RnComplianceScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `RnComplianceScreen`
* **Acceptance Criteria**:
- The RnComplianceScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Registered Nurse (RN) access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `rn_compliance-screen` (Type: layout, Required: 1)
* **page_title** -> `rn_compliance-title` (Type: header, Required: 1)
* **primary_content** -> `rn_compliance-content` (Type: layout, Required: 1)
* **rncompliance_btn_2** -> `rncompliance-btn-2` (Type: button, Required: 0)
* **rncompliance_content** -> `rncompliance-content` (Type: layout, Required: 0)
* **rncompliance_btn_1** -> `rncompliance-btn-1` (Type: button, Required: 0)
* **rncompliance_screen** -> `rncompliance-screen` (Type: layout, Required: 0)
* **rncompliance_loading** -> `rncompliance-loading` (Type: loading, Required: 0)
* **rncompliance_btn_3** -> `rncompliance-btn-3` (Type: button, Required: 0)
* **rncompliance_title** -> `rncompliance-title` (Type: header, Required: 0)

## 6. Component Mapping
* Component ID: `250` (Required: 1)
* Component ID: `784` (Required: 1)
* Component ID: `1318` (Required: 1)
* Component ID: `3740` (Required: 1)
* Component ID: `3741` (Required: 1)
* Component ID: `3742` (Required: 1)
* Component ID: `3743` (Required: 1)
* Component ID: `3744` (Required: 1)
* Component ID: `3745` (Required: 1)
* Component ID: `3746` (Required: 1)
* Component ID: `3747` (Required: 1)
* Component ID: `3748` (Required: 1)
* Component ID: `3749` (Required: 1)

## 7. API / Data Mapping
* API ID: `4545` (Required: 1)
* API ID: `4546` (Required: 1)
* API ID: `4547` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `rn_compliance_runtime`
* **Test Name**: `RnComplianceScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `RnComplianceScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `rn`)
2. **visit** (Selector: `None`, Value: `/offices/clinical/roles/rn/rn-compliance`)
3. **should_be_visible** (Selector: `rn_compliance-screen`, Value: `None`)
4. **should_be_visible** (Selector: `rn_compliance-title`, Value: `None`)
5. **should_be_visible** (Selector: `rn_compliance-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
