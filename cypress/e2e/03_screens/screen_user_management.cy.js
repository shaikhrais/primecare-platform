// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - user_management", () => {
  it("opens and verifies screen user_management", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (User Management)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for User Management...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("usermanagement-screen").should("be.visible");
  cy.getCy("usermanagement-title").should("be.visible");
  cy.getCy("usermanagement-content").should("be.visible");
  cy.getCy("user-management-btn-add").should("be.visible");
  cy.getCy("user-management-btn-edit").should("be.visible");
  cy.getCy("user-management-btn-manage-roles").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for User Management...");
  cy.waitAndSee();
  cy.screenshot("user_management");
  
  cy.task("log", "✅ PROGRESS: - Verified User Management successfully!\n");

  });
});
