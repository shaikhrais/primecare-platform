// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - clinical_director", () => {
  it("tests all screens for role clinical_director", () => {
    cy.loginAsRole("clinical_director");


  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [1/3 | 33%] - Navigating to /offices/clinical/roles/clinical_director/dashboard-dup-1 (ClinicalDashboardScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/clinical_director/dashboard-dup-1");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [1/3 | 33%] - Checking shell & content for ClinicalDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clinicaldashboard-screen").should("be.visible");
  cy.getCy("clinicaldashboard-title").should("be.visible");
  cy.getCy("clinicaldashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [1/3 | 33%] - Saving screenshot for ClinicalDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("clinical_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [1/3 | 33%] - Verified ClinicalDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [2/3 | 66%] - Navigating to /offices/clinical/roles/clinical_director/dashboard (ClinicalDirectorDashboardScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/clinical_director/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [2/3 | 66%] - Checking shell & content for ClinicalDirectorDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clinicaldirectordashboard-screen").should("be.visible");
  cy.getCy("clinicaldirectordashboard-title").should("be.visible");
  // cy.getCy("clinicaldirectordashboard-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [2/3 | 66%] - Saving screenshot for ClinicalDirectorDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("clinical_director_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [2/3 | 66%] - Verified ClinicalDirectorDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [3/3 | 100%] - Navigating to /offices/clinical/roles/clinical_director/clinic-dashboard (ClinicDashboardScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/clinical_director/clinic-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [3/3 | 100%] - Checking shell & content for ClinicDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clinicdashboard-screen").should("be.visible");
  cy.getCy("clinicdashboard-title").should("be.visible");
  cy.getCy("clinicdashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [3/3 | 100%] - Saving screenshot for ClinicDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("clinic_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [3/3 | 100%] - Verified ClinicDashboardScreen successfully!\n");

  });
});
