// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - rn_messaging", () => {
  it("opens and verifies screen rn_messaging", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Rn Messaging)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Rn Messaging...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rnmessaging-screen").should("be.visible");
  cy.getCy("rnmessaging-title").should("be.visible");
  cy.getCy("rnmessaging-content").should("be.visible");
  cy.getCy("dashboard-btn-refresh-metrics").should("be.visible");
  cy.getCy("dashboard-btn-view-compliance").should("be.visible");
  cy.getCy("dashboard-btn-check-security").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Rn Messaging...");
  cy.waitAndSee();
  cy.screenshot("rn_messaging");
  
  cy.task("log", "✅ PROGRESS: - Verified Rn Messaging successfully!\n");

  });
});
