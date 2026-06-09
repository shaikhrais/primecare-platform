// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - receptionist_dashboard", () => {
  it("opens and verifies screen receptionist_dashboard", () => {
    cy.loginAsRole("admin");

  cy.task("log", "⏳ PROGRESS: - Navigating to /staff/receptionist-dashboard (ReceptionistDashboardScreen)...");
  cy.visitWithSemantics("/staff/receptionist-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for ReceptionistDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("receptionistdashboard-screen").should("be.visible");
  cy.getCy("receptionistdashboard-title").should("be.visible");
  cy.getCy("receptionistdashboard-content").should("be.visible");
  cy.getCy("receptionist-dashboard-btn-add-appointment").should("be.visible");
  cy.getCy("receptionist-dashboard-btn-send-message").should("be.visible");
  cy.getCy("receptionist-dashboard-btn-upload-document").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for ReceptionistDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("receptionist_dashboard");
  
  cy.task("log", "✅ PROGRESS: - Verified ReceptionistDashboardScreen successfully!\n");

  });
});
