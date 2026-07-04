# SCREEN DATA CONTEXT: head_of_marketing_compliance

Below are the database records from `governance.db` used to configure and build the **Head of Marketing - HeadOfMarketingComplianceScreen** screen.

---

## 1. Screen Record
* **ID**: `205`
* **App ID**: `1`
* **Role ID**: `38`
* **Screen Code**: `head_of_marketing_compliance`
* **Screen Name**: `HeadOfMarketingComplianceScreen`
* **Route Path**: `/management/head-of-marketing-compliance`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/management/head_of_marketing_compliance_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `38`
* **Role Code**: `marketing`
* **Role Name**: `Head of Marketing`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Head of Marketing personnel to oversee, audit, and coordinate operations related to headofmarketingcompliancescreen.`
* **User Story**: `As a Head of Marketing, I want to access the HeadOfMarketingComplianceScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `HeadOfMarketingComplianceScreen`
* **Acceptance Criteria**:
- The HeadOfMarketingComplianceScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Head of Marketing access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `head_of_marketing_compliance-screen` (Type: layout, Required: 1)
* **page_title** -> `head_of_marketing_compliance-title` (Type: header, Required: 1)
* **primary_content** -> `head_of_marketing_compliance-content` (Type: layout, Required: 1)
* **headofmarketingcompliance_content** -> `headofmarketingcompliance-content` (Type: layout, Required: 0)
* **headofmarketingcompliance_title** -> `headofmarketingcompliance-title` (Type: header, Required: 0)
* **headofmarketingcompliance_btn_2** -> `headofmarketingcompliance-btn-2` (Type: button, Required: 0)
* **headofmarketingcompliance_btn_3** -> `headofmarketingcompliance-btn-3` (Type: button, Required: 0)
* **headofmarketingcompliance_screen** -> `headofmarketingcompliance-screen` (Type: layout, Required: 0)
* **headofmarketingcompliance_btn_1** -> `headofmarketingcompliance-btn-1` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `213` (Required: 1)
* Component ID: `747` (Required: 1)
* Component ID: `1281` (Required: 1)
* Component ID: `3403` (Required: 1)
* Component ID: `3404` (Required: 1)
* Component ID: `3405` (Required: 1)
* Component ID: `3406` (Required: 1)
* Component ID: `3407` (Required: 1)
* Component ID: `3408` (Required: 1)
* Component ID: `3409` (Required: 1)
* Component ID: `3410` (Required: 1)
* Component ID: `3411` (Required: 1)
* Component ID: `3412` (Required: 1)

## 7. API / Data Mapping
* API ID: `4494` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `head_of_marketing_compliance_runtime`
* **Test Name**: `HeadOfMarketingComplianceScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `HeadOfMarketingComplianceScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `marketing`)
2. **visit** (Selector: `None`, Value: `/management/head-of-marketing-compliance`)
3. **should_be_visible** (Selector: `head_of_marketing_compliance-screen`, Value: `None`)
4. **should_be_visible** (Selector: `head_of_marketing_compliance-title`, Value: `None`)
5. **should_be_visible** (Selector: `head_of_marketing_compliance-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
