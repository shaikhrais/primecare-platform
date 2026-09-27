# SCREEN DATA CONTEXT: business_development_compliance

Below are the database records from `governance.db` used to configure and build the **Head of Business Development - BusinessDevelopmentComplianceScreen** screen.

---

## 1. Screen Record
* **ID**: `90`
* **App ID**: `1`
* **Role ID**: `37`
* **Screen Code**: `business_development_compliance`
* **Screen Name**: `BusinessDevelopmentComplianceScreen`
* **Route Path**: `/common/business-development-compliance`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/common/business_development_compliance_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `37`
* **Role Code**: `bus_dev`
* **Role Name**: `Head of Business Development`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Head of Business Development personnel to oversee, audit, and coordinate operations related to businessdevelopmentcompliancescreen.`
* **User Story**: `As a Head of Business Development, I want to access the BusinessDevelopmentComplianceScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `BusinessDevelopmentComplianceScreen`
* **Acceptance Criteria**:
- The BusinessDevelopmentComplianceScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Head of Business Development access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `business_development_compliance-screen` (Type: layout, Required: 1)
* **page_title** -> `business_development_compliance-title` (Type: header, Required: 1)
* **primary_content** -> `business_development_compliance-content` (Type: layout, Required: 1)
* **businessdevelopmentcompliance_title** -> `businessdevelopmentcompliance-title` (Type: header, Required: 0)
* **businessdevelopmentcompliance_content** -> `businessdevelopmentcompliance-content` (Type: layout, Required: 0)
* **businessdevelopmentcompliance_btn_1** -> `businessdevelopmentcompliance-btn-1` (Type: button, Required: 0)
* **businessdevelopmentcompliance_screen** -> `businessdevelopmentcompliance-screen` (Type: layout, Required: 0)
* **businessdevelopmentcompliance_btn_3** -> `businessdevelopmentcompliance-btn-3` (Type: button, Required: 0)
* **businessdevelopmentcompliance_btn_2** -> `businessdevelopmentcompliance-btn-2` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `98` (Required: 1)
* Component ID: `632` (Required: 1)
* Component ID: `1166` (Required: 1)
* Component ID: `2381` (Required: 1)
* Component ID: `2382` (Required: 1)
* Component ID: `2383` (Required: 1)
* Component ID: `2384` (Required: 1)
* Component ID: `2385` (Required: 1)
* Component ID: `2386` (Required: 1)
* Component ID: `2387` (Required: 1)
* Component ID: `2388` (Required: 1)
* Component ID: `2389` (Required: 1)
* Component ID: `2390` (Required: 1)

## 7. API / Data Mapping
* API ID: `4367` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `business_development_compliance_runtime`
* **Test Name**: `BusinessDevelopmentComplianceScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `BusinessDevelopmentComplianceScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `bus_dev`)
2. **visit** (Selector: `None`, Value: `/common/business-development-compliance`)
3. **should_be_visible** (Selector: `business_development_compliance-screen`, Value: `None`)
4. **should_be_visible** (Selector: `business_development_compliance-title`, Value: `None`)
5. **should_be_visible** (Selector: `business_development_compliance-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
