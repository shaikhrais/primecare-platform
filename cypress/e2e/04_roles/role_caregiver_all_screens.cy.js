// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - caregiver", () => {
  it("tests all screens for role caregiver", () => {
    cy.loginAsRole("caregiver");


  cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/8 | 12%] - Navigating to /offices/clinical/roles/caregiver/dashboard (CaregiverDashboardScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/caregiver/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/8 | 12%] - Checking shell & content for CaregiverDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("caregiverdashboard-screen").should("be.visible");
  cy.getCy("caregiverdashboard-title").should("be.visible");
  cy.getCy("caregiverdashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/8 | 12%] - Saving screenshot for CaregiverDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("caregiver_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/8 | 12%] - Verified CaregiverDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [2/8 | 25%] - Navigating to /offices/clinical/roles/caregiver/tasks (CaregiverTasksScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/caregiver/tasks");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [2/8 | 25%] - Checking shell & content for CaregiverTasksScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("caregivertasks-screen").should("be.visible");
  cy.getCy("caregivertasks-title").should("be.visible");
  cy.getCy("caregivertasks-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [2/8 | 25%] - Saving screenshot for CaregiverTasksScreen...");
  cy.waitAndSee();
  cy.screenshot("caregiver_tasks");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [2/8 | 25%] - Verified CaregiverTasksScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [3/8 | 37%] - Navigating to /offices/clinical/roles/caregiver/client-profile (CaregiverClientProfileScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/caregiver/client-profile");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [3/8 | 37%] - Checking shell & content for CaregiverClientProfileScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("caregiverclientprofile-screen").should("be.visible");
  cy.getCy("caregiverclientprofile-title").should("be.visible");
  cy.getCy("caregiverclientprofile-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [3/8 | 37%] - Saving screenshot for CaregiverClientProfileScreen...");
  cy.waitAndSee();
  cy.screenshot("caregiver_client_profile");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [3/8 | 37%] - Verified CaregiverClientProfileScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [4/8 | 50%] - Navigating to /offices/clinical/roles/caregiver/visit-notes (CaregiverVisitNotesScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/caregiver/visit-notes");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [4/8 | 50%] - Checking shell & content for CaregiverVisitNotesScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("caregivervisitnotes-screen").should("be.visible");
  cy.getCy("caregivervisitnotes-title").should("be.visible");
  cy.getCy("caregivervisitnotes-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [4/8 | 50%] - Saving screenshot for CaregiverVisitNotesScreen...");
  cy.waitAndSee();
  cy.screenshot("caregiver_visit_notes");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [4/8 | 50%] - Verified CaregiverVisitNotesScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [5/8 | 62%] - Navigating to /offices/clinical/roles/caregiver/schedule (CaregiverScheduleScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/caregiver/schedule");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [5/8 | 62%] - Checking shell & content for CaregiverScheduleScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("caregiverschedule-screen").should("be.visible");
  cy.getCy("caregiverschedule-title").should("be.visible");
  cy.getCy("caregiverschedule-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [5/8 | 62%] - Saving screenshot for CaregiverScheduleScreen...");
  cy.waitAndSee();
  cy.screenshot("caregiver_schedule");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [5/8 | 62%] - Verified CaregiverScheduleScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [6/8 | 75%] - Navigating to /offices/clinical/roles/caregiver/incident-report (CaregiverIncidentReportScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/caregiver/incident-report");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [6/8 | 75%] - Checking shell & content for CaregiverIncidentReportScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("caregiverincidentreport-screen").should("be.visible");
  cy.getCy("caregiverincidentreport-title").should("be.visible");
  cy.getCy("caregiverincidentreport-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [6/8 | 75%] - Saving screenshot for CaregiverIncidentReportScreen...");
  cy.waitAndSee();
  cy.screenshot("caregiver_incident_report");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [6/8 | 75%] - Verified CaregiverIncidentReportScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [7/8 | 87%] - Navigating to /offices/clinical/roles/caregiver/psw-schedule (ScheduleScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/caregiver/psw-schedule");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [7/8 | 87%] - Checking shell & content for ScheduleScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("schedule-screen").should("be.visible");
  cy.getCy("schedule-title").should("be.visible");
  cy.getCy("schedule-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [7/8 | 87%] - Saving screenshot for ScheduleScreen...");
  cy.waitAndSee();
  cy.screenshot("schedule");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [7/8 | 87%] - Verified ScheduleScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [8/8 | 100%] - Navigating to /offices/clinical/roles/caregiver/messaging (MessagingScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/caregiver/messaging");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [8/8 | 100%] - Checking shell & content for MessagingScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("messaging-screen").should("be.visible");
  cy.getCy("messaging-title").should("be.visible");
  cy.getCy("messaging-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [8/8 | 100%] - Saving screenshot for MessagingScreen...");
  cy.waitAndSee();
  cy.screenshot("messaging");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [8/8 | 100%] - Verified MessagingScreen successfully!\n");

  });
});
