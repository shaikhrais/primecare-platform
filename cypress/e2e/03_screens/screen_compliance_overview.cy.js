// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - compliance_overview", () => {
  it("opens and verifies screen compliance_overview", () => {
    cy.loginAsRole("owner");

  cy.visitWithSemantics("/executive/compliance-overview");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("complianceoverview-screen").should("be.visible");
  cy.getCy("complianceoverview-title").should("be.visible");
  cy.getCy("complianceoverview-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("compliance_overview");

  });
});
