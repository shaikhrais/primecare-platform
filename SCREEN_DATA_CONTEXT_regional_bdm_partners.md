# SCREEN DATA CONTEXT: regional_bdm_partners

Below are the database records from `governance.db` used to configure and build the **Guest - RegionalBdmPartnersScreen** screen.

---

## 1. Screen Record
* **ID**: `626`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `regional_bdm_partners`
* **Screen Name**: `RegionalBdmPartnersScreen`
* **Route Path**: `/offices/business_development/roles/regional_bdm/partners`
* **Actual File Path**: `apps/primecare_business_development/lib/features/business_development/presentation/widgets/regional_bdm_partners_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to regional bdm partners.`
* **User Story**: `As a Guest, I want to access the Regional Bdm Partners within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Regional Bdm Partners`
* **Acceptance Criteria**:
- The Regional Bdm Partners route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `regional_bdm_partners-screen` (Type: layout, Required: 1)
* **page_title** -> `regional_bdm_partners-title` (Type: header, Required: 1)
* **primary_content** -> `regional_bdm_partners-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `6441` (Required: 1)
* Component ID: `6442` (Required: 1)
* Component ID: `6443` (Required: 1)
* Component ID: `6444` (Required: 1)
* Component ID: `6445` (Required: 1)

## 7. API / Data Mapping
* API ID: `4983` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `regional_bdm_partners_runtime`
* **Test Name**: `Regional Bdm Partners Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Regional Bdm Partners`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/offices/business_development/roles/regional_bdm/partners`)
3. **should_be_visible** (Selector: `regional_bdm_partners-screen`, Value: `None`)
4. **should_be_visible** (Selector: `regional_bdm_partners-title`, Value: `None`)
5. **should_be_visible** (Selector: `regional_bdm_partners-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
