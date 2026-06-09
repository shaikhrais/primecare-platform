// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - client_book_appointment", () => {
  it("opens and verifies screen client_book_appointment", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Client Book Appointment)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Client Book Appointment...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clientbookappointment-screen").should("be.visible");
  cy.getCy("clientbookappointment-title").should("be.visible");
  cy.getCy("clientbookappointment-content").should("be.visible");
  cy.getCy("client-book-appointment-loading").should("be.visible");
  cy.getCy("client-book-appointment-error").should("be.visible");
  cy.getCy("client-book-appointment-confirmation").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Client Book Appointment...");
  cy.waitAndSee();
  cy.screenshot("client_book_appointment");
  
  cy.task("log", "✅ PROGRESS: - Verified Client Book Appointment successfully!\n");

  });
});
