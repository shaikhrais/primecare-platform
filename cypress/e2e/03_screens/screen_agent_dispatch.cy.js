// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - agent_dispatch", () => {
  it("opens and verifies screen agent_dispatch", () => {
    cy.loginAsRole("governance");

  cy.task("log", "⏳ PROGRESS: - Navigating to /common/agent-dispatch (AgentDispatchScreen)...");
  cy.visitWithSemantics("/common/agent-dispatch");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for AgentDispatchScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("agentdispatch-screen").should("be.visible");
  cy.getCy("agentdispatch-title").should("be.visible");
  cy.getCy("agentdispatch-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for AgentDispatchScreen...");
  cy.waitAndSee();
  cy.screenshot("agent_dispatch");
  
  cy.task("log", "✅ PROGRESS: - Verified AgentDispatchScreen successfully!\n");

  });
});
