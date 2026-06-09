// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - psw_help_support", () => {
  it("opens and verifies screen psw_help_support", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Psw Help Support)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Psw Help Support...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswhelpsupport-screen").should("be.visible");
  cy.getCy("pswhelpsupport-title").should("be.visible");
  cy.getCy("pswhelpsupport-content").should("be.visible");
  cy.getCy("pswhelp-btn-submit-feedback").should("be.visible");
  cy.getCy("pswhelp-btn-access-faqs").should("be.visible");
  cy.getCy("pswhelp-btn-contact-support").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Psw Help Support...");
  cy.waitAndSee();
  cy.screenshot("psw_help_support");
  
  cy.task("log", "✅ PROGRESS: - Verified Psw Help Support successfully!\n");

  });
});
