// AUTO-GENERATED APP E2E SPEC. SYSTEMATICALLY GENERATED.
// Tests all allowed roles and their respective screens on the portal.
// Leverages reusable SSO commands and custom Semantics selector lookups.

describe("App All Roles All Screens - Primecare Marketing", () => {

  it("verifies operation flow for role: MARKETING", () => {
    cy.loginAsRole("marketing");

    // [1/5] - Screen: BrandManagementScreen (brand_management)
    cy.task("log", "PROGRESS: Visiting /management/brand-management (BrandManagementScreen)...");
    cy.visitWithSemantics("/management/brand-management");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("brandmanagement-screen").should("be.visible");
    cy.getCy("brandmanagement-title").should("be.visible");
    cy.getCy("brandmanagement-content").should("be.visible");
    cy.screenshot("ma_marketing_brand_management");

    // [2/5] - Screen: CampaignDashboardScreen (campaign_dashboard)
    cy.task("log", "PROGRESS: Visiting /management/campaign-dashboard (CampaignDashboardScreen)...");
    cy.visitWithSemantics("/management/campaign-dashboard");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("campaigndashboard-screen").should("be.visible");
    cy.getCy("campaigndashboard-title").should("be.visible");
    cy.getCy("campaigndashboard-content").should("be.visible");
    cy.screenshot("ma_marketing_campaign_dashboard");

    // [3/5] - Screen: HeadOfMarketingDashboardScreen (head_of_marketing_dashboard)
    cy.task("log", "PROGRESS: Visiting /management/head-of-marketing-dashboard (HeadOfMarketingDashboardScreen)...");
    cy.visitWithSemantics("/management/head-of-marketing-dashboard");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("headofmarketingdashboard-screen").should("be.visible");
    cy.getCy("headofmarketingdashboard-title").should("be.visible");
    cy.getCy("headofmarketingdashboard-content").should("be.visible");
    cy.screenshot("ma_marketing_head_of_marketing_dashboard");

    // [4/5] - Screen: LeadAnalyticsScreen (lead_analytics)
    cy.task("log", "PROGRESS: Visiting /management/lead-analytics (LeadAnalyticsScreen)...");
    cy.visitWithSemantics("/management/lead-analytics");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("leadanalytics-screen").should("be.visible");
    cy.getCy("leadanalytics-title").should("be.visible");
    cy.getCy("leadanalytics-content").should("be.visible");
    cy.screenshot("ma_marketing_lead_analytics");

    // [5/5] - Screen: SocialMediaScreen (social_media)
    cy.task("log", "PROGRESS: Visiting /management/social-media (SocialMediaScreen)...");
    cy.visitWithSemantics("/management/social-media");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("socialmedia-screen").should("be.visible");
    cy.getCy("socialmedia-title").should("be.visible");
    cy.getCy("socialmedia-content").should("be.visible");
    cy.screenshot("ma_marketing_social_media");
  });

  it("verifies operation flow for role: LOCAL_MARKETING", () => {
    cy.loginAsRole("local_marketing");

    // [1/1] - Screen: LocalMarketingManagerDashboardScreen (local_marketing_manager_dashboard)
    cy.task("log", "PROGRESS: Visiting /management/local-marketing-manager-dashboard (LocalMarketingManagerDashboardScreen)...");
    cy.visitWithSemantics("/management/local-marketing-manager-dashboard");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("localmarketingmanagerdashboard-screen").should("be.visible");
    cy.getCy("localmarketingmanagerdashboard-title").should("be.visible");
    cy.getCy("localmarketingmanagerdashboard-content").should("be.visible");
    cy.screenshot("ma_local_marketing_local_marketing_manager_dashboard");
  });
});
