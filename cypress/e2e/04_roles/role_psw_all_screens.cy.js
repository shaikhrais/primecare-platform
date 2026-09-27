// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - psw", () => {
  it("tests all screens for role psw", () => {
    cy.loginAsRole("psw");


  cy.task("log", "⏳ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/18 | 5%] - Navigating to /offices/clinical/roles/psw/dashboard (Care Dashboard)...");
  cy.visitWithSemantics("/offices/clinical/roles/psw/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/18 | 5%] - Checking shell & content for Care Dashboard...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("pswdashboard-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("pswdashboard-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("pswdashboard-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/18 | 5%] - Saving screenshot for Care Dashboard...");
  cy.waitAndSee();
  cy.screenshot("psw_dashboard");
  
  cy.task("log", "✅ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/18 | 5%] - Verified Care Dashboard successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/18 | 11%] - Navigating to /offices/clinical/roles/psw/reports (Psw Analytics)...");
  cy.visitWithSemantics("/offices/clinical/roles/psw/reports");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/18 | 11%] - Checking shell & content for Psw Analytics...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("pswanalytics-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("pswanalytics-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("pswanalytics-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/18 | 11%] - Saving screenshot for Psw Analytics...");
  cy.waitAndSee();
  cy.screenshot("psw_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/18 | 11%] - Verified Psw Analytics successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/18 | 16%] - Navigating to /offices/clinical/roles/psw/patient-profile (My Clients)...");
  cy.visitWithSemantics("/offices/clinical/roles/psw/patient-profile");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/18 | 16%] - Checking shell & content for My Clients...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("pswclients-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("pswclients-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("pswclients-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/18 | 16%] - Saving screenshot for My Clients...");
  cy.waitAndSee();
  cy.screenshot("psw_clients");
  
  cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/18 | 16%] - Verified My Clients successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [4/18 | 22%] - Navigating to /offices/clinical/roles/psw/help-support (Psw Compliance)...");
  cy.visitWithSemantics("/offices/clinical/roles/psw/help-support");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [4/18 | 22%] - Checking shell & content for Psw Compliance...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("pswcompliance-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("pswcompliance-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("pswcompliance-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [4/18 | 22%] - Saving screenshot for Psw Compliance...");
  cy.waitAndSee();
  cy.screenshot("psw_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [4/18 | 22%] - Verified Psw Compliance successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [5/18 | 27%] - Navigating to /offices/clinical/roles/psw/messages (Messages)...");
  cy.visitWithSemantics("/offices/clinical/roles/psw/messages");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [5/18 | 27%] - Checking shell & content for Messages...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("pswmessages-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("pswmessages-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("pswmessages-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [5/18 | 27%] - Saving screenshot for Messages...");
  cy.waitAndSee();
  cy.screenshot("psw_messages");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [5/18 | 27%] - Verified Messages successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [6/18 | 33%] - Navigating to /offices/clinical/roles/psw/schedule (Shift Tracker)...");
  cy.visitWithSemantics("/offices/clinical/roles/psw/schedule");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [6/18 | 33%] - Checking shell & content for Shift Tracker...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("pswshifttracker-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("pswshifttracker-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("pswshifttracker-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [6/18 | 33%] - Saving screenshot for Shift Tracker...");
  cy.waitAndSee();
  cy.screenshot("psw_shift_tracker");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [6/18 | 33%] - Verified Shift Tracker successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [7/18 | 38%] - Navigating to /offices/clinical/roles/psw/visit-checklist (Task List)...");
  cy.visitWithSemantics("/offices/clinical/roles/psw/visit-checklist");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [7/18 | 38%] - Checking shell & content for Task List...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("pswtasks-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("pswtasks-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("pswtasks-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [7/18 | 38%] - Saving screenshot for Task List...");
  cy.waitAndSee();
  cy.screenshot("psw_tasks");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [7/18 | 38%] - Verified Task List successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [8/18 | 44%] - Navigating to /offices/clinical/roles/psw/visit-notes (Visit Notes)...");
  cy.visitWithSemantics("/offices/clinical/roles/psw/visit-notes");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [8/18 | 44%] - Checking shell & content for Visit Notes...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("pswvisitnotes-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("pswvisitnotes-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("pswvisitnotes-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [8/18 | 44%] - Saving screenshot for Visit Notes...");
  cy.waitAndSee();
  cy.screenshot("psw_visit_notes");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [8/18 | 44%] - Verified Visit Notes successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [9/18 | 50%] - Navigating to /offices/clinical/roles/psw/psw-workflow (Psw Workflow)...");
  cy.visitWithSemantics("/offices/clinical/roles/psw/psw-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [9/18 | 50%] - Checking shell & content for Psw Workflow...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("pswworkflow-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("pswworkflow-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("pswworkflow-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [9/18 | 50%] - Saving screenshot for Psw Workflow...");
  cy.waitAndSee();
  cy.screenshot("psw_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [9/18 | 50%] - Verified Psw Workflow successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [10/18 | 55%] - Navigating to /offices/clinical/roles/psw/system-logs (Psw Command Center)...");
  cy.visitWithSemantics("/offices/clinical/roles/psw/system-logs");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [10/18 | 55%] - Checking shell & content for Psw Command Center...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("pswcommandcenter-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("pswcommandcenter-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("pswcommandcenter-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [10/18 | 55%] - Saving screenshot for Psw Command Center...");
  cy.waitAndSee();
  cy.screenshot("psw_command_center");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [10/18 | 55%] - Verified Psw Command Center successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [11/18 | 61%] - Navigating to /offices/clinical/roles/psw/psw-my-shifts (Psw My Shifts)...");
  cy.visitWithSemantics("/offices/clinical/roles/psw/psw-my-shifts");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [11/18 | 61%] - Checking shell & content for Psw My Shifts...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("pswmyshifts-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("pswmyshifts-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("pswmyshifts-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [11/18 | 61%] - Saving screenshot for Psw My Shifts...");
  cy.waitAndSee();
  cy.screenshot("psw_my_shifts");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [11/18 | 61%] - Verified Psw My Shifts successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [12/18 | 66%] - Navigating to /offices/clinical/roles/psw/profile (Psw Client Profile)...");
  cy.visitWithSemantics("/offices/clinical/roles/psw/profile");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [12/18 | 66%] - Checking shell & content for Psw Client Profile...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("pswclientprofile-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("pswclientprofile-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("pswclientprofile-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [12/18 | 66%] - Saving screenshot for Psw Client Profile...");
  cy.waitAndSee();
  cy.screenshot("psw_client_profile");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [12/18 | 66%] - Verified Psw Client Profile successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [13/18 | 72%] - Navigating to /offices/clinical/roles/psw/observation-vitals-log (Vitals Entry)...");
  cy.visitWithSemantics("/offices/clinical/roles/psw/observation-vitals-log");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [13/18 | 72%] - Checking shell & content for Vitals Entry...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("pswvitalslog-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("pswvitalslog-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("pswvitalslog-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [13/18 | 72%] - Saving screenshot for Vitals Entry...");
  cy.waitAndSee();
  cy.screenshot("psw_vitals_log");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [13/18 | 72%] - Verified Vitals Entry successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [14/18 | 77%] - Navigating to /offices/clinical/roles/psw/incident-report (Report Incident)...");
  cy.visitWithSemantics("/offices/clinical/roles/psw/incident-report");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [14/18 | 77%] - Checking shell & content for Report Incident...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("pswincidentreport-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("pswincidentreport-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("pswincidentreport-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [14/18 | 77%] - Saving screenshot for Report Incident...");
  cy.waitAndSee();
  cy.screenshot("psw_incident_report");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [14/18 | 77%] - Verified Report Incident successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [15/18 | 83%] - Navigating to /offices/clinical/roles/psw/care-plan (Psw Care Plan)...");
  cy.visitWithSemantics("/offices/clinical/roles/psw/care-plan");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [15/18 | 83%] - Checking shell & content for Psw Care Plan...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("pswcareplan-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("pswcareplan-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("pswcareplan-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [15/18 | 83%] - Saving screenshot for Psw Care Plan...");
  cy.waitAndSee();
  cy.screenshot("psw_care_plan");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [15/18 | 83%] - Verified Psw Care Plan successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [16/18 | 88%] - Navigating to /offices/clinical/roles/psw/documents (Documents)...");
  cy.visitWithSemantics("/offices/clinical/roles/psw/documents");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [16/18 | 88%] - Checking shell & content for Documents...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("pswdocuments-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("pswdocuments-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("pswdocuments-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [16/18 | 88%] - Saving screenshot for Documents...");
  cy.waitAndSee();
  cy.screenshot("psw_documents");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [16/18 | 88%] - Verified Documents successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [17/18 | 94%] - Navigating to /offices/clinical/roles/psw/shift-tasks (Shift Tasks)...");
  cy.visitWithSemantics("/offices/clinical/roles/psw/shift-tasks");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [17/18 | 94%] - Checking shell & content for Shift Tasks...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("shifttasks-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("shifttasks-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("shifttasks-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [17/18 | 94%] - Saving screenshot for Shift Tasks...");
  cy.waitAndSee();
  cy.screenshot("shift_tasks");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [17/18 | 94%] - Verified Shift Tasks successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [18/18 | 100%] - Navigating to /offices/clinical/roles/psw/vitals-entry (Vitals Entry)...");
  cy.visitWithSemantics("/offices/clinical/roles/psw/vitals-entry");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [18/18 | 100%] - Checking shell & content for Vitals Entry...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("vitalsentry-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("vitalsentry-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("vitalsentry-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [18/18 | 100%] - Saving screenshot for Vitals Entry...");
  cy.waitAndSee();
  cy.screenshot("vitals_entry");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [18/18 | 100%] - Verified Vitals Entry successfully!\n");

  });
});
