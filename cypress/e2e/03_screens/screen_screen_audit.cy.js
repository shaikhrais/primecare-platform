// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - screen_audit", () => {
  it("opens and verifies screen screen_audit", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Screen Audit)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Screen Audit...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("screenaudit-screen").should("be.visible");
  cy.getCy("screenaudit-title").should("be.visible");
  cy.getCy("screenaudit-content").should("be.visible");
  cy.getCy("compliance-scan-status").should("be.visible");
  cy.getCy("audit-log-summary").should("be.visible");
  cy.getCy("kpi-widget").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Screen Audit...");
  cy.waitAndSee();
  cy.screenshot("screen_audit");
  
  cy.task("log", "✅ PROGRESS: - Verified Screen Audit successfully!\n");

  });
});
