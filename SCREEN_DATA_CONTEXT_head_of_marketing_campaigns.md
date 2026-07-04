# SCREEN DATA CONTEXT: head_of_marketing_campaigns

Below are the database records from `governance.db` used to configure and build the **Guest - HeadOfMarketingCampaignsScreen** screen.

---

## 1. Screen Record
* **ID**: `849`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `head_of_marketing_campaigns`
* **Screen Name**: `HeadOfMarketingCampaignsScreen`
* **Route Path**: `/generated/head-of-marketing-campaigns`
* **Actual File Path**: `apps/primecare_marketing/lib/features/generated_screens/head_of_marketing_campaigns_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to head of marketing campaigns.`
* **User Story**: `As a Guest, I want to access the Head Of Marketing Campaigns within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Head Of Marketing Campaigns`
* **Acceptance Criteria**:
- The Head Of Marketing Campaigns route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `head_of_marketing_campaigns-screen` (Type: layout, Required: 1)
* **page_title** -> `head_of_marketing_campaigns-title` (Type: header, Required: 1)
* **primary_content** -> `head_of_marketing_campaigns-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `7664` (Required: 1)
* Component ID: `7665` (Required: 1)
* Component ID: `7666` (Required: 1)
* Component ID: `7667` (Required: 1)
* Component ID: `7668` (Required: 1)
* Component ID: `7669` (Required: 1)
* Component ID: `7670` (Required: 1)

## 7. API / Data Mapping
* API ID: `5247` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `head_of_marketing_campaigns_runtime`
* **Test Name**: `Head Of Marketing Campaigns Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Head Of Marketing Campaigns`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/generated/head-of-marketing-campaigns`)
3. **should_be_visible** (Selector: `head_of_marketing_campaigns-screen`, Value: `None`)
4. **should_be_visible** (Selector: `head_of_marketing_campaigns-title`, Value: `None`)
5. **should_be_visible** (Selector: `head_of_marketing_campaigns-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
