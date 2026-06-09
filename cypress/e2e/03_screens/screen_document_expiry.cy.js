// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - document_expiry", () => {
  it("opens and verifies screen document_expiry", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/corporate/roles/compliance_manager/document-expiry (Document Expiry)...");
  cy.visitWithSemantics("/offices/corporate/roles/compliance_manager/document-expiry");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Document Expiry...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("documentexpiry-screen").should("be.visible");
  cy.getCy("documentexpiry-title").should("be.visible");
  cy.getCy("documentexpiry-content").should("be.visible");
  cy.getCy("document-expiry-overview").should("be.visible");
  cy.getCy("document-notification-section").should("be.visible");
  cy.getCy("document-renew-button").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Document Expiry...");
  cy.waitAndSee();
  cy.screenshot("document_expiry");
  
  cy.task("log", "✅ PROGRESS: - Verified Document Expiry successfully!\n");

  });
});
