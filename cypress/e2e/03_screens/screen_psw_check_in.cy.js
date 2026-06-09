// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - psw_check_in", () => {
  it("opens and verifies screen psw_check_in", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Psw Check In)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Psw Check In...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswcheckin-screen").should("be.visible");
  cy.getCy("pswcheckin-title").should("be.visible");
  cy.getCy("pswcheckin-content").should("be.visible");
  cy.getCy("pswcheckin-btn-checkin").should("be.visible");
  cy.getCy("pswcheckin-btn-help").should("be.visible");
  cy.getCy("pswcheckin-btn-history").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Psw Check In...");
  cy.waitAndSee();
  cy.screenshot("psw_check_in");
  
  cy.task("log", "✅ PROGRESS: - Verified Psw Check In successfully!\n");

  });
});
