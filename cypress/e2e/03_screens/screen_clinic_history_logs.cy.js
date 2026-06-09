// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - clinic_history_logs", () => {
  it("opens and verifies screen clinic_history_logs", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Clinic History Logs)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Clinic History Logs...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clinichistorylogs-screen").should("be.visible");
  cy.getCy("clinichistorylogs-title").should("be.visible");
  cy.getCy("clinichistorylogs-content").should("be.visible");
  cy.getCy("clinic-history-logs-list").should("be.visible");
  cy.getCy("loading-indicator").should("be.visible");
  cy.getCy("error-notification").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Clinic History Logs...");
  cy.waitAndSee();
  cy.screenshot("clinic_history_logs");
  
  cy.task("log", "✅ PROGRESS: - Verified Clinic History Logs successfully!\n");

  });
});
