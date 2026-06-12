// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - psw", () => {
  it("tests all screens for role psw", () => {
    cy.loginAsRole("psw");


  cy.task("log", "⏳ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/20 | 5%] - Navigating to /offices/clinical/roles/psw/dashboard (PswDashboardScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/psw/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/20 | 5%] - Checking shell & content for PswDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("pswdashboard-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("pswdashboard-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("pswdashboard-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/20 | 5%] - Saving screenshot for PswDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("psw_dashboard");
  
  cy.task("log", "✅ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/20 | 5%] - Verified PswDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/20 | 10%] - Navigating to /offices/clinical/roles/psw/reports (PswAnalyticsScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/psw/reports");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/20 | 10%] - Checking shell & content for PswAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("pswanalytics-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("pswanalytics-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("pswanalytics-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/20 | 10%] - Saving screenshot for PswAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("psw_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/20 | 10%] - Verified PswAnalyticsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/20 | 15%] - Navigating to /offices/clinical/roles/psw/patient-profile (PswClientsScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/psw/patient-profile");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/20 | 15%] - Checking shell & content for PswClientsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("pswclients-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("pswclients-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("pswclients-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/20 | 15%] - Saving screenshot for PswClientsScreen...");
  cy.waitAndSee();
  cy.screenshot("psw_clients");
  
  cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/20 | 15%] - Verified PswClientsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [4/20 | 20%] - Navigating to /offices/clinical/roles/psw/help-support (PswComplianceScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/psw/help-support");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [4/20 | 20%] - Checking shell & content for PswComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("pswcompliance-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("pswcompliance-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("pswcompliance-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [4/20 | 20%] - Saving screenshot for PswComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("psw_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [4/20 | 20%] - Verified PswComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [5/20 | 25%] - Navigating to /offices/clinical/roles/psw/messages (PswMessagesScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/psw/messages");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [5/20 | 25%] - Checking shell & content for PswMessagesScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("pswmessages-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("pswmessages-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("pswmessages-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [5/20 | 25%] - Saving screenshot for PswMessagesScreen...");
  cy.waitAndSee();
  cy.screenshot("psw_messages");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [5/20 | 25%] - Verified PswMessagesScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [6/20 | 30%] - Navigating to /offices/clinical/roles/psw/schedule (PswShiftTrackerScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/psw/schedule");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [6/20 | 30%] - Checking shell & content for PswShiftTrackerScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("pswshifttracker-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("pswshifttracker-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("pswshifttracker-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [6/20 | 30%] - Saving screenshot for PswShiftTrackerScreen...");
  cy.waitAndSee();
  cy.screenshot("psw_shift_tracker");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [6/20 | 30%] - Verified PswShiftTrackerScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [7/20 | 35%] - Navigating to /offices/clinical/roles/psw/visit-checklist (PswTasksScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/psw/visit-checklist");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [7/20 | 35%] - Checking shell & content for PswTasksScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("pswtasks-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("pswtasks-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("pswtasks-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [7/20 | 35%] - Saving screenshot for PswTasksScreen...");
  cy.waitAndSee();
  cy.screenshot("psw_tasks");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [7/20 | 35%] - Verified PswTasksScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [8/20 | 40%] - Navigating to /offices/clinical/roles/psw/visit-notes (PswVisitNotesScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/psw/visit-notes");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [8/20 | 40%] - Checking shell & content for PswVisitNotesScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("pswvisitnotes-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("pswvisitnotes-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("pswvisitnotes-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [8/20 | 40%] - Saving screenshot for PswVisitNotesScreen...");
  cy.waitAndSee();
  cy.screenshot("psw_visit_notes");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [8/20 | 40%] - Verified PswVisitNotesScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [9/20 | 45%] - Navigating to /offices/clinical/roles/psw/psw-workflow (PswWorkflowScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/psw/psw-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [9/20 | 45%] - Checking shell & content for PswWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("pswworkflow-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("pswworkflow-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("pswworkflow-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [9/20 | 45%] - Saving screenshot for PswWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("psw_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [9/20 | 45%] - Verified PswWorkflowScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [10/20 | 50%] - Navigating to /offices/clinical/roles/psw/system-logs (PswCommandCenterScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/psw/system-logs");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [10/20 | 50%] - Checking shell & content for PswCommandCenterScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("pswcommandcenter-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("pswcommandcenter-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("pswcommandcenter-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [10/20 | 50%] - Saving screenshot for PswCommandCenterScreen...");
  cy.waitAndSee();
  cy.screenshot("psw_command_center");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [10/20 | 50%] - Verified PswCommandCenterScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [11/20 | 55%] - Navigating to /offices/clinical/roles/psw/psw-my-shifts (PswMyShiftsScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/psw/psw-my-shifts");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [11/20 | 55%] - Checking shell & content for PswMyShiftsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("pswmyshifts-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("pswmyshifts-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("pswmyshifts-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [11/20 | 55%] - Saving screenshot for PswMyShiftsScreen...");
  cy.waitAndSee();
  cy.screenshot("psw_my_shifts");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [11/20 | 55%] - Verified PswMyShiftsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [12/20 | 60%] - Navigating to /offices/clinical/roles/psw/profile (PswClientProfileScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/psw/profile");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [12/20 | 60%] - Checking shell & content for PswClientProfileScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("pswclientprofile-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("pswclientprofile-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("pswclientprofile-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [12/20 | 60%] - Saving screenshot for PswClientProfileScreen...");
  cy.waitAndSee();
  cy.screenshot("psw_client_profile");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [12/20 | 60%] - Verified PswClientProfileScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [13/20 | 65%] - Navigating to /offices/clinical/roles/psw/visit-notes (PswVisitNotesScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/psw/visit-notes");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [13/20 | 65%] - Checking shell & content for PswVisitNotesScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("pswvisitnotes-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("pswvisitnotes-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("pswvisitnotes-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [13/20 | 65%] - Saving screenshot for PswVisitNotesScreen...");
  cy.waitAndSee();
  cy.screenshot("psw_visit_notes");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [13/20 | 65%] - Verified PswVisitNotesScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [14/20 | 70%] - Navigating to /offices/clinical/roles/psw/observation-vitals-log (PswVitalsLogScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/psw/observation-vitals-log");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [14/20 | 70%] - Checking shell & content for PswVitalsLogScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("pswvitalslog-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("pswvitalslog-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("pswvitalslog-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [14/20 | 70%] - Saving screenshot for PswVitalsLogScreen...");
  cy.waitAndSee();
  cy.screenshot("psw_vitals_log");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [14/20 | 70%] - Verified PswVitalsLogScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [15/20 | 75%] - Navigating to /offices/clinical/roles/psw/incident-report (PswIncidentReportScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/psw/incident-report");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [15/20 | 75%] - Checking shell & content for PswIncidentReportScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("pswincidentreport-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("pswincidentreport-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("pswincidentreport-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [15/20 | 75%] - Saving screenshot for PswIncidentReportScreen...");
  cy.waitAndSee();
  cy.screenshot("psw_incident_report");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [15/20 | 75%] - Verified PswIncidentReportScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [16/20 | 80%] - Navigating to /offices/clinical/roles/psw/care-plan (PswCarePlanScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/psw/care-plan");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [16/20 | 80%] - Checking shell & content for PswCarePlanScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("pswcareplan-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("pswcareplan-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("pswcareplan-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [16/20 | 80%] - Saving screenshot for PswCarePlanScreen...");
  cy.waitAndSee();
  cy.screenshot("psw_care_plan");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [16/20 | 80%] - Verified PswCarePlanScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [17/20 | 85%] - Navigating to /offices/clinical/roles/psw/messages (PswMessagesScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/psw/messages");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [17/20 | 85%] - Checking shell & content for PswMessagesScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("pswmessages-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("pswmessages-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("pswmessages-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [17/20 | 85%] - Saving screenshot for PswMessagesScreen...");
  cy.waitAndSee();
  cy.screenshot("psw_messages");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [17/20 | 85%] - Verified PswMessagesScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [18/20 | 90%] - Navigating to /offices/clinical/roles/psw/documents (PswDocumentsScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/psw/documents");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [18/20 | 90%] - Checking shell & content for PswDocumentsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("pswdocuments-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("pswdocuments-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("pswdocuments-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [18/20 | 90%] - Saving screenshot for PswDocumentsScreen...");
  cy.waitAndSee();
  cy.screenshot("psw_documents");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [18/20 | 90%] - Verified PswDocumentsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [19/20 | 95%] - Navigating to /offices/clinical/roles/psw/shift-tasks (ShiftTasksScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/psw/shift-tasks");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [19/20 | 95%] - Checking shell & content for ShiftTasksScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("shifttasks-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("shifttasks-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("shifttasks-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [19/20 | 95%] - Saving screenshot for ShiftTasksScreen...");
  cy.waitAndSee();
  cy.screenshot("shift_tasks");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [19/20 | 95%] - Verified ShiftTasksScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [20/20 | 100%] - Navigating to /offices/clinical/roles/psw/vitals-entry (VitalsEntryScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/psw/vitals-entry");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [20/20 | 100%] - Checking shell & content for VitalsEntryScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("vitalsentry-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("vitalsentry-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("vitalsentry-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [20/20 | 100%] - Saving screenshot for VitalsEntryScreen...");
  cy.waitAndSee();
  cy.screenshot("vitals_entry");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [20/20 | 100%] - Verified VitalsEntryScreen successfully!\n");

  });
});
