# SCREEN DATA CONTEXT: certifications

Below are the database records from `governance.db` used to configure and build the **Guest - CertificationsScreen** screen.

---

## 1. Screen Record
* **ID**: `774`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `certifications`
* **Screen Name**: `CertificationsScreen`
* **Route Path**: `/generated/certifications`
* **Actual File Path**: `apps/primecare_corporate/lib/features/training/screens/certifications_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to certifications.`
* **User Story**: `As a Guest, I want to access the Certifications within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Certifications`
* **Acceptance Criteria**:
- The Certifications route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `certifications-screen` (Type: layout, Required: 1)
* **page_title** -> `certifications-title` (Type: header, Required: 1)
* **primary_content** -> `certifications-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `7247` (Required: 1)
* Component ID: `7248` (Required: 1)
* Component ID: `7249` (Required: 1)
* Component ID: `7250` (Required: 1)
* Component ID: `7251` (Required: 1)

## 7. API / Data Mapping
* API ID: `5164` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `certifications_runtime`
* **Test Name**: `Certifications Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Certifications`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Certifications`)
4. **click_sidebar_link** (Selector: `None`, Value: `Certifications`)
5. **check_url** (Selector: `None`, Value: `/generated/certifications`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
