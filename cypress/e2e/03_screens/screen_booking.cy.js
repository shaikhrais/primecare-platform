// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - booking", () => {
  it("opens and verifies screen booking", () => {
    cy.loginAsRole("intake");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/intake_coordinator/booking (BookingScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/intake_coordinator/booking");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for BookingScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("booking-screen").should("be.visible");
  cy.getCy("booking-title").should("be.visible");
  cy.getCy("booking-content").should("be.visible");
  cy.getCy("booking-btn-schedule").should("be.visible");
  cy.getCy("booking-btn-verify").should("be.visible");
  cy.getCy("booking-btn-log").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for BookingScreen...");
  cy.waitAndSee();
  cy.screenshot("booking");
  
  cy.task("log", "✅ PROGRESS: - Verified BookingScreen successfully!\n");

  });
});
