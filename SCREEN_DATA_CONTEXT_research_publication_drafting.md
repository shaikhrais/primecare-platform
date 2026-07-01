# SCREEN DATA CONTEXT: research_publication_drafting

Below are the database records from `governance.db` used to configure and build the **Guest - ResearchPublicationDraftingScreen** screen.

---

## 1. Screen Record
* **ID**: `1016`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `research_publication_drafting`
* **Screen Name**: `ResearchPublicationDraftingScreen`
* **Route Path**: `/generated/research-publication-drafting`
* **Actual File Path**: `packages/primecare_ui/lib/src/features/research/research_publication_drafting.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to research publication drafting.`
* **User Story**: `As a Guest, I want to access the Research Publication Drafting within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Research Publication Drafting`
* **Acceptance Criteria**:
- The Research Publication Drafting route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `research_publication_drafting-screen` (Type: layout, Required: 1)
* **page_title** -> `research_publication_drafting-title` (Type: header, Required: 1)
* **primary_content** -> `research_publication_drafting-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `8576` (Required: 1)
* Component ID: `8577` (Required: 1)
* Component ID: `8578` (Required: 1)
* Component ID: `8579` (Required: 1)
* Component ID: `8580` (Required: 1)
* Component ID: `8581` (Required: 1)
* Component ID: `8582` (Required: 1)

## 7. API / Data Mapping
* API ID: `5482` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `research_publication_drafting_runtime`
* **Test Name**: `Research Publication Drafting Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Research Publication Drafting`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Research Publication Drafting`)
4. **click_sidebar_link** (Selector: `None`, Value: `Research Publication Drafting`)
5. **check_url** (Selector: `None`, Value: `/generated/research-publication-drafting`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
