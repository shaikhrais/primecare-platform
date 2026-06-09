// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - patient_book_appointment", () => {
  it("opens and verifies screen patient_book_appointment", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/client/roles/client/book-appointment (Patient Book Appointment)...");
  cy.visitWithSemantics("/offices/client/roles/client/book-appointment");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Patient Book Appointment...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("patientbookappointment-screen").should("be.visible");
  cy.getCy("patientbookappointment-title").should("be.visible");
  cy.getCy("patientbookappointment-content").should("be.visible");
  cy.getCy("patient-book-appointment-loading").should("be.visible");
  cy.getCy("patient-book-appointment-error").should("be.visible");
  cy.getCy("patient-book-appointment-confirmation").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Patient Book Appointment...");
  cy.waitAndSee();
  cy.screenshot("patient_book_appointment");
  
  cy.task("log", "✅ PROGRESS: - Verified Patient Book Appointment successfully!\n");

  });
});
