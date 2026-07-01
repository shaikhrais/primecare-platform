# SCREEN DATA CONTEXT: head_of_marketing_leads

Below are the database records from `governance.db` used to configure and build the **Guest - HeadOfMarketingLeadsScreen** screen.

---

## 1. Screen Record
* **ID**: `852`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `head_of_marketing_leads`
* **Screen Name**: `HeadOfMarketingLeadsScreen`
* **Route Path**: `/generated/head-of-marketing-leads`
* **Actual File Path**: `apps/primecare_marketing/lib/features/generated_screens/head_of_marketing_leads_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to head of marketing leads.`
* **User Story**: `As a Guest, I want to access the Head Of Marketing Leads within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Head Of Marketing Leads`
* **Acceptance Criteria**:
- The Head Of Marketing Leads route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `head_of_marketing_leads-screen` (Type: layout, Required: 1)
* **page_title** -> `head_of_marketing_leads-title` (Type: header, Required: 1)
* **primary_content** -> `head_of_marketing_leads-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `7685` (Required: 1)
* Component ID: `7686` (Required: 1)
* Component ID: `7687` (Required: 1)
* Component ID: `7688` (Required: 1)
* Component ID: `7689` (Required: 1)
* Component ID: `7690` (Required: 1)

## 7. API / Data Mapping
* API ID: `5250` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `head_of_marketing_leads_runtime`
* **Test Name**: `Head Of Marketing Leads Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Head Of Marketing Leads`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Head Of Marketing Leads`)
4. **click_sidebar_link** (Selector: `None`, Value: `Head Of Marketing Leads`)
5. **check_url** (Selector: `None`, Value: `/generated/head-of-marketing-leads`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
