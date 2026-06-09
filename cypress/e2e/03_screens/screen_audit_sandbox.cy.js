// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - audit_sandbox", () => {
  it("opens and verifies screen audit_sandbox", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Audit Sandbox)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Audit Sandbox...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("auditsandbox-screen").should("be.visible");
  cy.getCy("auditsandbox-title").should("be.visible");
  cy.getCy("auditsandbox-content").should("be.visible");
  cy.getCy("audit-sandbox-lifecycle-status").should("be.visible");
  cy.getCy("audit-sandbox-completion-percentage").should("be.visible");
  cy.getCy("audit-sandbox-technical-manifest").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Audit Sandbox...");
  cy.waitAndSee();
  cy.screenshot("audit_sandbox");
  
  cy.task("log", "✅ PROGRESS: - Verified Audit Sandbox successfully!\n");

  });
});
