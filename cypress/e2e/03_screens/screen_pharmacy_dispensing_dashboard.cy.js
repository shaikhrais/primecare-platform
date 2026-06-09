// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - pharmacy_dispensing_dashboard", () => {
  it("opens and verifies screen pharmacy_dispensing_dashboard", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Pharmacy Dispensing Dashboard)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Pharmacy Dispensing Dashboard...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pharmacydispensingdashboard-screen").should("be.visible");
  cy.getCy("pharmacydispensingdashboard-title").should("be.visible");
  cy.getCy("pharmacydispensingdashboard-content").should("be.visible");
  cy.getCy("pharmacy-dashboard-btn-dispense").should("be.visible");
  cy.getCy("pharmacy-dashboard-btn-generate-report").should("be.visible");
  cy.getCy("pharmacy-dashboard-btn-track-inventory").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Pharmacy Dispensing Dashboard...");
  cy.waitAndSee();
  cy.screenshot("pharmacy_dispensing_dashboard");
  
  cy.task("log", "✅ PROGRESS: - Verified Pharmacy Dispensing Dashboard successfully!\n");

  });
});
