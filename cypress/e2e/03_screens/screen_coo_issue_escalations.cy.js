// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - coo_issue_escalations", () => {
  it("opens and verifies screen coo_issue_escalations", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/corporate/roles/coo/issue-escalations (Coo Issue Escalations)...");
  cy.visitWithSemantics("/offices/corporate/roles/coo/issue-escalations");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Coo Issue Escalations...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cooissueescalations-screen").should("be.visible");
  cy.getCy("cooissueescalations-title").should("be.visible");
  cy.getCy("cooissueescalations-content").should("be.visible");
  cy.getCy("escalation-overview").should("be.visible");
  cy.getCy("resolution-metrics").should("be.visible");
  cy.getCy("communication-log").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Coo Issue Escalations...");
  cy.waitAndSee();
  cy.screenshot("coo_issue_escalations");
  
  cy.task("log", "✅ PROGRESS: - Verified Coo Issue Escalations successfully!\n");

  });
});
