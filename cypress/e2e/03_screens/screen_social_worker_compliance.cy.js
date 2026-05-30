// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - social_worker_compliance", () => {
  it("opens and verifies screen social_worker_compliance", () => {
    cy.loginAsRole("social_worker");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/social_worker/compliance (SocialWorkerComplianceScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/social_worker/compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for SocialWorkerComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("socialworkercompliance-screen").should("be.visible");
  cy.getCy("socialworkercompliance-title").should("be.visible");
  cy.getCy("socialworkercompliance-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for SocialWorkerComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("social_worker_compliance");
  
  cy.task("log", "✅ PROGRESS: - Verified SocialWorkerComplianceScreen successfully!\n");

  });
});
