// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - customer_support", () => {
  it("tests all screens for role customer_support", () => {
    cy.loginAsRole("customer_support");


  cy.visit("/common/customer-support-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("customersupportanalytics-screen").should("be.visible");
  cy.getCy("customersupportanalytics-title").should("be.visible");
  cy.getCy("customersupportanalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("customer_support_analytics");

  cy.visit("/common/customer-support-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("customersupportcompliance-screen").should("be.visible");
  cy.getCy("customersupportcompliance-title").should("be.visible");
  cy.getCy("customersupportcompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("customer_support_compliance");

  cy.visit("/common/customer-support-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("customersupportworkflow-screen").should("be.visible");
  cy.getCy("customersupportworkflow-title").should("be.visible");
  cy.getCy("customersupportworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("customer_support_workflow");

  cy.visit("/common/support-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("supportanalytics-screen").should("be.visible");
  cy.getCy("supportanalytics-title").should("be.visible");
  cy.getCy("supportanalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("support_analytics");

  cy.visit("/common/support-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("supportcompliance-screen").should("be.visible");
  cy.getCy("supportcompliance-title").should("be.visible");
  cy.getCy("supportcompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("support_compliance");

  cy.visit("/common/support-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("supportworkflow-screen").should("be.visible");
  cy.getCy("supportworkflow-title").should("be.visible");
  cy.getCy("supportworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("support_workflow");

  cy.visit("/staff/ticket-management");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("ticketmanagement-screen").should("be.visible");
  cy.getCy("ticketmanagement-title").should("be.visible");
  cy.getCy("ticketmanagement-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("ticket_management");

  cy.visit("/staff/client-issue");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clientissue-screen").should("be.visible");
  cy.getCy("clientissue-title").should("be.visible");
  cy.getCy("clientissue-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("client_issue");

  cy.visit("/staff/communication");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("communication-screen").should("be.visible");
  cy.getCy("communication-title").should("be.visible");
  cy.getCy("communication-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("communication");

  cy.visit("/staff/resolution-tracking");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("resolutiontracking-screen").should("be.visible");
  cy.getCy("resolutiontracking-title").should("be.visible");
  cy.getCy("resolutiontracking-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("resolution_tracking");

  });
});
