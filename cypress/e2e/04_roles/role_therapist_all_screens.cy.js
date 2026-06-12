// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - therapist", () => {
  it("tests all screens for role therapist", () => {
    cy.loginAsRole("therapist");


  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [1/1 | 100%] - Navigating to /offices/clinical/roles/therapist/dashboard (TherapistDashboardScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/therapist/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [1/1 | 100%] - Checking shell & content for TherapistDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("therapistdashboard-screen").should("be.visible");
  cy.getCy("therapistdashboard-title").should("be.visible");
  cy.getCy("therapistdashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [1/1 | 100%] - Saving screenshot for TherapistDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("therapist_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [1/1 | 100%] - Verified TherapistDashboardScreen successfully!\n");

  });
});
