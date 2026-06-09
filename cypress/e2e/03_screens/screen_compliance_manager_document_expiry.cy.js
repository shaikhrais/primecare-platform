// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - compliance_manager_document_expiry", () => {
  it("opens and verifies screen compliance_manager_document_expiry", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Compliance Manager Document Expiry)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Compliance Manager Document Expiry...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("compliancemanagerdocumentexpiry-screen").should("be.visible");
  cy.getCy("compliancemanagerdocumentexpiry-title").should("be.visible");
  cy.getCy("compliancemanagerdocumentexpiry-content").should("be.visible");
  cy.getCy("compliance-doc-expiry-overview").should("be.visible");
  cy.getCy("compliance-doc-update-btn").should("be.visible");
  cy.getCy("compliance-report-generate-btn").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Compliance Manager Document Expiry...");
  cy.waitAndSee();
  cy.screenshot("compliance_manager_document_expiry");
  
  cy.task("log", "✅ PROGRESS: - Verified Compliance Manager Document Expiry successfully!\n");

  });
});
