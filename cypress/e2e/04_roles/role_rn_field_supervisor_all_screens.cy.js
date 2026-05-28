// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - rn_field_supervisor", () => {
  it("tests all screens for role rn_field_supervisor", () => {
    cy.loginAsRole("rn_field_supervisor");


  cy.visitWithSemantics("/rn/rn-field-supervisor-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rnfieldsupervisordashboard-screen").should("be.visible");
  cy.getCy("rnfieldsupervisordashboard-title").should("be.visible");
  cy.getCy("rnfieldsupervisordashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rn_field_supervisor_dashboard");

  cy.visitWithSemantics("/rn/rn-field-supervisor-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("registered nurse (rn) field supervisor analytics-screen").should("be.visible");
  cy.getCy("registered nurse (rn) field supervisor analytics-title").should("be.visible");
  cy.getCy("registered nurse (rn) field supervisor analytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rn_field_supervisor_analytics");

  cy.visitWithSemantics("/rn/rn-field-supervisor-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("registered nurse (rn) field supervisor compliance workflow-screen").should("be.visible");
  cy.getCy("registered nurse (rn) field supervisor compliance workflow-title").should("be.visible");
  cy.getCy("registered nurse (rn) field supervisor compliance workflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rn_field_supervisor_workflow");

  });
});
