// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - calendar_management", () => {
  it("opens and verifies screen calendar_management", () => {
    cy.loginAsRole("scheduler");

  cy.task("log", "⏳ PROGRESS: - Navigating to /staff/calendar-management (CalendarManagementScreen)...");
  cy.visitWithSemantics("/staff/calendar-management");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for CalendarManagementScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("calendarmanagement-screen").should("be.visible");
  cy.getCy("calendarmanagement-title").should("be.visible");
  cy.getCy("calendarmanagement-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for CalendarManagementScreen...");
  cy.waitAndSee();
  cy.screenshot("calendar_management");
  
  cy.task("log", "✅ PROGRESS: - Verified CalendarManagementScreen successfully!\n");

  });
});
