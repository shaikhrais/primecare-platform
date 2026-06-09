// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - admin_claims", () => {
  it("opens and verifies screen admin_claims", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/franchise/roles/admin/claims (Admin Claims)...");
  cy.visitWithSemantics("/offices/franchise/roles/admin/claims");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Admin Claims...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("adminclaims-screen").should("be.visible");
  cy.getCy("adminclaims-title").should("be.visible");
  cy.getCy("adminclaims-content").should("be.visible");
  cy.getCy("adminclaims-btn-approve").should("be.visible");
  cy.getCy("adminclaims-btn-reject").should("be.visible");
  cy.getCy("adminclaims-btn-generate-report").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Admin Claims...");
  cy.waitAndSee();
  cy.screenshot("admin_claims");
  
  cy.task("log", "✅ PROGRESS: - Verified Admin Claims successfully!\n");

  });
});
