// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - quality_audit", () => {
  it("opens and verifies screen quality_audit", () => {
    cy.loginAsRole("qa_specialist");

  cy.visitWithSemantics("/staff/quality-audit");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("qualityaudit-screen").should("be.visible");
  cy.getCy("qualityaudit-title").should("be.visible");
  cy.getCy("qualityaudit-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("quality_audit");

  });
});
