// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - psw", () => {
  it("tests all screens for role psw", () => {
    cy.loginAsRole("psw");


  cy.task("log", "⏳ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/22 | 4%] - Navigating to /offices/clinical/roles/psw/dashboard (PswDashboardScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/psw/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/22 | 4%] - Checking shell & content for PswDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswdashboard-screen").should("be.visible");
  cy.getCy("pswdashboard-title").should("be.visible");
  cy.getCy("pswdashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/22 | 4%] - Saving screenshot for PswDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("psw_dashboard");
  
  cy.task("log", "✅ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/22 | 4%] - Verified PswDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/22 | 9%] - Navigating to /offices/clinical/roles/psw/psw-analytics (PswAnalyticsScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/psw/psw-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/22 | 9%] - Checking shell & content for PswAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswanalytics-screen").should("be.visible");
  cy.getCy("pswanalytics-title").should("be.visible");
  cy.getCy("pswanalytics-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/22 | 9%] - Saving screenshot for PswAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("psw_analytics");
  
  cy.task("log", "✅ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/22 | 9%] - Verified PswAnalyticsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/22 | 13%] - Navigating to /offices/clinical/roles/psw/patient-profile (PswClientsScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/psw/patient-profile");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/22 | 13%] - Checking shell & content for PswClientsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswclients-screen").should("be.visible");
  cy.getCy("pswclients-title").should("be.visible");
  cy.getCy("pswclients-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/22 | 13%] - Saving screenshot for PswClientsScreen...");
  cy.waitAndSee();
  cy.screenshot("psw_clients");
  
  cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/22 | 13%] - Verified PswClientsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [4/22 | 18%] - Navigating to /offices/clinical/roles/psw/psw-compliance (PswComplianceScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/psw/psw-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [4/22 | 18%] - Checking shell & content for PswComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswcompliance-screen").should("be.visible");
  cy.getCy("pswcompliance-title").should("be.visible");
  cy.getCy("pswcompliance-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [4/22 | 18%] - Saving screenshot for PswComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("psw_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [4/22 | 18%] - Verified PswComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [5/22 | 22%] - Navigating to /offices/clinical/roles/psw/messages (PswMessagesScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/psw/messages");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [5/22 | 22%] - Checking shell & content for PswMessagesScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswmessages-screen").should("be.visible");
  cy.getCy("pswmessages-title").should("be.visible");
  cy.getCy("pswmessages-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [5/22 | 22%] - Saving screenshot for PswMessagesScreen...");
  cy.waitAndSee();
  cy.screenshot("psw_messages");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [5/22 | 22%] - Verified PswMessagesScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [6/22 | 27%] - Navigating to /offices/clinical/roles/offices/clinical/roles/caregiver/psw-schedule (PswShiftTrackerScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/offices/clinical/roles/caregiver/psw-schedule");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [6/22 | 27%] - Checking shell & content for PswShiftTrackerScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswshifttracker-screen").should("be.visible");
  cy.getCy("pswshifttracker-title").should("be.visible");
  cy.getCy("pswshifttracker-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [6/22 | 27%] - Saving screenshot for PswShiftTrackerScreen...");
  cy.waitAndSee();
  cy.screenshot("psw_shift_tracker");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [6/22 | 27%] - Verified PswShiftTrackerScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [7/22 | 31%] - Navigating to /offices/clinical/roles/psw/visit-checklist (PswTasksScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/psw/visit-checklist");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [7/22 | 31%] - Checking shell & content for PswTasksScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswtasks-screen").should("be.visible");
  cy.getCy("pswtasks-title").should("be.visible");
  cy.getCy("pswtasks-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [7/22 | 31%] - Saving screenshot for PswTasksScreen...");
  cy.waitAndSee();
  cy.screenshot("psw_tasks");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [7/22 | 31%] - Verified PswTasksScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [8/22 | 36%] - Navigating to /offices/clinical/roles/psw/visit-notes (PswVisitNotesScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/psw/visit-notes");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [8/22 | 36%] - Checking shell & content for PswVisitNotesScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswvisitnotes-screen").should("be.visible");
  cy.getCy("pswvisitnotes-title").should("be.visible");
  cy.getCy("pswvisitnotes-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [8/22 | 36%] - Saving screenshot for PswVisitNotesScreen...");
  cy.waitAndSee();
  cy.screenshot("psw_visit_notes");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [8/22 | 36%] - Verified PswVisitNotesScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [9/22 | 40%] - Navigating to /offices/clinical/roles/psw/psw-workflow (PswWorkflowScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/psw/psw-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [9/22 | 40%] - Checking shell & content for PswWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswworkflow-screen").should("be.visible");
  cy.getCy("pswworkflow-title").should("be.visible");
  cy.getCy("pswworkflow-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [9/22 | 40%] - Saving screenshot for PswWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("psw_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [9/22 | 40%] - Verified PswWorkflowScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [10/22 | 45%] - Navigating to /offices/clinical/roles/psw/psw-command-center (PswCommandCenterScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/psw/psw-command-center");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [10/22 | 45%] - Checking shell & content for PswCommandCenterScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswcommandcenter-screen").should("be.visible");
  cy.getCy("pswcommandcenter-title").should("be.visible");
  cy.getCy("pswcommandcenter-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [10/22 | 45%] - Saving screenshot for PswCommandCenterScreen...");
  cy.waitAndSee();
  cy.screenshot("psw_command_center");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [10/22 | 45%] - Verified PswCommandCenterScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [11/22 | 50%] - Navigating to /offices/clinical/roles/psw/psw-my-shifts (PswMyShiftsScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/psw/psw-my-shifts");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [11/22 | 50%] - Checking shell & content for PswMyShiftsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswmyshifts-screen").should("be.visible");
  cy.getCy("pswmyshifts-title").should("be.visible");
  cy.getCy("pswmyshifts-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [11/22 | 50%] - Saving screenshot for PswMyShiftsScreen...");
  cy.waitAndSee();
  cy.screenshot("psw_my_shifts");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [11/22 | 50%] - Verified PswMyShiftsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [12/22 | 54%] - Navigating to /offices/clinical/roles/psw/psw-client-profile (PswClientProfileScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/psw/psw-client-profile");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [12/22 | 54%] - Checking shell & content for PswClientProfileScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswclientprofile-screen").should("be.visible");
  cy.getCy("pswclientprofile-title").should("be.visible");
  cy.getCy("pswclientprofile-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [12/22 | 54%] - Saving screenshot for PswClientProfileScreen...");
  cy.waitAndSee();
  cy.screenshot("psw_client_profile");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [12/22 | 54%] - Verified PswClientProfileScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [13/22 | 59%] - Navigating to /offices/clinical/roles/psw/visit-notes (PswVisitNotesScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/psw/visit-notes");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [13/22 | 59%] - Checking shell & content for PswVisitNotesScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswvisitnotes-screen").should("be.visible");
  cy.getCy("pswvisitnotes-title").should("be.visible");
  cy.getCy("pswvisitnotes-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [13/22 | 59%] - Saving screenshot for PswVisitNotesScreen...");
  cy.waitAndSee();
  cy.screenshot("psw_visit_notes");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [13/22 | 59%] - Verified PswVisitNotesScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [14/22 | 63%] - Navigating to /offices/clinical/roles/psw/observation-vitals-log (PswVitalsLogScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/psw/observation-vitals-log");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [14/22 | 63%] - Checking shell & content for PswVitalsLogScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswvitalslog-screen").should("be.visible");
  cy.getCy("pswvitalslog-title").should("be.visible");
  cy.getCy("pswvitalslog-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [14/22 | 63%] - Saving screenshot for PswVitalsLogScreen...");
  cy.waitAndSee();
  cy.screenshot("psw_vitals_log");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [14/22 | 63%] - Verified PswVitalsLogScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [15/22 | 68%] - Navigating to /offices/clinical/roles/psw/incident-report (PswIncidentReportScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/psw/incident-report");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [15/22 | 68%] - Checking shell & content for PswIncidentReportScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswincidentreport-screen").should("be.visible");
  cy.getCy("pswincidentreport-title").should("be.visible");
  cy.getCy("pswincidentreport-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [15/22 | 68%] - Saving screenshot for PswIncidentReportScreen...");
  cy.waitAndSee();
  cy.screenshot("psw_incident_report");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [15/22 | 68%] - Verified PswIncidentReportScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [16/22 | 72%] - Navigating to /offices/clinical/roles/psw/care-plan (PswCarePlanScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/psw/care-plan");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [16/22 | 72%] - Checking shell & content for PswCarePlanScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswcareplan-screen").should("be.visible");
  cy.getCy("pswcareplan-title").should("be.visible");
  cy.getCy("pswcareplan-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [16/22 | 72%] - Saving screenshot for PswCarePlanScreen...");
  cy.waitAndSee();
  cy.screenshot("psw_care_plan");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [16/22 | 72%] - Verified PswCarePlanScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [17/22 | 77%] - Navigating to /offices/clinical/roles/psw/messages (PswMessagesScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/psw/messages");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [17/22 | 77%] - Checking shell & content for PswMessagesScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswmessages-screen").should("be.visible");
  cy.getCy("pswmessages-title").should("be.visible");
  cy.getCy("pswmessages-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [17/22 | 77%] - Saving screenshot for PswMessagesScreen...");
  cy.waitAndSee();
  cy.screenshot("psw_messages");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [17/22 | 77%] - Verified PswMessagesScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [18/22 | 81%] - Navigating to /offices/clinical/roles/psw/documents (PswDocumentsScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/psw/documents");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [18/22 | 81%] - Checking shell & content for PswDocumentsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswdocuments-screen").should("be.visible");
  cy.getCy("pswdocuments-title").should("be.visible");
  cy.getCy("pswdocuments-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [18/22 | 81%] - Saving screenshot for PswDocumentsScreen...");
  cy.waitAndSee();
  cy.screenshot("psw_documents");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [18/22 | 81%] - Verified PswDocumentsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [19/22 | 86%] - Navigating to /offices/clinical/roles/psw/shift-tasks (ShiftTasksScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/psw/shift-tasks");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [19/22 | 86%] - Checking shell & content for ShiftTasksScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("shifttasks-screen").should("be.visible");
  cy.getCy("shifttasks-title").should("be.visible");
  cy.getCy("shifttasks-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [19/22 | 86%] - Saving screenshot for ShiftTasksScreen...");
  cy.waitAndSee();
  cy.screenshot("shift_tasks");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [19/22 | 86%] - Verified ShiftTasksScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [20/22 | 90%] - Navigating to /offices/clinical/roles/psw/visit-notes (VisitNotesScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/psw/visit-notes");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [20/22 | 90%] - Checking shell & content for VisitNotesScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("visitnotes-screen").should("be.visible");
  cy.getCy("visitnotes-title").should("be.visible");
  cy.getCy("visitnotes-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [20/22 | 90%] - Saving screenshot for VisitNotesScreen...");
  cy.waitAndSee();
  cy.screenshot("visit_notes");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [20/22 | 90%] - Verified VisitNotesScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [21/22 | 95%] - Navigating to /offices/clinical/roles/psw/vitals-entry (VitalsEntryScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/psw/vitals-entry");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [21/22 | 95%] - Checking shell & content for VitalsEntryScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("vitalsentry-screen").should("be.visible");
  cy.getCy("vitalsentry-title").should("be.visible");
  cy.getCy("vitalsentry-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [21/22 | 95%] - Saving screenshot for VitalsEntryScreen...");
  cy.waitAndSee();
  cy.screenshot("vitals_entry");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [21/22 | 95%] - Verified VitalsEntryScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [22/22 | 100%] - Navigating to /offices/clinical/roles/psw/incident-report (IncidentReportScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/psw/incident-report");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [22/22 | 100%] - Checking shell & content for IncidentReportScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("incidentreport-screen").should("be.visible");
  cy.getCy("incidentreport-title").should("be.visible");
  cy.getCy("incidentreport-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [22/22 | 100%] - Saving screenshot for IncidentReportScreen...");
  cy.waitAndSee();
  cy.screenshot("incident_report");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [22/22 | 100%] - Verified IncidentReportScreen successfully!\n");

  });
});
