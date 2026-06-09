// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - mobile_clinic_dispatch", () => {
  it("opens and verifies screen mobile_clinic_dispatch", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Mobile Clinic Dispatch)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Mobile Clinic Dispatch...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("mobileclinicdispatch-screen").should("be.visible");
  cy.getCy("mobileclinicdispatch-title").should("be.visible");
  cy.getCy("mobileclinicdispatch-content").should("be.visible");
  cy.getCy("mobile-clinic-btn-schedule").should("be.visible");
  cy.getCy("mobile-clinic-btn-assign").should("be.visible");
  cy.getCy("mobile-clinic-btn-generate-report").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Mobile Clinic Dispatch...");
  cy.waitAndSee();
  cy.screenshot("mobile_clinic_dispatch");
  
  cy.task("log", "✅ PROGRESS: - Verified Mobile Clinic Dispatch successfully!\n");

  });
});
