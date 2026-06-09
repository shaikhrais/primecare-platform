// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - staff_utilization_heatmap", () => {
  it("opens and verifies screen staff_utilization_heatmap", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Staff Utilization Heatmap)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Staff Utilization Heatmap...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("staffutilizationheatmap-screen").should("be.visible");
  cy.getCy("staffutilizationheatmap-title").should("be.visible");
  cy.getCy("staffutilizationheatmap-content").should("be.visible");
  cy.getCy("staff-utilization-heatmap").should("be.visible");
  cy.getCy("btn-refresh-data").should("be.visible");
  cy.getCy("btn-adjust-shifts").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Staff Utilization Heatmap...");
  cy.waitAndSee();
  cy.screenshot("staff_utilization_heatmap");
  
  cy.task("log", "✅ PROGRESS: - Verified Staff Utilization Heatmap successfully!\n");

  });
});
