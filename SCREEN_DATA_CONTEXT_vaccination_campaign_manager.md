# SCREEN DATA CONTEXT: vaccination_campaign_manager

Below are the database records from `governance.db` used to configure and build the **Guest - VaccinationCampaignManagerScreen** screen.

---

## 1. Screen Record
* **ID**: `1006`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `vaccination_campaign_manager`
* **Screen Name**: `VaccinationCampaignManagerScreen`
* **Route Path**: `/generated/vaccination-campaign-manager`
* **Actual File Path**: `packages/primecare_ui/lib/src/features/public_health/vaccination_campaign_manager.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to vaccination campaign manager.`
* **User Story**: `As a Guest, I want to access the Vaccination Campaign Manager within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Vaccination Campaign Manager`
* **Acceptance Criteria**:
- The Vaccination Campaign Manager route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `vaccination_campaign_manager-screen` (Type: layout, Required: 1)
* **page_title** -> `vaccination_campaign_manager-title` (Type: header, Required: 1)
* **primary_content** -> `vaccination_campaign_manager-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `8513` (Required: 1)
* Component ID: `8514` (Required: 1)
* Component ID: `8515` (Required: 1)
* Component ID: `8516` (Required: 1)
* Component ID: `8517` (Required: 1)
* Component ID: `8518` (Required: 1)
* Component ID: `8519` (Required: 1)

## 7. API / Data Mapping
* API ID: `5468` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `vaccination_campaign_manager_runtime`
* **Test Name**: `Vaccination Campaign Manager Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Vaccination Campaign Manager`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/generated/vaccination-campaign-manager`)
3. **should_be_visible** (Selector: `vaccination_campaign_manager-screen`, Value: `None`)
4. **should_be_visible** (Selector: `vaccination_campaign_manager-title`, Value: `None`)
5. **should_be_visible** (Selector: `vaccination_campaign_manager-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
