# SCREEN DATA CONTEXT: runtime_verification

Below are the database records from `governance.db` used to configure and build the **Governance Officer - RuntimeVerificationScreen** screen.

---

## 1. Screen Record
* **ID**: `580`
* **App ID**: `10`
* **Role ID**: `36`
* **Screen Code**: `runtime_verification`
* **Screen Name**: `RuntimeVerificationScreen`
* **Route Path**: `/common/runtime-verification`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/common/runtime_verification_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `10`
* **App Code**: `go`
* **App Name**: `Primecare Governance`

## 3. Role Record
* **ID**: `36`
* **Role Code**: `governance`
* **Role Name**: `Governance Officer`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Governance module to enable Governance Officer personnel to oversee, audit, and coordinate operations related to runtimeverificationscreen.`
* **User Story**: `As a Governance Officer, I want to access the RuntimeVerificationScreen within the Primecare Governance application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `RuntimeVerificationScreen`
* **Acceptance Criteria**:
- The RuntimeVerificationScreen route loads successfully within the Primecare Governance workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Governance Officer access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `runtime_verification-screen` (Type: layout, Required: 1)
* **page_title** -> `runtime_verification-title` (Type: header, Required: 1)
* **primary_content** -> `runtime_verification-content` (Type: layout, Required: 1)
* **runtimeverification_btn_1** -> `runtimeverification-btn-1` (Type: button, Required: 0)
* **runtimeverification_btn_3** -> `runtimeverification-btn-3` (Type: button, Required: 0)
* **runtimeverification_title** -> `runtimeverification-title` (Type: header, Required: 0)
* **runtimeverification_screen** -> `runtimeverification-screen` (Type: layout, Required: 0)
* **runtimeverification_content** -> `runtimeverification-content` (Type: layout, Required: 0)
* **runtimeverification_btn_2** -> `runtimeverification-btn-2` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `504` (Required: 1)
* Component ID: `1038` (Required: 1)
* Component ID: `1572` (Required: 1)
* Component ID: `6053` (Required: 1)
* Component ID: `6054` (Required: 1)
* Component ID: `6055` (Required: 1)
* Component ID: `6056` (Required: 1)
* Component ID: `6057` (Required: 1)
* Component ID: `6058` (Required: 1)
* Component ID: `6059` (Required: 1)
* Component ID: `6060` (Required: 1)
* Component ID: `6061` (Required: 1)
* Component ID: `6062` (Required: 1)

## 7. API / Data Mapping
* API ID: `4927` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `runtime_verification_runtime`
* **Test Name**: `RuntimeVerificationScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Runtime Verification`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `governance`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Runtime Verification`)
4. **click_sidebar_link** (Selector: `None`, Value: `Runtime Verification`)
5. **check_url** (Selector: `None`, Value: `/common/runtime-verification`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
