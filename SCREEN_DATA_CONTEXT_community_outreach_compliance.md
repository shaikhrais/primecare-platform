# SCREEN DATA CONTEXT: community_outreach_compliance

Below are the database records from `governance.db` used to configure and build the **Community Outreach Lead - CommunityOutreachComplianceScreen** screen.

---

## 1. Screen Record
* **ID**: `187`
* **App ID**: `1`
* **Role ID**: `32`
* **Screen Code**: `community_outreach_compliance`
* **Screen Name**: `CommunityOutreachComplianceScreen`
* **Route Path**: `/management/community-outreach-compliance`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/management/community_outreach_compliance_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `32`
* **Role Code**: `community_outreach`
* **Role Name**: `Community Outreach Lead`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Community Outreach Lead personnel to oversee, audit, and coordinate operations related to communityoutreachcompliancescreen.`
* **User Story**: `As a Community Outreach Lead, I want to access the CommunityOutreachComplianceScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `CommunityOutreachComplianceScreen`
* **Acceptance Criteria**:
- The CommunityOutreachComplianceScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Community Outreach Lead access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `community_outreach_compliance-screen` (Type: layout, Required: 1)
* **page_title** -> `community_outreach_compliance-title` (Type: header, Required: 1)
* **primary_content** -> `community_outreach_compliance-content` (Type: layout, Required: 1)
* **communityoutreachcompliance_content** -> `communityoutreachcompliance-content` (Type: layout, Required: 0)
* **communityoutreachcompliance_title** -> `communityoutreachcompliance-title` (Type: header, Required: 0)
* **communityoutreachcompliance_btn_2** -> `communityoutreachcompliance-btn-2` (Type: button, Required: 0)
* **communityoutreachcompliance_screen** -> `communityoutreachcompliance-screen` (Type: layout, Required: 0)
* **communityoutreachcompliance_btn_1** -> `communityoutreachcompliance-btn-1` (Type: button, Required: 0)
* **communityoutreachcompliance_btn_3** -> `communityoutreachcompliance-btn-3` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `195` (Required: 1)
* Component ID: `729` (Required: 1)
* Component ID: `1263` (Required: 1)
* Component ID: `3226` (Required: 1)
* Component ID: `3227` (Required: 1)
* Component ID: `3228` (Required: 1)
* Component ID: `3229` (Required: 1)
* Component ID: `3230` (Required: 1)
* Component ID: `3231` (Required: 1)
* Component ID: `3232` (Required: 1)
* Component ID: `3233` (Required: 1)
* Component ID: `3234` (Required: 1)
* Component ID: `3235` (Required: 1)

## 7. API / Data Mapping
* API ID: `4476` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `community_outreach_compliance_runtime`
* **Test Name**: `CommunityOutreachComplianceScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `CommunityOutreachComplianceScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `community_outreach`)
2. **visit** (Selector: `None`, Value: `/management/community-outreach-compliance`)
3. **should_be_visible** (Selector: `community_outreach_compliance-screen`, Value: `None`)
4. **should_be_visible** (Selector: `community_outreach_compliance-title`, Value: `None`)
5. **should_be_visible** (Selector: `community_outreach_compliance-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
