// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - qa_analytics", () => {
  it("opens and verifies screen qa_analytics", () => {
    cy.loginAsRole("qa_specialist");

  cy.visit("/common/qa-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("qaanalytics-screen").should("be.visible");
  cy.getCy("qaanalytics-title").should("be.visible");
  cy.getCy("qaanalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("qa_analytics");

  });
});
