# SCREEN DATA CONTEXT: outreach_campaign

Below are the database records from `governance.db` used to configure and build the **Head of Business Development - OutreachCampaignScreen** screen.

---

## 1. Screen Record
* **ID**: `498`
* **App ID**: `4`
* **Role ID**: `37`
* **Screen Code**: `outreach_campaign`
* **Screen Name**: `OutreachCampaignScreen`
* **Route Path**: `/management/outreach-campaign`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/management/outreach_campaign_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `4`
* **App Code**: `bd`
* **App Name**: `Primecare Business Development`

## 3. Role Record
* **ID**: `37`
* **Role Code**: `bus_dev`
* **Role Name**: `Head of Business Development`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Business Development module to enable Head of Business Development personnel to oversee, audit, and coordinate operations related to outreachcampaignscreen.`
* **User Story**: `As a Head of Business Development, I want to access the OutreachCampaignScreen within the Primecare Business Development application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `OutreachCampaignScreen`
* **Acceptance Criteria**:
- The OutreachCampaignScreen route loads successfully within the Primecare Business Development workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Head of Business Development access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `outreach_campaign-screen` (Type: layout, Required: 1)
* **page_title** -> `outreach_campaign-title` (Type: header, Required: 1)
* **primary_content** -> `outreach_campaign-content` (Type: layout, Required: 1)
* **outreachcampaign_btn_3** -> `outreachcampaign-btn-3` (Type: button, Required: 0)
* **outreachcampaign_btn_1** -> `outreachcampaign-btn-1` (Type: button, Required: 0)
* **outreachcampaign_title** -> `outreachcampaign-title` (Type: header, Required: 0)
* **outreachcampaign_content** -> `outreachcampaign-content` (Type: layout, Required: 0)
* **outreachcampaign_screen** -> `outreachcampaign-screen` (Type: layout, Required: 0)
* **outreachcampaign_btn_2** -> `outreachcampaign-btn-2` (Type: button, Required: 0)
* **outreachcampaign_loading** -> `outreachcampaign-loading` (Type: loading, Required: 0)

## 6. Component Mapping
* Component ID: `427` (Required: 1)
* Component ID: `961` (Required: 1)
* Component ID: `1495` (Required: 1)
* Component ID: `5363` (Required: 1)
* Component ID: `5364` (Required: 1)
* Component ID: `5365` (Required: 1)
* Component ID: `5366` (Required: 1)
* Component ID: `5367` (Required: 1)
* Component ID: `5368` (Required: 1)
* Component ID: `5369` (Required: 1)
* Component ID: `5370` (Required: 1)
* Component ID: `5371` (Required: 1)
* Component ID: `5372` (Required: 1)

## 7. API / Data Mapping
* API ID: `4815` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `outreach_campaign_runtime`
* **Test Name**: `OutreachCampaignScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `OutreachCampaignScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `bus_dev`)
2. **visit** (Selector: `None`, Value: `/management/outreach-campaign`)
3. **should_be_visible** (Selector: `outreach_campaign-screen`, Value: `None`)
4. **should_be_visible** (Selector: `outreach_campaign-title`, Value: `None`)
5. **should_be_visible** (Selector: `outreach_campaign-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
