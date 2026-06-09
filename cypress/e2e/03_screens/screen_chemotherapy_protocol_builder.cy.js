// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - chemotherapy_protocol_builder", () => {
  it("opens and verifies screen chemotherapy_protocol_builder", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Chemotherapy Protocol Builder)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Chemotherapy Protocol Builder...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("chemotherapyprotocolbuilder-screen").should("be.visible");
  cy.getCy("chemotherapyprotocolbuilder-title").should("be.visible");
  cy.getCy("chemotherapyprotocolbuilder-content").should("be.visible");
  cy.getCy("protocol-builder-btn-create").should("be.visible");
  cy.getCy("protocol-builder-btn-edit").should("be.visible");
  cy.getCy("protocol-builder-btn-delete").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Chemotherapy Protocol Builder...");
  cy.waitAndSee();
  cy.screenshot("chemotherapy_protocol_builder");
  
  cy.task("log", "✅ PROGRESS: - Verified Chemotherapy Protocol Builder successfully!\n");

  });
});
