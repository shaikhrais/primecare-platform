# SCREEN DATA CONTEXT: system_verification_compliance

Below are the database records from `governance.db` used to configure and build the **System Verification Officer - SystemVerificationComplianceScreen** screen.

---

## 1. Screen Record
* **ID**: `147`
* **App ID**: `1`
* **Role ID**: `18`
* **Screen Code**: `system_verification_compliance`
* **Screen Name**: `SystemVerificationComplianceScreen`
* **Route Path**: `/common/system-verification-compliance`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/common/system_verification_compliance_screen.dart`
* **Stage/Status**: `wired`

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
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable System Verification Officer personnel to oversee, audit, and coordinate operations related to systemverificationcompliancescreen.`
* **User Story**: `As a System Verification Officer, I want to access the SystemVerificationComplianceScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `SystemVerificationComplianceScreen`
* **Acceptance Criteria**:
- The SystemVerificationComplianceScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only System Verification Officer access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `system_verification_compliance-screen` (Type: layout, Required: 1)
* **page_title** -> `system_verification_compliance-title` (Type: header, Required: 1)
* **primary_content** -> `system_verification_compliance-content` (Type: layout, Required: 1)
* **systemverificationcompliance_screen** -> `systemverificationcompliance-screen` (Type: layout, Required: 0)
* **systemverificationcompliance_btn_3** -> `systemverificationcompliance-btn-3` (Type: button, Required: 0)
* **systemverificationcompliance_btn_1** -> `systemverificationcompliance-btn-1` (Type: button, Required: 0)
* **systemverificationcompliance_content** -> `systemverificationcompliance-content` (Type: layout, Required: 0)
* **systemverificationcompliance_title** -> `systemverificationcompliance-title` (Type: header, Required: 0)
* **systemverificationcompliance_btn_2** -> `systemverificationcompliance-btn-2` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `155` (Required: 1)
* Component ID: `689` (Required: 1)
* Component ID: `1223` (Required: 1)
* Component ID: `2862` (Required: 1)
* Component ID: `2863` (Required: 1)
* Component ID: `2864` (Required: 1)
* Component ID: `2865` (Required: 1)
* Component ID: `2866` (Required: 1)
* Component ID: `2867` (Required: 1)
* Component ID: `2868` (Required: 1)
* Component ID: `2869` (Required: 1)

## 7. API / Data Mapping
* API ID: `4430` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `system_verification_compliance_runtime`
* **Test Name**: `SystemVerificationComplianceScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `System Verification Compliance`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `system_verification`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `System Verification Compliance`)
4. **click_sidebar_link** (Selector: `None`, Value: `System Verification Compliance`)
5. **check_url** (Selector: `None`, Value: `/common/system-verification-compliance`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
