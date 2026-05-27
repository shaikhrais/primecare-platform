// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - bus_dev", () => {
  it("tests all screens for role bus_dev", () => {
    cy.loginAsRole("bus_dev");


  cy.visit("/common/business-development-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("businessdevelopmentdashboard-screen").should("be.visible");
  cy.getCy("businessdevelopmentdashboard-title").should("be.visible");
  cy.getCy("businessdevelopmentdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("business_development_dashboard");

  cy.visit("/management/head-of-bus-dev-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("headofbusdevdashboard-screen").should("be.visible");
  cy.getCy("headofbusdevdashboard-title").should("be.visible");
  cy.getCy("headofbusdevdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("head_of_bus_dev_dashboard");

  cy.visit("/common/business-development-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("businessdevelopmentanalytics-screen").should("be.visible");
  cy.getCy("businessdevelopmentanalytics-title").should("be.visible");
  cy.getCy("businessdevelopmentanalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("business_development_analytics");

  cy.visit("/common/business-development-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("businessdevelopmentcompliance-screen").should("be.visible");
  cy.getCy("businessdevelopmentcompliance-title").should("be.visible");
  cy.getCy("businessdevelopmentcompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("business_development_compliance");

  cy.visit("/common/business-development-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("businessdevelopmentworkflow-screen").should("be.visible");
  cy.getCy("businessdevelopmentworkflow-title").should("be.visible");
  cy.getCy("businessdevelopmentworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("business_development_workflow");

  cy.visit("/management/head-of-bus-dev-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("headofbusdevanalytics-screen").should("be.visible");
  cy.getCy("headofbusdevanalytics-title").should("be.visible");
  cy.getCy("headofbusdevanalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("head_of_bus_dev_analytics");

  cy.visit("/management/head-of-bus-dev-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("headofbusdevcompliance-screen").should("be.visible");
  cy.getCy("headofbusdevcompliance-title").should("be.visible");
  cy.getCy("headofbusdevcompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("head_of_bus_dev_compliance");

  cy.visit("/management/head-of-bus-dev-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("headofbusdevworkflow-screen").should("be.visible");
  cy.getCy("headofbusdevworkflow-title").should("be.visible");
  cy.getCy("headofbusdevworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("head_of_bus_dev_workflow");

  cy.visit("/management/franchise-lead");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchiselead-screen").should("be.visible");
  cy.getCy("franchiselead-title").should("be.visible");
  cy.getCy("franchiselead-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("franchise_lead");

  cy.visit("/management/partnership-management");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("partnershipmanagement-screen").should("be.visible");
  cy.getCy("partnershipmanagement-title").should("be.visible");
  cy.getCy("partnershipmanagement-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("partnership_management");

  cy.visit("/management/growth-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("growthanalytics-screen").should("be.visible");
  cy.getCy("growthanalytics-title").should("be.visible");
  cy.getCy("growthanalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("growth_analytics");

  cy.visit("/management/outreach-campaign");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("outreachcampaign-screen").should("be.visible");
  cy.getCy("outreachcampaign-title").should("be.visible");
  cy.getCy("outreachcampaign-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("outreach_campaign");

  });
});
