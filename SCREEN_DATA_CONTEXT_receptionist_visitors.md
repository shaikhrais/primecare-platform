# SCREEN DATA CONTEXT: receptionist_visitors

Below are the database records from `governance.db` used to configure and build the **Guest - ReceptionistVisitorsScreen** screen.

---

## 1. Screen Record
* **ID**: `969`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `receptionist_visitors`
* **Screen Name**: `ReceptionistVisitorsScreen`
* **Route Path**: `/generated/receptionist-visitors`
* **Actual File Path**: `packages/primecare_ui/lib/src/features/generated_screens/receptionist_visitors_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to receptionist visitors.`
* **User Story**: `As a Guest, I want to access the Receptionist Visitors within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Receptionist Visitors`
* **Acceptance Criteria**:
- The Receptionist Visitors route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `receptionist_visitors-screen` (Type: layout, Required: 1)
* **page_title** -> `receptionist_visitors-title` (Type: header, Required: 1)
* **primary_content** -> `receptionist_visitors-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `8279` (Required: 1)
* Component ID: `8280` (Required: 1)
* Component ID: `8281` (Required: 1)
* Component ID: `8282` (Required: 1)
* Component ID: `8283` (Required: 1)

## 7. API / Data Mapping
* API ID: `5407` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `receptionist_visitors_runtime`
* **Test Name**: `Receptionist Visitors Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Receptionist Visitors`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/generated/receptionist-visitors`)
3. **should_be_visible** (Selector: `receptionist_visitors-screen`, Value: `None`)
4. **should_be_visible** (Selector: `receptionist_visitors-title`, Value: `None`)
5. **should_be_visible** (Selector: `receptionist_visitors-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
