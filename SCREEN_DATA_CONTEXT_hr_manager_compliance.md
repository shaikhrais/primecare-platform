# SCREEN DATA CONTEXT: hr_manager_compliance

Below are the database records from `governance.db` used to configure and build the **HR Director - HrManagerComplianceScreen** screen.

---

## 1. Screen Record
* **ID**: `258`
* **App ID**: `1`
* **Role ID**: `27`
* **Screen Code**: `hr_manager_compliance`
* **Screen Name**: `HrManagerComplianceScreen`
* **Route Path**: `/staff/hr-manager-compliance`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/staff/hr_manager_compliance_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `27`
* **Role Code**: `hr_director`
* **Role Name**: `HR Director`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable HR Director personnel to oversee, audit, and coordinate operations related to hrmanagercompliancescreen.`
* **User Story**: `As a HR Director, I want to access the HrManagerComplianceScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `HrManagerComplianceScreen`
* **Acceptance Criteria**:
- The HrManagerComplianceScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only HR Director access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `hr_manager_compliance-screen` (Type: layout, Required: 1)
* **page_title** -> `hr_manager_compliance-title` (Type: header, Required: 1)
* **primary_content** -> `hr_manager_compliance-content` (Type: layout, Required: 1)
* **hrmanagercompliance_btn_4** -> `hrmanagercompliance-btn-4` (Type: button, Required: 0)
* **hrmanagercompliance_btn_3** -> `hrmanagercompliance-btn-3` (Type: button, Required: 0)
* **hrmanagercompliance_btn_5** -> `hrmanagercompliance-btn-5` (Type: button, Required: 0)
* **hrmanagercompliance_btn_1** -> `hrmanagercompliance-btn-1` (Type: button, Required: 0)
* **hrmanagercompliance_title** -> `hrmanagercompliance-title` (Type: header, Required: 0)
* **hrmanagercompliance_content** -> `hrmanagercompliance-content` (Type: layout, Required: 0)
* **hrmanagercompliance_btn_2** -> `hrmanagercompliance-btn-2` (Type: button, Required: 0)
* **hrmanagercompliance_screen** -> `hrmanagercompliance-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `266` (Required: 1)
* Component ID: `800` (Required: 1)
* Component ID: `1334` (Required: 1)
* Component ID: `3896` (Required: 1)
* Component ID: `3897` (Required: 1)
* Component ID: `3898` (Required: 1)
* Component ID: `3899` (Required: 1)
* Component ID: `3900` (Required: 1)
* Component ID: `3901` (Required: 1)
* Component ID: `3902` (Required: 1)
* Component ID: `3903` (Required: 1)
* Component ID: `3904` (Required: 1)
* Component ID: `3905` (Required: 1)

## 7. API / Data Mapping
* API ID: `4573` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `hr_manager_compliance_runtime`
* **Test Name**: `HrManagerComplianceScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `HrManagerComplianceScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `hr_director`)
2. **visit** (Selector: `None`, Value: `/staff/hr-manager-compliance`)
3. **should_be_visible** (Selector: `hr_manager_compliance-screen`, Value: `None`)
4. **should_be_visible** (Selector: `hr_manager_compliance-title`, Value: `None`)
5. **should_be_visible** (Selector: `hr_manager_compliance-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
