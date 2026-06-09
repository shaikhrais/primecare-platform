// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - np_analytics", () => {
  it("opens and verifies screen np_analytics", () => {
    cy.loginAsRole("np");

  cy.task("log", "⏳ PROGRESS: - Navigating to /rn/np-analytics (Nurse Practitioner (NP) Analytics)...");
  cy.visitWithSemantics("/rn/np-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Nurse Practitioner (NP) Analytics...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("npanalytics-screen").should("be.visible");
  cy.getCy("npanalytics-title").should("be.visible");
  cy.getCy("npanalytics-content").should("be.visible");
  cy.getCy("np-dashboard-btn-view-records").should("be.visible");
  cy.getCy("np-dashboard-btn-generate-report").should("be.visible");
  cy.getCy("np-dashboard-btn-send-alert").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Nurse Practitioner (NP) Analytics...");
  cy.waitAndSee();
  cy.screenshot("np_analytics");
  
  cy.task("log", "✅ PROGRESS: - Verified Nurse Practitioner (NP) Analytics successfully!\n");

  });
});
