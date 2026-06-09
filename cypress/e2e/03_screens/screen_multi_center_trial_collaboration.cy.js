// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - multi_center_trial_collaboration", () => {
  it("opens and verifies screen multi_center_trial_collaboration", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Multi Center Trial Collaboration)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Multi Center Trial Collaboration...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("multicentertrialcollaboration-screen").should("be.visible");
  cy.getCy("multicentertrialcollaboration-title").should("be.visible");
  cy.getCy("multicentertrialcollaboration-content").should("be.visible");
  cy.getCy("trial-dashboard-btn-update-data").should("be.visible");
  cy.getCy("trial-dashboard-btn-monitor-progress").should("be.visible");
  cy.getCy("trial-dashboard-btn-send-message").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Multi Center Trial Collaboration...");
  cy.waitAndSee();
  cy.screenshot("multi_center_trial_collaboration");
  
  cy.task("log", "✅ PROGRESS: - Verified Multi Center Trial Collaboration successfully!\n");

  });
});
