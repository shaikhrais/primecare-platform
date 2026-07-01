# SCREEN DATA CONTEXT: hr_hiring_staff_documents

Below are the database records from `governance.db` used to configure and build the **Guest - HrHiringStaffDocumentsScreen** screen.

---

## 1. Screen Record
* **ID**: `797`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `hr_hiring_staff_documents`
* **Screen Name**: `HrHiringStaffDocumentsScreen`
* **Route Path**: `/offices/franchise/roles/hr_hiring/staff-documents`
* **Actual File Path**: `apps/primecare_franchise/lib/features/hr_hiring/screens/hr_hiring_staff_documents_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to hr hiring staff documents.`
* **User Story**: `As a Guest, I want to access the Hr Hiring Staff Documents within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Hr Hiring Staff Documents`
* **Acceptance Criteria**:
- The Hr Hiring Staff Documents route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `hr_hiring_staff_documents-screen` (Type: layout, Required: 1)
* **page_title** -> `hr_hiring_staff_documents-title` (Type: header, Required: 1)
* **primary_content** -> `hr_hiring_staff_documents-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `7364` (Required: 1)
* Component ID: `7365` (Required: 1)
* Component ID: `7366` (Required: 1)
* Component ID: `7367` (Required: 1)
* Component ID: `7368` (Required: 1)

## 7. API / Data Mapping
* API ID: `5185` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `hr_hiring_staff_documents_runtime`
* **Test Name**: `Hr Hiring Staff Documents Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `HR Hiring Staff Documents`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `HR Hiring Staff Documents`)
4. **click_sidebar_link** (Selector: `None`, Value: `HR Hiring Staff Documents`)
5. **check_url** (Selector: `None`, Value: `/offices/franchise/roles/hr_hiring/staff-documents`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
