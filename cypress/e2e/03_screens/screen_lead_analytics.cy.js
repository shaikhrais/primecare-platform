// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - lead_analytics", () => {
  it("opens and verifies screen lead_analytics", () => {
    cy.loginAsRole("marketing");

  cy.visitWithSemantics("/management/lead-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("leadanalytics-screen").should("be.visible");
  cy.getCy("leadanalytics-title").should("be.visible");
  cy.getCy("leadanalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("lead_analytics");

  });
});
