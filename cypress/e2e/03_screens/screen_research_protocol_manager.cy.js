// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - research_protocol_manager", () => {
  it("opens and verifies screen research_protocol_manager", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Research Protocol Manager)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Research Protocol Manager...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("researchprotocolmanager-screen").should("be.visible");
  cy.getCy("researchprotocolmanager-title").should("be.visible");
  cy.getCy("researchprotocolmanager-content").should("be.visible");
  cy.getCy("researchprotocols-btn-create").should("be.visible");
  cy.getCy("researchprotocols-btn-edit").should("be.visible");
  cy.getCy("researchprotocols-btn-approve").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Research Protocol Manager...");
  cy.waitAndSee();
  cy.screenshot("research_protocol_manager");
  
  cy.task("log", "✅ PROGRESS: - Verified Research Protocol Manager successfully!\n");

  });
});
