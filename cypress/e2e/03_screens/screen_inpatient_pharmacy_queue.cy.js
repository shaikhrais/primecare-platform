// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - inpatient_pharmacy_queue", () => {
  it("opens and verifies screen inpatient_pharmacy_queue", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Inpatient Pharmacy Queue)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Inpatient Pharmacy Queue...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("inpatientpharmacyqueue-screen").should("be.visible");
  cy.getCy("inpatientpharmacyqueue-title").should("be.visible");
  cy.getCy("inpatientpharmacyqueue-content").should("be.visible");
  cy.getCy("pharmacy-queue-list").should("be.visible");
  cy.getCy("btn-verify-prescription").should("be.visible");
  cy.getCy("btn-prepare-medication").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Inpatient Pharmacy Queue...");
  cy.waitAndSee();
  cy.screenshot("inpatient_pharmacy_queue");
  
  cy.task("log", "✅ PROGRESS: - Verified Inpatient Pharmacy Queue successfully!\n");

  });
});
