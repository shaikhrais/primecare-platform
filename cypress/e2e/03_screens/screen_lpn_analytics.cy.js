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

  cy.getCy("licensed practical nurse (lpn) analytics-screen").should("be.visible");
  cy.getCy("licensed practical nurse (lpn) analytics-title").should("be.visible");
  cy.getCy("licensed practical nurse (lpn) analytics-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Licensed Practical Nurse (LPN) Analytics...");
  cy.waitAndSee();
  cy.screenshot("lpn_analytics");
  
  cy.task("log", "✅ PROGRESS: - Verified Licensed Practical Nurse (LPN) Analytics successfully!\n");

  });
});
