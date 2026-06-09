// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - admin_user_management", () => {
  it("opens and verifies screen admin_user_management", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Admin User Management)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Admin User Management...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("adminusermanagement-screen").should("be.visible");
  cy.getCy("adminusermanagement-title").should("be.visible");
  cy.getCy("adminusermanagement-content").should("be.visible");
  cy.getCy("admin-user-list").should("be.visible");
  cy.getCy("admin-provision-user-btn").should("be.visible");
  cy.getCy("admin-edit-permissions-btn").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Admin User Management...");
  cy.waitAndSee();
  cy.screenshot("admin_user_management");
  
  cy.task("log", "✅ PROGRESS: - Verified Admin User Management successfully!\n");

  });
});
