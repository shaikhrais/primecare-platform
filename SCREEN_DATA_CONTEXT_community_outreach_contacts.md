# SCREEN DATA CONTEXT: community_outreach_contacts

Below are the database records from `governance.db` used to configure and build the **Guest - CommunityOutreachContactsScreen** screen.

---

## 1. Screen Record
* **ID**: `841`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `community_outreach_contacts`
* **Screen Name**: `CommunityOutreachContactsScreen`
* **Route Path**: `/generated/community-outreach-contacts`
* **Actual File Path**: `apps/primecare_marketing/lib/features/generated_screens/community_outreach_contacts_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to community outreach contacts.`
* **User Story**: `As a Guest, I want to access the Community Outreach Contacts within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Community Outreach Contacts`
* **Acceptance Criteria**:
- The Community Outreach Contacts route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `community_outreach_contacts-screen` (Type: layout, Required: 1)
* **page_title** -> `community_outreach_contacts-title` (Type: header, Required: 1)
* **primary_content** -> `community_outreach_contacts-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `7621` (Required: 1)
* Component ID: `7622` (Required: 1)
* Component ID: `7623` (Required: 1)
* Component ID: `7624` (Required: 1)
* Component ID: `7625` (Required: 1)
* Component ID: `7626` (Required: 1)

## 7. API / Data Mapping
* API ID: `5239` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `community_outreach_contacts_runtime`
* **Test Name**: `Community Outreach Contacts Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Community Outreach Contacts`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/generated/community-outreach-contacts`)
3. **should_be_visible** (Selector: `community_outreach_contacts-screen`, Value: `None`)
4. **should_be_visible** (Selector: `community_outreach_contacts-title`, Value: `None`)
5. **should_be_visible** (Selector: `community_outreach_contacts-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
