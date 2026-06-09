// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - admin_reports", () => {
  it("opens and verifies screen admin_reports", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/franchise/roles/admin/reports (Admin Reports)...");
  cy.visitWithSemantics("/offices/franchise/roles/admin/reports");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Admin Reports...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("adminreports-screen").should("be.visible");
  cy.getCy("adminreports-title").should("be.visible");
  cy.getCy("adminreports-content").should("be.visible");
  cy.getCy("adminreports-btn-generate").should("be.visible");
  cy.getCy("adminreports-btn-export").should("be.visible");
  cy.getCy("adminreports-btn-feedback").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Admin Reports...");
  cy.waitAndSee();
  cy.screenshot("admin_reports");
  
  cy.task("log", "✅ PROGRESS: - Verified Admin Reports successfully!\n");

  });
});
