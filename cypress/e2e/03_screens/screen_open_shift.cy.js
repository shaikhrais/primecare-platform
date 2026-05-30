// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - open_shift", () => {
  it("opens and verifies screen open_shift", () => {
    cy.loginAsRole("scheduler");

  cy.task("log", "⏳ PROGRESS: - Navigating to /staff/open-shift (OpenShiftScreen)...");
  cy.visitWithSemantics("/staff/open-shift");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for OpenShiftScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("openshift-screen").should("be.visible");
  cy.getCy("openshift-title").should("be.visible");
  cy.getCy("openshift-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for OpenShiftScreen...");
  cy.waitAndSee();
  cy.screenshot("open_shift");
  
  cy.task("log", "✅ PROGRESS: - Verified OpenShiftScreen successfully!\n");

  });
});
