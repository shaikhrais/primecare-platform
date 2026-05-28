// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - quality_assurance_workflow", () => {
  it("opens and verifies screen quality_assurance_workflow", () => {
    cy.loginAsRole("qa_specialist");

  cy.visitWithSemantics("/staff/quality-assurance-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("qualityassuranceworkflow-screen").should("be.visible");
  cy.getCy("qualityassuranceworkflow-title").should("be.visible");
  cy.getCy("qualityassuranceworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("quality_assurance_workflow");

  });
});
