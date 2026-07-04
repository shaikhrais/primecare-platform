# SCREEN DATA CONTEXT: customer_support_compliance

Below are the database records from `governance.db` used to configure and build the **Customer Support - CustomerSupportComplianceScreen** screen.

---

## 1. Screen Record
* **ID**: `102`
* **App ID**: `1`
* **Role ID**: `61`
* **Screen Code**: `customer_support_compliance`
* **Screen Name**: `CustomerSupportComplianceScreen`
* **Route Path**: `/common/customer-support-compliance`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/common/customer_support_compliance_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `61`
* **Role Code**: `customer_support`
* **Role Name**: `Customer Support`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Customer Support personnel to oversee, audit, and coordinate operations related to customersupportcompliancescreen.`
* **User Story**: `As a Customer Support, I want to access the CustomerSupportComplianceScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `CustomerSupportComplianceScreen`
* **Acceptance Criteria**:
- The CustomerSupportComplianceScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Customer Support access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `customer_support_compliance-screen` (Type: layout, Required: 1)
* **page_title** -> `customer_support_compliance-title` (Type: header, Required: 1)
* **primary_content** -> `customer_support_compliance-content` (Type: layout, Required: 1)
* **customersupportcompliance_btn_3** -> `customersupportcompliance-btn-3` (Type: button, Required: 0)
* **customersupportcompliance_title** -> `customersupportcompliance-title` (Type: header, Required: 0)
* **customersupportcompliance_btn_2** -> `customersupportcompliance-btn-2` (Type: button, Required: 0)
* **customersupportcompliance_screen** -> `customersupportcompliance-screen` (Type: layout, Required: 0)
* **customersupportcompliance_btn_1** -> `customersupportcompliance-btn-1` (Type: button, Required: 0)
* **customersupportcompliance_content** -> `customersupportcompliance-content` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `110` (Required: 1)
* Component ID: `644` (Required: 1)
* Component ID: `1178` (Required: 1)
* Component ID: `2493` (Required: 1)
* Component ID: `2494` (Required: 1)
* Component ID: `2495` (Required: 1)
* Component ID: `2496` (Required: 1)
* Component ID: `2497` (Required: 1)
* Component ID: `2498` (Required: 1)
* Component ID: `2499` (Required: 1)
* Component ID: `2500` (Required: 1)

## 7. API / Data Mapping
* API ID: `4379` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `customer_support_compliance_runtime`
* **Test Name**: `CustomerSupportComplianceScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `CustomerSupportComplianceScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `customer_support`)
2. **visit** (Selector: `None`, Value: `/common/customer-support-compliance`)
3. **should_be_visible** (Selector: `customer_support_compliance-screen`, Value: `None`)
4. **should_be_visible** (Selector: `customer_support_compliance-title`, Value: `None`)
5. **should_be_visible** (Selector: `customer_support_compliance-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
