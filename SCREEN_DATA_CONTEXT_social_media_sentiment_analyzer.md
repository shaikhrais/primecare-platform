# SCREEN DATA CONTEXT: social_media_sentiment_analyzer

Below are the database records from `governance.db` used to configure and build the **Guest - SocialMediaSentimentAnalyzerScreen** screen.

---

## 1. Screen Record
* **ID**: `980`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `social_media_sentiment_analyzer`
* **Screen Name**: `SocialMediaSentimentAnalyzerScreen`
* **Route Path**: `/generated/social-media-sentiment-analyzer`
* **Actual File Path**: `packages/primecare_ui/lib/src/features/marketing/social_media_sentiment_analyzer.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to social media sentiment analyzer.`
* **User Story**: `As a Guest, I want to access the Social Media Sentiment Analyzer within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Social Media Sentiment Analyzer`
* **Acceptance Criteria**:
- The Social Media Sentiment Analyzer route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `social_media_sentiment_analyzer-screen` (Type: layout, Required: 1)
* **page_title** -> `social_media_sentiment_analyzer-title` (Type: header, Required: 1)
* **primary_content** -> `social_media_sentiment_analyzer-content` (Type: layout, Required: 1)
* **social_media_sentiment_analyzer_iconbutton_button_1** -> `social_media_sentiment_analyzer_iconbutton_button_1` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `8341` (Required: 1)
* Component ID: `8342` (Required: 1)
* Component ID: `8343` (Required: 1)
* Component ID: `8344` (Required: 1)

## 7. API / Data Mapping
* API ID: `5420` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `social_media_sentiment_analyzer_runtime`
* **Test Name**: `Social Media Sentiment Analyzer Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Social Media Sentiment Analyzer`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Social Media Sentiment Analyzer`)
4. **click_sidebar_link** (Selector: `None`, Value: `Social Media Sentiment Analyzer`)
5. **check_url** (Selector: `None`, Value: `/generated/social-media-sentiment-analyzer`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
