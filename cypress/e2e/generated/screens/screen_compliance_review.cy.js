// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - compliance_review", () => {
  it("opens and verifies screen compliance_review", () => {
    cy.loginAsRole("clinical_director");

  cy.visit("/clinical/compliance-review");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("compliancereview-screen").should("be.visible");
  cy.getCy("compliancereview-title").should("be.visible");
  cy.getCy("compliancereview-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("compliance_review");

  });
});
