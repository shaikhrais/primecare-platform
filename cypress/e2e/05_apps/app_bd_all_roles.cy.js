// AUTO-GENERATED APP E2E SPEC. SYSTEMATICALLY GENERATED.
// Tests all allowed roles and their respective screens on the portal.
// Leverages reusable SSO commands and custom Semantics selector lookups.

describe("App All Roles All Screens - Primecare Business Development", () => {

  it("verifies operation flow for role: BUS_DEV", () => {
    cy.loginAsRole("bus_dev");

    // [1/6] - Screen: BusinessDevelopmentDashboardScreen (business_development_dashboard)
    cy.task("log", "PROGRESS: Visiting /common/business-development-dashboard (BusinessDevelopmentDashboardScreen)...");
    cy.visitWithSemantics("/common/business-development-dashboard");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("businessdevelopmentdashboard-screen").should("be.visible");
    cy.getCy("businessdevelopmentdashboard-title").should("be.visible");
    cy.getCy("businessdevelopmentdashboard-content").should("be.visible");
    cy.screenshot("bd_bus_dev_business_development_dashboard");

    // [2/6] - Screen: FranchiseLeadScreen (franchise_lead)
    cy.task("log", "PROGRESS: Visiting /management/franchise-lead (FranchiseLeadScreen)...");
    cy.visitWithSemantics("/management/franchise-lead");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("franchiselead-screen").should("be.visible");
    cy.getCy("franchiselead-title").should("be.visible");
    cy.getCy("franchiselead-content").should("be.visible");
    cy.screenshot("bd_bus_dev_franchise_lead");

    // [3/6] - Screen: GrowthAnalyticsScreen (growth_analytics)
    cy.task("log", "PROGRESS: Visiting /management/growth-analytics (GrowthAnalyticsScreen)...");
    cy.visitWithSemantics("/management/growth-analytics");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("growthanalytics-screen").should("be.visible");
    cy.getCy("growthanalytics-title").should("be.visible");
    cy.getCy("growthanalytics-content").should("be.visible");
    cy.screenshot("bd_bus_dev_growth_analytics");

    // [4/6] - Screen: HeadOfBusDevDashboardScreen (head_of_bus_dev_dashboard)
    cy.task("log", "PROGRESS: Visiting /management/head-of-bus-dev-dashboard (HeadOfBusDevDashboardScreen)...");
    cy.visitWithSemantics("/management/head-of-bus-dev-dashboard");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("headofbusdevdashboard-screen").should("be.visible");
    cy.getCy("headofbusdevdashboard-title").should("be.visible");
    cy.getCy("headofbusdevdashboard-content").should("be.visible");
    cy.screenshot("bd_bus_dev_head_of_bus_dev_dashboard");

    // [5/6] - Screen: OutreachCampaignScreen (outreach_campaign)
    cy.task("log", "PROGRESS: Visiting /management/outreach-campaign (OutreachCampaignScreen)...");
    cy.visitWithSemantics("/management/outreach-campaign");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("outreachcampaign-screen").should("be.visible");
    cy.getCy("outreachcampaign-title").should("be.visible");
    cy.getCy("outreachcampaign-content").should("be.visible");
    cy.screenshot("bd_bus_dev_outreach_campaign");

    // [6/6] - Screen: PartnershipManagementScreen (partnership_management)
    cy.task("log", "PROGRESS: Visiting /management/partnership-management (PartnershipManagementScreen)...");
    cy.visitWithSemantics("/management/partnership-management");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.getCy("partnershipmanagement-screen").should("be.visible");
    cy.getCy("partnershipmanagement-title").should("be.visible");
    cy.getCy("partnershipmanagement-content").should("be.visible");
    cy.screenshot("bd_bus_dev_partnership_management");
  });
});
