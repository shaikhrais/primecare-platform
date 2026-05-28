// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - agent_dispatch", () => {
  it("opens and verifies screen agent_dispatch", () => {
    cy.loginAsRole("governance");

  cy.visitWithSemantics("/common/agent-dispatch");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("agentdispatch-screen").should("be.visible");
  cy.getCy("agentdispatch-title").should("be.visible");
  cy.getCy("agentdispatch-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("agent_dispatch");

  });
});
