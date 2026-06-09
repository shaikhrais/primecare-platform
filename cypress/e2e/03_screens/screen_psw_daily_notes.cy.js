// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - psw_daily_notes", () => {
  it("opens and verifies screen psw_daily_notes", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Psw Daily Notes)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Psw Daily Notes...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswdailynotes-screen").should("be.visible");
  cy.getCy("pswdailynotes-title").should("be.visible");
  cy.getCy("pswdailynotes-content").should("be.visible");
  cy.getCy("psw_daily_notes-add_note").should("be.visible");
  cy.getCy("psw_daily_notes-save").should("be.visible");
  cy.getCy("psw_daily_notes-update").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Psw Daily Notes...");
  cy.waitAndSee();
  cy.screenshot("psw_daily_notes");
  
  cy.task("log", "✅ PROGRESS: - Verified Psw Daily Notes successfully!\n");

  });
});
