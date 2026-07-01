# SCREEN DATA CONTEXT: partnership_manager_proposals

Below are the database records from `governance.db` used to configure and build the **Guest - PartnershipManagerProposalsScreen** screen.

---

## 1. Screen Record
* **ID**: `641`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `partnership_manager_proposals`
* **Screen Name**: `PartnershipManagerProposalsScreen`
* **Route Path**: `/offices/business_development/roles/partnership_manager/proposals`
* **Actual File Path**: `apps/primecare_business_development/lib/features/partnership/screens/partnership_manager_proposals_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to partnership manager proposals.`
* **User Story**: `As a Guest, I want to access the Partnership Manager Proposals within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Partnership Manager Proposals`
* **Acceptance Criteria**:
- The Partnership Manager Proposals route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `partnership_manager_proposals-screen` (Type: layout, Required: 1)
* **page_title** -> `partnership_manager_proposals-title` (Type: header, Required: 1)
* **primary_content** -> `partnership_manager_proposals-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `6532` (Required: 1)
* Component ID: `6533` (Required: 1)
* Component ID: `6534` (Required: 1)
* Component ID: `6535` (Required: 1)
* Component ID: `6536` (Required: 1)

## 7. API / Data Mapping
* API ID: `4998` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `partnership_manager_proposals_runtime`
* **Test Name**: `Partnership Manager Proposals Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Partnership Manager Proposals`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Partnership Manager Proposals`)
4. **click_sidebar_link** (Selector: `None`, Value: `Partnership Manager Proposals`)
5. **check_url** (Selector: `None`, Value: `/offices/business_development/roles/partnership_manager/proposals`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
