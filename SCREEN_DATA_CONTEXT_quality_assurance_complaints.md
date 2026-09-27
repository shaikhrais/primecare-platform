# SCREEN DATA CONTEXT: quality_assurance_complaints

Below are the database records from `governance.db` used to configure and build the **Guest - QualityAssuranceComplaintsScreen** screen.

---

## 1. Screen Record
* **ID**: `881`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `quality_assurance_complaints`
* **Screen Name**: `QualityAssuranceComplaintsScreen`
* **Route Path**: `/generated/quality-assurance-complaints`
* **Actual File Path**: `apps/primecare_support/lib/features/generated_screens/quality_assurance_complaints_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to quality assurance complaints.`
* **User Story**: `As a Guest, I want to access the Quality Assurance Complaints within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Quality Assurance Complaints`
* **Acceptance Criteria**:
- The Quality Assurance Complaints route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `quality_assurance_complaints-screen` (Type: layout, Required: 1)
* **page_title** -> `quality_assurance_complaints-title` (Type: header, Required: 1)
* **primary_content** -> `quality_assurance_complaints-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `7850` (Required: 1)
* Component ID: `7851` (Required: 1)
* Component ID: `7852` (Required: 1)
* Component ID: `7853` (Required: 1)
* Component ID: `7854` (Required: 1)
* Component ID: `7855` (Required: 1)

## 7. API / Data Mapping
* API ID: `5295` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `quality_assurance_complaints_runtime`
* **Test Name**: `Quality Assurance Complaints Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Quality Assurance Complaints`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/generated/quality-assurance-complaints`)
3. **should_be_visible** (Selector: `quality_assurance_complaints-screen`, Value: `None`)
4. **should_be_visible** (Selector: `quality_assurance_complaints-title`, Value: `None`)
5. **should_be_visible** (Selector: `quality_assurance_complaints-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
