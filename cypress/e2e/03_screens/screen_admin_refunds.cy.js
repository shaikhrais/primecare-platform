// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - admin_refunds", () => {
  it("opens and verifies screen admin_refunds", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/franchise/roles/admin/refunds (Admin Refunds)...");
  cy.visitWithSemantics("/offices/franchise/roles/admin/refunds");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Admin Refunds...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("adminrefunds-screen").should("be.visible");
  cy.getCy("adminrefunds-title").should("be.visible");
  cy.getCy("adminrefunds-content").should("be.visible");
  cy.getCy("refunds-btn-approve").should("be.visible");
  cy.getCy("refunds-btn-reject").should("be.visible");
  cy.getCy("refunds-btn-communicate").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Admin Refunds...");
  cy.waitAndSee();
  cy.screenshot("admin_refunds");
  
  cy.task("log", "✅ PROGRESS: - Verified Admin Refunds successfully!\n");

  });
});
