// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - role_access_matrix", () => {
  it("opens and verifies screen role_access_matrix", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Role Access Matrix)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Role Access Matrix...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("roleaccessmatrix-screen").should("be.visible");
  cy.getCy("roleaccessmatrix-title").should("be.visible");
  cy.getCy("roleaccessmatrix-content").should("be.visible");
  cy.getCy("role-access-matrix").should("be.visible");
  cy.getCy("btn-save-permissions").should("be.visible");
  cy.getCy("btn-refresh-data").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Role Access Matrix...");
  cy.waitAndSee();
  cy.screenshot("role_access_matrix");
  
  cy.task("log", "✅ PROGRESS: - Verified Role Access Matrix successfully!\n");

  });
});
