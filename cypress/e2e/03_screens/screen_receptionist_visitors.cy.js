// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - receptionist_visitors", () => {
  it("opens and verifies screen receptionist_visitors", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Receptionist Visitors)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Receptionist Visitors...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("receptionistvisitors-screen").should("be.visible");
  cy.getCy("receptionistvisitors-title").should("be.visible");
  cy.getCy("receptionistvisitors-content").should("be.visible");
  cy.getCy("receptionist-btn-manage-settings").should("be.visible");
  cy.getCy("receptionist-btn-conduct-audit").should("be.visible");
  cy.getCy("receptionist-btn-log-event").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Receptionist Visitors...");
  cy.waitAndSee();
  cy.screenshot("receptionist_visitors");
  
  cy.task("log", "✅ PROGRESS: - Verified Receptionist Visitors successfully!\n");

  });
});
