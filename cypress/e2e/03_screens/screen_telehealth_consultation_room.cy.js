// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - telehealth_consultation_room", () => {
  it("opens and verifies screen telehealth_consultation_room", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Telehealth Consultation Room)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Telehealth Consultation Room...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("telehealthconsultationroom-screen").should("be.visible");
  cy.getCy("telehealthconsultationroom-title").should("be.visible");
  cy.getCy("telehealthconsultationroom-content").should("be.visible");
  cy.getCy("telehealth-btn-start-consultation").should("be.visible");
  cy.getCy("telehealth-btn-schedule-followup").should("be.visible");
  cy.getCy("telehealth-btn-submit-feedback").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Telehealth Consultation Room...");
  cy.waitAndSee();
  cy.screenshot("telehealth_consultation_room");
  
  cy.task("log", "✅ PROGRESS: - Verified Telehealth Consultation Room successfully!\n");

  });
});
