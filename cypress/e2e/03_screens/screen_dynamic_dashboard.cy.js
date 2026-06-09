// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - dynamic_dashboard", () => {
  it("opens and verifies screen dynamic_dashboard", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Dynamic Dashboard)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Dynamic Dashboard...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("dynamicdashboard-screen").should("be.visible");
  cy.getCy("dynamicdashboard-title").should("be.visible");
  cy.getCy("dynamicdashboard-content").should("be.visible");
  cy.getCy("dynamic_dashboard-btn-run-compliance-scan").should("be.visible");
  cy.getCy("dynamic_dashboard-btn-sync-posture").should("be.visible");
  cy.getCy("dynamic_dashboard-btn-update-policy").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Dynamic Dashboard...");
  cy.waitAndSee();
  cy.screenshot("dynamic_dashboard");
  
  cy.task("log", "✅ PROGRESS: - Verified Dynamic Dashboard successfully!\n");

  });
});
