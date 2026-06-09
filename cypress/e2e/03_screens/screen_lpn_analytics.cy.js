// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - lpn_analytics", () => {
  it("opens and verifies screen lpn_analytics", () => {
    cy.loginAsRole("lpn");

  cy.task("log", "⏳ PROGRESS: - Navigating to /rpn/lpn-analytics (Licensed Practical Nurse (LPN) Analytics)...");
  cy.visitWithSemantics("/rpn/lpn-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Licensed Practical Nurse (LPN) Analytics...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("lpnanalytics-screen").should("be.visible");
  cy.getCy("lpnanalytics-title").should("be.visible");
  cy.getCy("lpnanalytics-content").should("be.visible");
  cy.getCy("lpn-dashboard-btn-report-incident").should("be.visible");
  cy.getCy("lpn-dashboard-btn-view-care-plan").should("be.visible");
  cy.getCy("lpn-dashboard-btn-track-compliance").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Licensed Practical Nurse (LPN) Analytics...");
  cy.waitAndSee();
  cy.screenshot("lpn_analytics");
  
  cy.task("log", "✅ PROGRESS: - Verified Licensed Practical Nurse (LPN) Analytics successfully!\n");

  });
});
