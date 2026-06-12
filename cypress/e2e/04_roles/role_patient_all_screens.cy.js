// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - patient", () => {
  it("tests all screens for role patient", () => {
    cy.loginAsRole("patient");


  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [1/2 | 50%] - Navigating to packages/primecare_ui/lib/src/screens/common/family_member_dashboard_screen.dart (FamilyMemberDashboardScreen)...");
  cy.visitWithSemantics("packages/primecare_ui/lib/src/screens/common/family_member_dashboard_screen.dart");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [1/2 | 50%] - Checking shell & content for FamilyMemberDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("familymemberdashboard-screen").should("be.visible");
  cy.getCy("familymemberdashboard-title").should("be.visible");
  cy.getCy("familymemberdashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [1/2 | 50%] - Saving screenshot for FamilyMemberDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("family_member_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [1/2 | 50%] - Verified FamilyMemberDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [2/2 | 100%] - Navigating to /offices/client/roles/client/dashboard (PatientDashboardScreen)...");
  cy.visitWithSemantics("/offices/client/roles/client/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [2/2 | 100%] - Checking shell & content for PatientDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("patientdashboard-screen").should("be.visible");
  cy.getCy("patientdashboard-title").should("be.visible");
  cy.getCy("patientdashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [2/2 | 100%] - Saving screenshot for PatientDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("patient_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [2/2 | 100%] - Verified PatientDashboardScreen successfully!\n");

  });
});
