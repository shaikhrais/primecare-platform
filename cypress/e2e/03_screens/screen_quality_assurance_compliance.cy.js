// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - quality_assurance_compliance", () => {
  it("opens and verifies screen quality_assurance_compliance", () => {
    cy.loginAsRole("qa_specialist");

  cy.visitWithSemantics("/staff/quality-assurance-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("qualityassurancecompliance-screen").should("be.visible");
  cy.getCy("qualityassurancecompliance-title").should("be.visible");
  cy.getCy("qualityassurancecompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("quality_assurance_compliance");

  });
});
