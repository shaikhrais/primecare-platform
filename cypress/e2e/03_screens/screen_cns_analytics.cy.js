// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - cns_analytics", () => {
  it("opens and verifies screen cns_analytics", () => {
    cy.loginAsRole("cns");

  cy.task("log", "⏳ PROGRESS: - Navigating to /rn/cns-analytics (Clinical Nurse Specialist Analytics)...");
  cy.visitWithSemantics("/rn/cns-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Clinical Nurse Specialist Analytics...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cnsanalytics-screen").should("be.visible");
  cy.getCy("cnsanalytics-title").should("be.visible");
  cy.getCy("cnsanalytics-content").should("be.visible");
  cy.getCy("cns-dashboard-btn-update-care-plan").should("be.visible");
  cy.getCy("cns-dashboard-btn-submit-feedback").should("be.visible");
  cy.getCy("cns-dashboard-btn-generate-report").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Clinical Nurse Specialist Analytics...");
  cy.waitAndSee();
  cy.screenshot("cns_analytics");
  
  cy.task("log", "✅ PROGRESS: - Verified Clinical Nurse Specialist Analytics successfully!\n");

  });
});
