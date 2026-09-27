# SCREEN DATA CONTEXT: hr_hiring_compliance

Below are the database records from `governance.db` used to configure and build the **Talent Acquisition Manager - HrHiringComplianceScreen** screen.

---

## 1. Screen Record
* **ID**: `255`
* **App ID**: `1`
* **Role ID**: `45`
* **Screen Code**: `hr_hiring_compliance`
* **Screen Name**: `HrHiringComplianceScreen`
* **Route Path**: `/staff/hr-hiring-compliance`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/staff/hr_hiring_compliance_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `45`
* **Role Code**: `hr_hiring`
* **Role Name**: `Talent Acquisition Manager`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Talent Acquisition Manager personnel to oversee, audit, and coordinate operations related to hrhiringcompliancescreen.`
* **User Story**: `As a Talent Acquisition Manager, I want to access the HrHiringComplianceScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `HrHiringComplianceScreen`
* **Acceptance Criteria**:
- The HrHiringComplianceScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Talent Acquisition Manager access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `hr_hiring_compliance-screen` (Type: layout, Required: 1)
* **page_title** -> `hr_hiring_compliance-title` (Type: header, Required: 1)
* **primary_content** -> `hr_hiring_compliance-content` (Type: layout, Required: 1)
* **hrhiringcompliance_screen** -> `hrhiringcompliance-screen` (Type: layout, Required: 0)
* **hrhiringcompliance_btn_5** -> `hrhiringcompliance-btn-5` (Type: button, Required: 0)
* **hrhiringcompliance_btn_2** -> `hrhiringcompliance-btn-2` (Type: button, Required: 0)
* **hrhiringcompliance_title** -> `hrhiringcompliance-title` (Type: header, Required: 0)
* **hrhiringcompliance_btn_3** -> `hrhiringcompliance-btn-3` (Type: button, Required: 0)
* **hrhiringcompliance_btn_1** -> `hrhiringcompliance-btn-1` (Type: button, Required: 0)
* **hrhiringcompliance_btn_4** -> `hrhiringcompliance-btn-4` (Type: button, Required: 0)
* **hrhiringcompliance_content** -> `hrhiringcompliance-content` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `263` (Required: 1)
* Component ID: `797` (Required: 1)
* Component ID: `1331` (Required: 1)
* Component ID: `3870` (Required: 1)
* Component ID: `3871` (Required: 1)
* Component ID: `3872` (Required: 1)
* Component ID: `3873` (Required: 1)
* Component ID: `3874` (Required: 1)
* Component ID: `3875` (Required: 1)
* Component ID: `3876` (Required: 1)
* Component ID: `3877` (Required: 1)
* Component ID: `3878` (Required: 1)
* Component ID: `3879` (Required: 1)

## 7. API / Data Mapping
* API ID: `4570` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `hr_hiring_compliance_runtime`
* **Test Name**: `HrHiringComplianceScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `HrHiringComplianceScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `hr_hiring`)
2. **visit** (Selector: `None`, Value: `/staff/hr-hiring-compliance`)
3. **should_be_visible** (Selector: `hr_hiring_compliance-screen`, Value: `None`)
4. **should_be_visible** (Selector: `hr_hiring_compliance-title`, Value: `None`)
5. **should_be_visible** (Selector: `hr_hiring_compliance-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
