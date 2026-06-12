// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - psw", () => {
  it("tests all screens for role psw", () => {
    cy.loginAsRole("psw");


  cy.task("log", "⏳ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/36 | 2%] - Navigating to /offices/clinical/roles/psw/dashboard (PswDashboardScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/psw/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/36 | 2%] - Checking shell & content for PswDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswdashboard-screen").should("be.visible");
  cy.getCy("pswdashboard-title").should("be.visible");
  cy.getCy("pswdashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/36 | 2%] - Saving screenshot for PswDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("psw_dashboard");
  
  cy.task("log", "✅ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/36 | 2%] - Verified PswDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/36 | 5%] - Navigating to /offices/clinical/roles/psw/reports (PswAnalyticsScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/psw/reports");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/36 | 5%] - Checking shell & content for PswAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswanalytics-screen").should("be.visible");
  cy.getCy("pswanalytics-title").should("be.visible");
  cy.getCy("pswanalytics-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/36 | 5%] - Saving screenshot for PswAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("psw_analytics");
  
  cy.task("log", "✅ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/36 | 5%] - Verified PswAnalyticsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/36 | 8%] - Navigating to /offices/clinical/roles/psw/patient-profile (PswClientsScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/psw/patient-profile");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/36 | 8%] - Checking shell & content for PswClientsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswclients-screen").should("be.visible");
  cy.getCy("pswclients-title").should("be.visible");
  cy.getCy("pswclients-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/36 | 8%] - Saving screenshot for PswClientsScreen...");
  cy.waitAndSee();
  cy.screenshot("psw_clients");
  
  cy.task("log", "✅ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/36 | 8%] - Verified PswClientsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [4/36 | 11%] - Navigating to /offices/clinical/roles/psw/notifications (PswMessagesScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/psw/notifications");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [4/36 | 11%] - Checking shell & content for PswMessagesScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswmessages-screen").should("be.visible");
  cy.getCy("pswmessages-title").should("be.visible");
  cy.getCy("pswmessages-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [4/36 | 11%] - Saving screenshot for PswMessagesScreen...");
  cy.waitAndSee();
  cy.screenshot("psw_messages");
  
  cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [4/36 | 11%] - Verified PswMessagesScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [5/36 | 13%] - Navigating to /offices/clinical/roles/psw/check-in (PswShiftTrackerScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/psw/check-in");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [5/36 | 13%] - Checking shell & content for PswShiftTrackerScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswshifttracker-screen").should("be.visible");
  cy.getCy("pswshifttracker-title").should("be.visible");
  cy.getCy("pswshifttracker-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [5/36 | 13%] - Saving screenshot for PswShiftTrackerScreen...");
  cy.waitAndSee();
  cy.screenshot("psw_shift_tracker");
  
  cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [5/36 | 13%] - Verified PswShiftTrackerScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [6/36 | 16%] - Navigating to /offices/clinical/roles/psw/visit-checklist (PswTasksScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/psw/visit-checklist");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [6/36 | 16%] - Checking shell & content for PswTasksScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswtasks-screen").should("be.visible");
  cy.getCy("pswtasks-title").should("be.visible");
  cy.getCy("pswtasks-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [6/36 | 16%] - Saving screenshot for PswTasksScreen...");
  cy.waitAndSee();
  cy.screenshot("psw_tasks");
  
  cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [6/36 | 16%] - Verified PswTasksScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [7/36 | 19%] - Navigating to /offices/clinical/roles/psw/visit-notes (PswVisitNotesScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/psw/visit-notes");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [7/36 | 19%] - Checking shell & content for PswVisitNotesScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswvisitnotes-screen").should("be.visible");
  cy.getCy("pswvisitnotes-title").should("be.visible");
  cy.getCy("pswvisitnotes-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [7/36 | 19%] - Saving screenshot for PswVisitNotesScreen...");
  cy.waitAndSee();
  cy.screenshot("psw_visit_notes");
  
  cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [7/36 | 19%] - Verified PswVisitNotesScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [8/36 | 22%] - Navigating to /offices/clinical/roles/psw/psw-workflow (PswWorkflowScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/psw/psw-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [8/36 | 22%] - Checking shell & content for PswWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswworkflow-screen").should("be.visible");
  cy.getCy("pswworkflow-title").should("be.visible");
  cy.getCy("pswworkflow-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [8/36 | 22%] - Saving screenshot for PswWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("psw_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [8/36 | 22%] - Verified PswWorkflowScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [9/36 | 25%] - Navigating to /offices/clinical/roles/psw/system-logs (PswCommandCenterScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/psw/system-logs");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [9/36 | 25%] - Checking shell & content for PswCommandCenterScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswcommandcenter-screen").should("be.visible");
  cy.getCy("pswcommandcenter-title").should("be.visible");
  cy.getCy("pswcommandcenter-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [9/36 | 25%] - Saving screenshot for PswCommandCenterScreen...");
  cy.waitAndSee();
  cy.screenshot("psw_command_center");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [9/36 | 25%] - Verified PswCommandCenterScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [10/36 | 27%] - Navigating to /offices/clinical/roles/psw/psw-my-shifts (PswMyShiftsScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/psw/psw-my-shifts");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [10/36 | 27%] - Checking shell & content for PswMyShiftsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswmyshifts-screen").should("be.visible");
  cy.getCy("pswmyshifts-title").should("be.visible");
  cy.getCy("pswmyshifts-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [10/36 | 27%] - Saving screenshot for PswMyShiftsScreen...");
  cy.waitAndSee();
  cy.screenshot("psw_my_shifts");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [10/36 | 27%] - Verified PswMyShiftsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [11/36 | 30%] - Navigating to /offices/clinical/roles/psw/profile (PswClientProfileScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/psw/profile");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [11/36 | 30%] - Checking shell & content for PswClientProfileScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswclientprofile-screen").should("be.visible");
  cy.getCy("pswclientprofile-title").should("be.visible");
  cy.getCy("pswclientprofile-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [11/36 | 30%] - Saving screenshot for PswClientProfileScreen...");
  cy.waitAndSee();
  cy.screenshot("psw_client_profile");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [11/36 | 30%] - Verified PswClientProfileScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [12/36 | 33%] - Navigating to /offices/clinical/roles/psw/visit-notes (PswVisitNotesScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/psw/visit-notes");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [12/36 | 33%] - Checking shell & content for PswVisitNotesScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswvisitnotes-screen").should("be.visible");
  cy.getCy("pswvisitnotes-title").should("be.visible");
  cy.getCy("pswvisitnotes-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [12/36 | 33%] - Saving screenshot for PswVisitNotesScreen...");
  cy.waitAndSee();
  cy.screenshot("psw_visit_notes");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [12/36 | 33%] - Verified PswVisitNotesScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [13/36 | 36%] - Navigating to /offices/clinical/roles/psw/observation-vitals-log (PswVitalsLogScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/psw/observation-vitals-log");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [13/36 | 36%] - Checking shell & content for PswVitalsLogScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswvitalslog-screen").should("be.visible");
  cy.getCy("pswvitalslog-title").should("be.visible");
  cy.getCy("pswvitalslog-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [13/36 | 36%] - Saving screenshot for PswVitalsLogScreen...");
  cy.waitAndSee();
  cy.screenshot("psw_vitals_log");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [13/36 | 36%] - Verified PswVitalsLogScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [14/36 | 38%] - Navigating to /offices/clinical/roles/psw/incident-report (PswIncidentReportScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/psw/incident-report");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [14/36 | 38%] - Checking shell & content for PswIncidentReportScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswincidentreport-screen").should("be.visible");
  cy.getCy("pswincidentreport-title").should("be.visible");
  cy.getCy("pswincidentreport-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [14/36 | 38%] - Saving screenshot for PswIncidentReportScreen...");
  cy.waitAndSee();
  cy.screenshot("psw_incident_report");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [14/36 | 38%] - Verified PswIncidentReportScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [15/36 | 41%] - Navigating to /offices/clinical/roles/psw/care-plan (PswCarePlanScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/psw/care-plan");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [15/36 | 41%] - Checking shell & content for PswCarePlanScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswcareplan-screen").should("be.visible");
  cy.getCy("pswcareplan-title").should("be.visible");
  cy.getCy("pswcareplan-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [15/36 | 41%] - Saving screenshot for PswCarePlanScreen...");
  cy.waitAndSee();
  cy.screenshot("psw_care_plan");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [15/36 | 41%] - Verified PswCarePlanScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [16/36 | 44%] - Navigating to /offices/clinical/roles/psw/messages (PswMessagesScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/psw/messages");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [16/36 | 44%] - Checking shell & content for PswMessagesScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswmessages-screen").should("be.visible");
  cy.getCy("pswmessages-title").should("be.visible");
  cy.getCy("pswmessages-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [16/36 | 44%] - Saving screenshot for PswMessagesScreen...");
  cy.waitAndSee();
  cy.screenshot("psw_messages");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [16/36 | 44%] - Verified PswMessagesScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [17/36 | 47%] - Navigating to /offices/clinical/roles/psw/documents (PswDocumentsScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/psw/documents");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [17/36 | 47%] - Checking shell & content for PswDocumentsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswdocuments-screen").should("be.visible");
  cy.getCy("pswdocuments-title").should("be.visible");
  cy.getCy("pswdocuments-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [17/36 | 47%] - Saving screenshot for PswDocumentsScreen...");
  cy.waitAndSee();
  cy.screenshot("psw_documents");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [17/36 | 47%] - Verified PswDocumentsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [18/36 | 50%] - Navigating to /offices/clinical/roles/psw/shift-tasks (ShiftTasksScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/psw/shift-tasks");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [18/36 | 50%] - Checking shell & content for ShiftTasksScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("shifttasks-screen").should("be.visible");
  cy.getCy("shifttasks-title").should("be.visible");
  cy.getCy("shifttasks-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [18/36 | 50%] - Saving screenshot for ShiftTasksScreen...");
  cy.waitAndSee();
  cy.screenshot("shift_tasks");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [18/36 | 50%] - Verified ShiftTasksScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [19/36 | 52%] - Navigating to /offices/clinical/roles/psw/vitals-entry (VitalsEntryScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/psw/vitals-entry");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [19/36 | 52%] - Checking shell & content for VitalsEntryScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("vitalsentry-screen").should("be.visible");
  cy.getCy("vitalsentry-title").should("be.visible");
  cy.getCy("vitalsentry-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [19/36 | 52%] - Saving screenshot for VitalsEntryScreen...");
  cy.waitAndSee();
  cy.screenshot("vitals_entry");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [19/36 | 52%] - Verified VitalsEntryScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [20/36 | 55%] - Navigating to /clinic/messaging (MessagingScreen)...");
  cy.visitWithSemantics("/clinic/messaging");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [20/36 | 55%] - Checking shell & content for MessagingScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("messaging-screen").should("be.visible");
  cy.getCy("messaging-title").should("be.visible");
  cy.getCy("messaging-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [20/36 | 55%] - Saving screenshot for MessagingScreen...");
  cy.waitAndSee();
  cy.screenshot("messaging");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [20/36 | 55%] - Verified MessagingScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [21/36 | 58%] - Navigating to None (Psw Check In)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [21/36 | 58%] - Checking shell & content for Psw Check In...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("psw check in-screen").should("be.visible");
  cy.getCy("psw check in-title").should("be.visible");
  cy.getCy("psw check in-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [21/36 | 58%] - Saving screenshot for Psw Check In...");
  cy.waitAndSee();
  cy.screenshot("psw_check_in");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [21/36 | 58%] - Verified Psw Check In successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [22/36 | 61%] - Navigating to None (Psw Help Support)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [22/36 | 61%] - Checking shell & content for Psw Help Support...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("psw help support-screen").should("be.visible");
  cy.getCy("psw help support-title").should("be.visible");
  cy.getCy("psw help support-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [22/36 | 61%] - Saving screenshot for Psw Help Support...");
  cy.waitAndSee();
  cy.screenshot("psw_help_support");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [22/36 | 61%] - Verified Psw Help Support successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [23/36 | 63%] - Navigating to None (Psw Notifications)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [23/36 | 63%] - Checking shell & content for Psw Notifications...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("psw notifications-screen").should("be.visible");
  cy.getCy("psw notifications-title").should("be.visible");
  cy.getCy("psw notifications-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [23/36 | 63%] - Saving screenshot for Psw Notifications...");
  cy.waitAndSee();
  cy.screenshot("psw_notifications");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [23/36 | 63%] - Verified Psw Notifications successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [24/36 | 66%] - Navigating to None (Psw Observation Vitals Log)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [24/36 | 66%] - Checking shell & content for Psw Observation Vitals Log...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("psw observation vitals log-screen").should("be.visible");
  cy.getCy("psw observation vitals log-title").should("be.visible");
  cy.getCy("psw observation vitals log-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [24/36 | 66%] - Saving screenshot for Psw Observation Vitals Log...");
  cy.waitAndSee();
  cy.screenshot("psw_observation_vitals_log");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [24/36 | 66%] - Verified Psw Observation Vitals Log successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [25/36 | 69%] - Navigating to None (Psw Profile)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [25/36 | 69%] - Checking shell & content for Psw Profile...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("psw profile-screen").should("be.visible");
  cy.getCy("psw profile-title").should("be.visible");
  cy.getCy("psw profile-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [25/36 | 69%] - Saving screenshot for Psw Profile...");
  cy.waitAndSee();
  cy.screenshot("psw_profile");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [25/36 | 69%] - Verified Psw Profile successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [26/36 | 72%] - Navigating to None (Psw Reports)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [26/36 | 72%] - Checking shell & content for Psw Reports...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("psw reports-screen").should("be.visible");
  cy.getCy("psw reports-title").should("be.visible");
  cy.getCy("psw reports-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [26/36 | 72%] - Saving screenshot for Psw Reports...");
  cy.waitAndSee();
  cy.screenshot("psw_reports");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [26/36 | 72%] - Verified Psw Reports successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [27/36 | 75%] - Navigating to None (Psw Schedule)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [27/36 | 75%] - Checking shell & content for Psw Schedule...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("psw schedule-screen").should("be.visible");
  cy.getCy("psw schedule-title").should("be.visible");
  cy.getCy("psw schedule-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [27/36 | 75%] - Saving screenshot for Psw Schedule...");
  cy.waitAndSee();
  cy.screenshot("psw_schedule");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [27/36 | 75%] - Verified Psw Schedule successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [28/36 | 77%] - Navigating to None (Psw System Logs)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [28/36 | 77%] - Checking shell & content for Psw System Logs...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("psw system logs-screen").should("be.visible");
  cy.getCy("psw system logs-title").should("be.visible");
  cy.getCy("psw system logs-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [28/36 | 77%] - Saving screenshot for Psw System Logs...");
  cy.waitAndSee();
  cy.screenshot("psw_system_logs");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [28/36 | 77%] - Verified Psw System Logs successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [29/36 | 80%] - Navigating to None (Psw Visit Checklist)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [29/36 | 80%] - Checking shell & content for Psw Visit Checklist...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("psw visit checklist-screen").should("be.visible");
  cy.getCy("psw visit checklist-title").should("be.visible");
  cy.getCy("psw visit checklist-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [29/36 | 80%] - Saving screenshot for Psw Visit Checklist...");
  cy.waitAndSee();
  cy.screenshot("psw_visit_checklist");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [29/36 | 80%] - Verified Psw Visit Checklist successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [30/36 | 83%] - Navigating to None (Psw Care Dashboard)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [30/36 | 83%] - Checking shell & content for Psw Care Dashboard...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("psw care dashboard-screen").should("be.visible");
  cy.getCy("psw care dashboard-title").should("be.visible");
  cy.getCy("psw care dashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [30/36 | 83%] - Saving screenshot for Psw Care Dashboard...");
  cy.waitAndSee();
  cy.screenshot("psw_care_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [30/36 | 83%] - Verified Psw Care Dashboard successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [31/36 | 86%] - Navigating to None (Psw Daily Notes)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [31/36 | 86%] - Checking shell & content for Psw Daily Notes...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("psw daily notes-screen").should("be.visible");
  cy.getCy("psw daily notes-title").should("be.visible");
  cy.getCy("psw daily notes-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [31/36 | 86%] - Saving screenshot for Psw Daily Notes...");
  cy.waitAndSee();
  cy.screenshot("psw_daily_notes");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [31/36 | 86%] - Verified Psw Daily Notes successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [32/36 | 88%] - Navigating to None (Psw Messaging)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [32/36 | 88%] - Checking shell & content for Psw Messaging...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("psw messaging-screen").should("be.visible");
  cy.getCy("psw messaging-title").should("be.visible");
  cy.getCy("psw messaging-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [32/36 | 88%] - Saving screenshot for Psw Messaging...");
  cy.waitAndSee();
  cy.screenshot("psw_messaging");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [32/36 | 88%] - Verified Psw Messaging successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [33/36 | 91%] - Navigating to None (Psw My Clients)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [33/36 | 91%] - Checking shell & content for Psw My Clients...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("psw my clients-screen").should("be.visible");
  cy.getCy("psw my clients-title").should("be.visible");
  cy.getCy("psw my clients-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [33/36 | 91%] - Saving screenshot for Psw My Clients...");
  cy.waitAndSee();
  cy.screenshot("psw_my_clients");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [33/36 | 91%] - Verified Psw My Clients successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [34/36 | 94%] - Navigating to None (Psw Task List)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [34/36 | 94%] - Checking shell & content for Psw Task List...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("psw task list-screen").should("be.visible");
  cy.getCy("psw task list-title").should("be.visible");
  cy.getCy("psw task list-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [34/36 | 94%] - Saving screenshot for Psw Task List...");
  cy.waitAndSee();
  cy.screenshot("psw_task_list");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [34/36 | 94%] - Verified Psw Task List successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [35/36 | 97%] - Navigating to /clinic/incident-report (Incident Report)...");
  cy.visitWithSemantics("/clinic/incident-report");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [35/36 | 97%] - Checking shell & content for Incident Report...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("incident report-screen").should("be.visible");
  cy.getCy("incident report-title").should("be.visible");
  cy.getCy("incident report-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [35/36 | 97%] - Saving screenshot for Incident Report...");
  cy.waitAndSee();
  cy.screenshot("incident_report");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [35/36 | 97%] - Verified Incident Report successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [36/36 | 100%] - Navigating to /offices/clinical/roles/psw/visit-notes (Visit Notes)...");
  cy.visitWithSemantics("/offices/clinical/roles/psw/visit-notes");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [36/36 | 100%] - Checking shell & content for Visit Notes...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("visit notes-screen").should("be.visible");
  cy.getCy("visit notes-title").should("be.visible");
  cy.getCy("visit notes-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [36/36 | 100%] - Saving screenshot for Visit Notes...");
  cy.waitAndSee();
  cy.screenshot("visit_notes");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [36/36 | 100%] - Verified Visit Notes successfully!\n");

  });
});
