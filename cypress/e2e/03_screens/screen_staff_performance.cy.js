// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - staff_performance", () => {
  it("opens and verifies screen staff_performance", () => {
    cy.loginAsRole("clinical_director");

  cy.visitWithSemantics("/clinical/staff-performance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("staffperformance-screen").should("be.visible");
  cy.getCy("staffperformance-title").should("be.visible");
  cy.getCy("staffperformance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("staff_performance");

  });
});
