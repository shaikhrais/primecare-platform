# SCREEN DATA CONTEXT: psw_compliance

Below are the database records from `governance.db` used to configure and build the **Personal Support Worker (PSW) - PswComplianceScreen** screen.

---

## 1. Screen Record
* **ID**: `233`
* **App ID**: `1`
* **Role ID**: `51`
* **Screen Code**: `psw_compliance`
* **Screen Name**: `PswComplianceScreen`
* **Route Path**: `/offices/clinical/roles/psw/help-support`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/psw/psw_compliance_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `51`
* **Role Code**: `psw`
* **Role Name**: `Personal Support Worker (PSW)`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Personal Support Worker (PSW) personnel to oversee, audit, and coordinate operations related to pswcompliancescreen.`
* **User Story**: `As a Personal Support Worker (PSW), I want to access the PswComplianceScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `PswComplianceScreen`
* **Acceptance Criteria**:
- The PswComplianceScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Personal Support Worker (PSW) access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `psw_compliance-screen` (Type: layout, Required: 1)
* **page_title** -> `psw_compliance-title` (Type: header, Required: 1)
* **primary_content** -> `psw_compliance-content` (Type: layout, Required: 1)
* **pswcompliance_btn_3** -> `pswcompliance-btn-3` (Type: button, Required: 0)
* **pswcompliance_content** -> `pswcompliance-content` (Type: layout, Required: 0)
* **pswcompliance_loading** -> `pswcompliance-loading` (Type: loading, Required: 0)
* **pswcompliance_btn_1** -> `pswcompliance-btn-1` (Type: button, Required: 0)
* **pswcompliance_title** -> `pswcompliance-title` (Type: header, Required: 0)
* **pswcompliance_btn_2** -> `pswcompliance-btn-2` (Type: button, Required: 0)
* **pswcompliance_screen** -> `pswcompliance-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `241` (Required: 1)
* Component ID: `775` (Required: 1)
* Component ID: `1309` (Required: 1)
* Component ID: `3662` (Required: 1)
* Component ID: `3663` (Required: 1)
* Component ID: `3664` (Required: 1)
* Component ID: `3665` (Required: 1)
* Component ID: `3666` (Required: 1)
* Component ID: `3667` (Required: 1)
* Component ID: `3668` (Required: 1)
* Component ID: `3669` (Required: 1)
* Component ID: `3670` (Required: 1)
* Component ID: `3671` (Required: 1)

## 7. API / Data Mapping
* API ID: `4526` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `psw_compliance_runtime`
* **Test Name**: `PswComplianceScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `PSW Compliance`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `psw`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `PSW Compliance`)
4. **click_sidebar_link** (Selector: `None`, Value: `PSW Compliance`)
5. **check_url** (Selector: `None`, Value: `/offices/clinical/roles/psw/help-support`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
