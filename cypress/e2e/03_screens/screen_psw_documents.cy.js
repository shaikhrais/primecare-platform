// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - psw_documents", () => {
  it("opens and verifies screen psw_documents", () => {
    cy.loginAsRole("psw");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/psw/documents (PswDocumentsScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/psw/documents");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for PswDocumentsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswdocuments-screen").should("be.visible");
  cy.getCy("pswdocuments-title").should("be.visible");
  cy.getCy("pswdocuments-content").should("be.visible");
  cy.getCy("psw-dashboard-client-overview").should("be.visible");
  cy.getCy("psw-dashboard-health-status").should("be.visible");
  cy.getCy("psw-dashboard-activity-log").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for PswDocumentsScreen...");
  cy.waitAndSee();
  cy.screenshot("psw_documents");
  
  cy.task("log", "✅ PROGRESS: - Verified PswDocumentsScreen successfully!\n");

  });
});
