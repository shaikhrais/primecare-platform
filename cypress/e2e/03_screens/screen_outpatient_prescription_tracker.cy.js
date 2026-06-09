// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - outpatient_prescription_tracker", () => {
  it("opens and verifies screen outpatient_prescription_tracker", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Outpatient Prescription Tracker)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Outpatient Prescription Tracker...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("outpatientprescriptiontracker-screen").should("be.visible");
  cy.getCy("outpatientprescriptiontracker-title").should("be.visible");
  cy.getCy("outpatientprescriptiontracker-content").should("be.visible");
  cy.getCy("outpatient-prescription-btn-update-status").should("be.visible");
  cy.getCy("outpatient-prescription-btn-view-details").should("be.visible");
  cy.getCy("outpatient-prescription-btn-generate-report").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Outpatient Prescription Tracker...");
  cy.waitAndSee();
  cy.screenshot("outpatient_prescription_tracker");
  
  cy.task("log", "✅ PROGRESS: - Verified Outpatient Prescription Tracker successfully!\n");

  });
});
