// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - ceo_approvals", () => {
  it("opens and verifies screen ceo_approvals", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/corporate/roles/ceo/approvals (Ceo Approvals)...");
  cy.visitWithSemantics("/offices/corporate/roles/ceo/approvals");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Ceo Approvals...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("ceoapprovals-screen").should("be.visible");
  cy.getCy("ceoapprovals-title").should("be.visible");
  cy.getCy("ceoapprovals-content").should("be.visible");
  cy.getCy("ceoapprovals-btn-approve").should("be.visible");
  cy.getCy("ceoapprovals-btn-reject").should("be.visible");
  cy.getCy("ceoapprovals-btn-feedback").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Ceo Approvals...");
  cy.waitAndSee();
  cy.screenshot("ceo_approvals");
  
  cy.task("log", "✅ PROGRESS: - Verified Ceo Approvals successfully!\n");

  });
});
