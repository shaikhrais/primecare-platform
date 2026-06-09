// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - crisis_protocol_trigger", () => {
  it("opens and verifies screen crisis_protocol_trigger", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Crisis Protocol Trigger)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Crisis Protocol Trigger...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("crisisprotocoltrigger-screen").should("be.visible");
  cy.getCy("crisisprotocoltrigger-title").should("be.visible");
  cy.getCy("crisisprotocoltrigger-content").should("be.visible");
  cy.getCy("crisisprotocol-btn-activate").should("be.visible");
  cy.getCy("crisisprotocol-btn-checkin").should("be.visible");
  cy.getCy("crisisprotocol-btn-alert").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Crisis Protocol Trigger...");
  cy.waitAndSee();
  cy.screenshot("crisis_protocol_trigger");
  
  cy.task("log", "✅ PROGRESS: - Verified Crisis Protocol Trigger successfully!\n");

  });
});
