// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - psw_reports", () => {
  it("opens and verifies screen psw_reports", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Psw Reports)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Psw Reports...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswreports-screen").should("be.visible");
  cy.getCy("pswreports-title").should("be.visible");
  cy.getCy("pswreports-content").should("be.visible");
  cy.getCy("pswreports-btn-generate").should("be.visible");
  cy.getCy("pswreports-btn-feedback").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Psw Reports...");
  cy.waitAndSee();
  cy.screenshot("psw_reports");
  
  cy.task("log", "✅ PROGRESS: - Verified Psw Reports successfully!\n");

  });
});
