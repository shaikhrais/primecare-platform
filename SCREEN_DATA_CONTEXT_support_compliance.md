# SCREEN DATA CONTEXT: support_compliance

Below are the database records from `governance.db` used to configure and build the **Customer Support - SupportComplianceScreen** screen.

---

## 1. Screen Record
* **ID**: `142`
* **App ID**: `1`
* **Role ID**: `61`
* **Screen Code**: `support_compliance`
* **Screen Name**: `SupportComplianceScreen`
* **Route Path**: `/common/support-compliance`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/common/support_compliance_screen.dart`
* **Stage/Status**: `wired`

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
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Customer Support personnel to oversee, audit, and coordinate operations related to supportcompliancescreen.`
* **User Story**: `As a Customer Support, I want to access the SupportComplianceScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `SupportComplianceScreen`
* **Acceptance Criteria**:
- The SupportComplianceScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Customer Support access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `support_compliance-screen` (Type: layout, Required: 1)
* **page_title** -> `support_compliance-title` (Type: header, Required: 1)
* **primary_content** -> `support_compliance-content` (Type: layout, Required: 1)
* **supportcompliance_btn_2** -> `supportcompliance-btn-2` (Type: button, Required: 0)
* **supportcompliance_content** -> `supportcompliance-content` (Type: layout, Required: 0)
* **supportcompliance_title** -> `supportcompliance-title` (Type: header, Required: 0)
* **supportcompliance_screen** -> `supportcompliance-screen` (Type: layout, Required: 0)
* **supportcompliance_btn_3** -> `supportcompliance-btn-3` (Type: button, Required: 0)
* **supportcompliance_loading** -> `supportcompliance-loading` (Type: loading, Required: 0)
* **supportcompliance_btn_1** -> `supportcompliance-btn-1` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `150` (Required: 1)
* Component ID: `684` (Required: 1)
* Component ID: `1218` (Required: 1)
* Component ID: `2814` (Required: 1)
* Component ID: `2815` (Required: 1)
* Component ID: `2816` (Required: 1)
* Component ID: `2817` (Required: 1)
* Component ID: `2818` (Required: 1)
* Component ID: `2819` (Required: 1)
* Component ID: `2820` (Required: 1)
* Component ID: `2821` (Required: 1)
* Component ID: `2822` (Required: 1)
* Component ID: `2823` (Required: 1)

## 7. API / Data Mapping
* API ID: `4425` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `support_compliance_runtime`
* **Test Name**: `SupportComplianceScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Support Compliance`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `customer_support`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Support Compliance`)
4. **click_sidebar_link** (Selector: `None`, Value: `Support Compliance`)
5. **check_url** (Selector: `None`, Value: `/common/support-compliance`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
