# SCREEN DATA CONTEXT: proposals

Below are the database records from `governance.db` used to configure and build the **Guest - ProposalsScreen** screen.

---

## 1. Screen Record
* **ID**: `831`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `proposals`
* **Screen Name**: `ProposalsScreen`
* **Route Path**: `/proposals`
* **Actual File Path**: `apps/primecare_governance/lib/features/executive/screens/proposals_screen.dart`
* **Stage/Status**: `template_created`

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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to proposals.`
* **User Story**: `As a Guest, I want to access the Proposals within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Proposals`
* **Acceptance Criteria**:
- The Proposals route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `proposals-screen` (Type: layout, Required: 1)
* **page_title** -> `proposals-title` (Type: header, Required: 1)
* **primary_content** -> `proposals-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `7562` (Required: 1)
* Component ID: `7563` (Required: 1)
* Component ID: `7564` (Required: 1)
* Component ID: `7565` (Required: 1)
* Component ID: `7566` (Required: 1)
* Component ID: `7567` (Required: 1)
* Component ID: `7568` (Required: 1)

## 7. API / Data Mapping
* API ID: `5228` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `proposals_runtime`
* **Test Name**: `Proposals Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Proposals`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/proposals`)
3. **should_be_visible** (Selector: `proposals-screen`, Value: `None`)
4. **should_be_visible** (Selector: `proposals-title`, Value: `None`)
5. **should_be_visible** (Selector: `proposals-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
