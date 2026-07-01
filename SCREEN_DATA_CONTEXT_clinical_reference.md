# SCREEN DATA CONTEXT: clinical_reference

Below are the database records from `governance.db` used to configure and build the **Guest - ClinicalReferenceScreen** screen.

---

## 1. Screen Record
* **ID**: `837`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `clinical_reference`
* **Screen Name**: `ClinicalReferenceScreen`
* **Route Path**: `/governance/clinical-reference`
* **Actual File Path**: `apps/primecare_governance/lib/features/reference/screens/clinical_reference_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to clinical reference.`
* **User Story**: `As a Guest, I want to access the Clinical Reference within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Clinical Reference`
* **Acceptance Criteria**:
- The Clinical Reference route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `clinical_reference-screen` (Type: layout, Required: 1)
* **page_title** -> `clinical_reference-title` (Type: header, Required: 1)
* **primary_content** -> `clinical_reference-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `7597` (Required: 1)
* Component ID: `7598` (Required: 1)
* Component ID: `7599` (Required: 1)
* Component ID: `7600` (Required: 1)
* Component ID: `7601` (Required: 1)
* Component ID: `7602` (Required: 1)

## 7. API / Data Mapping
* API ID: `5235` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `clinical_reference_runtime`
* **Test Name**: `Clinical Reference Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Clinical Reference`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Clinical Reference`)
4. **click_sidebar_link** (Selector: `None`, Value: `Clinical Reference`)
5. **check_url** (Selector: `None`, Value: `/governance/clinical-reference`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
