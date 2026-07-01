# SCREEN DATA CONTEXT: regional_bdm_leads

Below are the database records from `governance.db` used to configure and build the **Guest - RegionalBdmLeadsScreen** screen.

---

## 1. Screen Record
* **ID**: `624`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `regional_bdm_leads`
* **Screen Name**: `RegionalBdmLeadsScreen`
* **Route Path**: `/offices/business_development/roles/regional_bdm/leads`
* **Actual File Path**: `apps/primecare_business_development/lib/features/business_development/presentation/widgets/regional_bdm_leads_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to regional bdm leads.`
* **User Story**: `As a Guest, I want to access the Regional Bdm Leads within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Regional Bdm Leads`
* **Acceptance Criteria**:
- The Regional Bdm Leads route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `regional_bdm_leads-screen` (Type: layout, Required: 1)
* **page_title** -> `regional_bdm_leads-title` (Type: header, Required: 1)
* **primary_content** -> `regional_bdm_leads-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `6430` (Required: 1)
* Component ID: `6431` (Required: 1)
* Component ID: `6432` (Required: 1)
* Component ID: `6433` (Required: 1)
* Component ID: `6434` (Required: 1)

## 7. API / Data Mapping
* API ID: `4981` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `regional_bdm_leads_runtime`
* **Test Name**: `Regional Bdm Leads Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Regional BDM Leads`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Regional BDM Leads`)
4. **click_sidebar_link** (Selector: `None`, Value: `Regional BDM Leads`)
5. **check_url** (Selector: `None`, Value: `/offices/business_development/roles/regional_bdm/leads`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
