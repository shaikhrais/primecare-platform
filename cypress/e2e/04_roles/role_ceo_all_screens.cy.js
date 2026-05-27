// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - ceo", () => {
  it("tests all screens for role ceo", () => {
    cy.loginAsRole("ceo");


  cy.visit("/executive/executive-command-center");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("executivecommandcenter-screen").should("be.visible");
  cy.getCy("executivecommandcenter-title").should("be.visible");
  cy.getCy("executivecommandcenter-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("executive_command_center");

  cy.visit("/executive/enterprise-health");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("enterprisehealth-screen").should("be.visible");
  cy.getCy("enterprisehealth-title").should("be.visible");
  cy.getCy("enterprisehealth-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("enterprise_health");

  cy.visit("/executive/revenue-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("revenueanalytics-screen").should("be.visible");
  cy.getCy("revenueanalytics-title").should("be.visible");
  cy.getCy("revenueanalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("revenue_analytics");

  cy.visit("/executive/risk-management");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("riskmanagement-screen").should("be.visible");
  cy.getCy("riskmanagement-title").should("be.visible");
  cy.getCy("riskmanagement-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("risk_management");

  cy.visit("/executive/franchise-overview");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchiseoverview-screen").should("be.visible");
  cy.getCy("franchiseoverview-title").should("be.visible");
  cy.getCy("franchiseoverview-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("franchise_overview");

  cy.visit("/executive/enterprise-command-center4-k");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("enterprisecommandcenter4k-screen").should("be.visible");
  cy.getCy("enterprisecommandcenter4k-title").should("be.visible");
  cy.getCy("enterprisecommandcenter4k-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("enterprise_command_center4_k");

  });
});
