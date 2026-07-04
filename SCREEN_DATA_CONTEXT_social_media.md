# SCREEN DATA CONTEXT: social_media

Below are the database records from `governance.db` used to configure and build the **Head of Marketing - SocialMediaScreen** screen.

---

## 1. Screen Record
* **ID**: `501`
* **App ID**: `11`
* **Role ID**: `38`
* **Screen Code**: `social_media`
* **Screen Name**: `SocialMediaScreen`
* **Route Path**: `/management/social-media`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/management/social_media_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `11`
* **App Code**: `ma`
* **App Name**: `Primecare Marketing`

## 3. Role Record
* **ID**: `38`
* **Role Code**: `marketing`
* **Role Name**: `Head of Marketing`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Marketing module to enable Head of Marketing personnel to oversee, audit, and coordinate operations related to socialmediascreen.`
* **User Story**: `As a Head of Marketing, I want to access the SocialMediaScreen within the Primecare Marketing application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `SocialMediaScreen`
* **Acceptance Criteria**:
- The SocialMediaScreen route loads successfully within the Primecare Marketing workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Head of Marketing access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `social_media-screen` (Type: layout, Required: 1)
* **page_title** -> `social_media-title` (Type: header, Required: 1)
* **primary_content** -> `social_media-content` (Type: layout, Required: 1)
* **socialmedia_btn_2** -> `socialmedia-btn-2` (Type: button, Required: 0)
* **socialmedia_btn_1** -> `socialmedia-btn-1` (Type: button, Required: 0)
* **socialmedia_title** -> `socialmedia-title` (Type: header, Required: 0)
* **socialmedia_screen** -> `socialmedia-screen` (Type: layout, Required: 0)
* **socialmedia_loading** -> `socialmedia-loading` (Type: loading, Required: 0)
* **socialmedia_btn_3** -> `socialmedia-btn-3` (Type: button, Required: 0)
* **socialmedia_content** -> `socialmedia-content` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `430` (Required: 1)
* Component ID: `964` (Required: 1)
* Component ID: `1498` (Required: 1)
* Component ID: `5391` (Required: 1)
* Component ID: `5392` (Required: 1)
* Component ID: `5393` (Required: 1)
* Component ID: `5394` (Required: 1)
* Component ID: `5395` (Required: 1)
* Component ID: `5396` (Required: 1)
* Component ID: `5397` (Required: 1)
* Component ID: `5398` (Required: 1)
* Component ID: `5399` (Required: 1)
* Component ID: `5400` (Required: 1)

## 7. API / Data Mapping
* API ID: `4818` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `social_media_runtime`
* **Test Name**: `SocialMediaScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `SocialMediaScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `marketing`)
2. **visit** (Selector: `None`, Value: `/management/social-media`)
3. **should_be_visible** (Selector: `social_media-screen`, Value: `None`)
4. **should_be_visible** (Selector: `social_media-title`, Value: `None`)
5. **should_be_visible** (Selector: `social_media-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
