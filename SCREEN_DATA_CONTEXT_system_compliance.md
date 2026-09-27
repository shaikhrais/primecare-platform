# SCREEN DATA CONTEXT: system_compliance

Below are the database records from `governance.db` used to configure and build the **System Verification Officer - SystemComplianceScreen** screen.

---

## 1. Screen Record
* **ID**: `145`
* **App ID**: `1`
* **Role ID**: `18`
* **Screen Code**: `system_compliance`
* **Screen Name**: `SystemComplianceScreen`
* **Route Path**: `/common/system-compliance`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/common/system_compliance_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `18`
* **Role Code**: `system_verification`
* **Role Name**: `System Verification Officer`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable System Verification Officer personnel to oversee, audit, and coordinate operations related to systemcompliancescreen.`
* **User Story**: `As a System Verification Officer, I want to access the SystemComplianceScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `SystemComplianceScreen`
* **Acceptance Criteria**:
- The SystemComplianceScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only System Verification Officer access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `system_compliance-screen` (Type: layout, Required: 1)
* **page_title** -> `system_compliance-title` (Type: header, Required: 1)
* **primary_content** -> `system_compliance-content` (Type: layout, Required: 1)
* **systemcompliance_btn_3** -> `systemcompliance-btn-3` (Type: button, Required: 0)
* **systemcompliance_loading** -> `systemcompliance-loading` (Type: loading, Required: 0)
* **systemcompliance_btn_1** -> `systemcompliance-btn-1` (Type: button, Required: 0)
* **systemcompliance_title** -> `systemcompliance-title` (Type: header, Required: 0)
* **systemcompliance_content** -> `systemcompliance-content` (Type: layout, Required: 0)
* **systemcompliance_btn_2** -> `systemcompliance-btn-2` (Type: button, Required: 0)
* **systemcompliance_screen** -> `systemcompliance-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `153` (Required: 1)
* Component ID: `687` (Required: 1)
* Component ID: `1221` (Required: 1)
* Component ID: `2844` (Required: 1)
* Component ID: `2845` (Required: 1)
* Component ID: `2846` (Required: 1)
* Component ID: `2847` (Required: 1)
* Component ID: `2848` (Required: 1)
* Component ID: `2849` (Required: 1)
* Component ID: `2850` (Required: 1)
* Component ID: `2851` (Required: 1)
* Component ID: `2852` (Required: 1)
* Component ID: `2853` (Required: 1)

## 7. API / Data Mapping
* API ID: `4428` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `system_compliance_runtime`
* **Test Name**: `SystemComplianceScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `SystemComplianceScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `system_verification`)
2. **visit** (Selector: `None`, Value: `/common/system-compliance`)
3. **should_be_visible** (Selector: `system_compliance-screen`, Value: `None`)
4. **should_be_visible** (Selector: `system_compliance-title`, Value: `None`)
5. **should_be_visible** (Selector: `system_compliance-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
