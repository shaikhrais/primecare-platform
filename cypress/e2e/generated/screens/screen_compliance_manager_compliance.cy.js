// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - compliance_manager_compliance", () => {
  it("opens and verifies screen compliance_manager_compliance", () => {
    cy.loginAsRole("compliance");

  cy.visit("/management/compliance-manager-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("compliancemanagercompliance-screen").should("be.visible");
  cy.getCy("compliancemanagercompliance-title").should("be.visible");
  cy.getCy("compliancemanagercompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("compliance_manager_compliance");

  });
});
