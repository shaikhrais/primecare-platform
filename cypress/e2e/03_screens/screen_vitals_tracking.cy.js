// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - vitals_tracking", () => {
  it("opens and verifies screen vitals_tracking", () => {
    cy.loginAsRole("rpn");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/rpn/vitals-tracking (VitalsTrackingScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/rpn/vitals-tracking");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for VitalsTrackingScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("vitalstracking-screen").should("be.visible");
  cy.getCy("vitalstracking-title").should("be.visible");
  cy.getCy("vitalstracking-content").should("be.visible");
  cy.getCy("vitals-tracking-btn-record-vital-signs").should("be.visible");
  cy.getCy("vitals-tracking-btn-administer-medication").should("be.visible");
  cy.getCy("vitals-tracking-btn-document-care").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for VitalsTrackingScreen...");
  cy.waitAndSee();
  cy.screenshot("vitals_tracking");
  
  cy.task("log", "✅ PROGRESS: - Verified VitalsTrackingScreen successfully!\n");

  });
});
