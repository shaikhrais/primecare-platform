# SCREEN DATA CONTEXT: compliance_manager_policies

Below are the database records from `governance.db` used to configure and build the **Guest - ComplianceManagerPoliciesScreen** screen.

---

## 1. Screen Record
* **ID**: `742`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `compliance_manager_policies`
* **Screen Name**: `ComplianceManagerPoliciesScreen`
* **Route Path**: `/generated/compliance-manager-policies`
* **Actual File Path**: `apps/primecare_corporate/lib/features/generated_screens/compliance_manager_policies_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to compliance manager policies.`
* **User Story**: `As a Guest, I want to access the Compliance Manager Policies within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Compliance Manager Policies`
* **Acceptance Criteria**:
- The Compliance Manager Policies route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `compliance_manager_policies-screen` (Type: layout, Required: 1)
* **page_title** -> `compliance_manager_policies-title` (Type: header, Required: 1)
* **primary_content** -> `compliance_manager_policies-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `7072` (Required: 1)
* Component ID: `7073` (Required: 1)
* Component ID: `7074` (Required: 1)
* Component ID: `7075` (Required: 1)
* Component ID: `7076` (Required: 1)
* Component ID: `7077` (Required: 1)

## 7. API / Data Mapping
* API ID: `5126` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `compliance_manager_policies_runtime`
* **Test Name**: `Compliance Manager Policies Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Compliance Manager Policies`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Compliance Manager Policies`)
4. **click_sidebar_link** (Selector: `None`, Value: `Compliance Manager Policies`)
5. **check_url** (Selector: `None`, Value: `/generated/compliance-manager-policies`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
