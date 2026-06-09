// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - virtual_waiting_room", () => {
  it("opens and verifies screen virtual_waiting_room", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Virtual Waiting Room)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Virtual Waiting Room...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("virtualwaitingroom-screen").should("be.visible");
  cy.getCy("virtualwaitingroom-title").should("be.visible");
  cy.getCy("virtualwaitingroom-content").should("be.visible");
  cy.getCy("virtual-waiting-room-btn-checkin").should("be.visible");
  cy.getCy("virtual-waiting-room-btn-checkout").should("be.visible");
  cy.getCy("virtual-waiting-room-btn-send-message").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Virtual Waiting Room...");
  cy.waitAndSee();
  cy.screenshot("virtual_waiting_room");
  
  cy.task("log", "✅ PROGRESS: - Verified Virtual Waiting Room successfully!\n");

  });
});
