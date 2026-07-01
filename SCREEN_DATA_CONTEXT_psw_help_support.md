# SCREEN DATA CONTEXT: psw_help_support

Below are the database records from `governance.db` used to configure and build the **Guest - PswHelpSupportScreen** screen.

---

## 1. Screen Record
* **ID**: `685`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `psw_help_support`
* **Screen Name**: `PswHelpSupportScreen`
* **Route Path**: `/generated/psw-help-support`
* **Actual File Path**: `apps/primecare_clinic/lib/features/psw/screens/psw_help_support_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `6`
* **App Code**: `ci`
* **App Name**: `Primecare Clinic`

## 3. Role Record
* **ID**: `13`
* **Role Code**: `guest`
* **Role Name**: `Guest`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to psw help support.`
* **User Story**: `As a Guest, I want to access the Psw Help Support within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Psw Help Support`
* **Acceptance Criteria**:
- The Psw Help Support route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `psw_help_support-screen` (Type: layout, Required: 1)
* **page_title** -> `psw_help_support-title` (Type: header, Required: 1)
* **primary_content** -> `psw_help_support-content` (Type: layout, Required: 1)
* **pswhelp_btn_submit_feedback** -> `pswhelp-btn-submit-feedback` (Type: button, Required: 0)
* **pswhelp_btn_access_faqs** -> `pswhelp-btn-access-faqs` (Type: button, Required: 0)
* **pswhelpsupport_content** -> `pswhelpsupport-content` (Type: layout, Required: 0)
* **pswhelp_btn_contact_support** -> `pswhelp-btn-contact-support` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `6763` (Required: 1)
* Component ID: `6764` (Required: 1)
* Component ID: `6765` (Required: 1)
* Component ID: `6766` (Required: 1)
* Component ID: `6767` (Required: 1)

## 7. API / Data Mapping
* API ID: `5049` (Required: 1)
* API ID: `5050` (Required: 1)
* API ID: `5051` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `psw_help_support_runtime`
* **Test Name**: `Psw Help Support Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `PSW Help Support`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `PSW Help Support`)
4. **click_sidebar_link** (Selector: `None`, Value: `PSW Help Support`)
5. **check_url** (Selector: `None`, Value: `/generated/psw-help-support`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
