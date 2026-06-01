// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - hsw", () => {
  it("tests all screens for role hsw", () => {
    cy.loginAsRole("hsw");


  
  cy.checkTestRegistry("hswdashboard").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [1/5 | 20%] - Navigating to /clinical/hsw-dashboard (HswDashboardScreen)...");
    cy.visitWithSemantics("/clinical/hsw-dashboard");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [1/5 | 20%] - Checking shell & content for /clinical/hsw-dashboard (HswDashboardScreen)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("hswdashboard-screen").should("be.visible");
    cy.getCy("hswdashboard-title").should("be.visible");
    cy.getCy("hswdashboard-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [1/5 | 20%] - Saving screenshot for /clinical/hsw-dashboard (HswDashboardScreen)...");
    cy.waitAndSee();
    cy.screenshot("hsw_dashboard");
    
    cy.updateTestRegistry("hswdashboard", "PASS", "role_hsw_all_screens.cy.js", "hsw_dashboard");
    cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [1/5 | 20%] - Verified HswDashboardScreen successfully!\n");
  });


  
  cy.checkTestRegistry("hswadllogger").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [2/5 | 40%] - Navigating to /clinical/hsw-adl-logger (HswAdlLoggerScreen)...");
    cy.visitWithSemantics("/clinical/hsw-adl-logger");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [2/5 | 40%] - Checking shell & content for /clinical/hsw-adl-logger (HswAdlLoggerScreen)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("hswadllogger-screen").should("be.visible");
    cy.getCy("hswadllogger-title").should("be.visible");
    cy.getCy("hswadllogger-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [2/5 | 40%] - Saving screenshot for /clinical/hsw-adl-logger (HswAdlLoggerScreen)...");
    cy.waitAndSee();
    cy.screenshot("hsw_adl_logger");
    
    cy.updateTestRegistry("hswadllogger", "PASS", "role_hsw_all_screens.cy.js", "hsw_adl_logger");
    cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [2/5 | 40%] - Verified HswAdlLoggerScreen successfully!\n");
  });


  
  cy.checkTestRegistry("hswcareplans").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [3/5 | 60%] - Navigating to /clinical/hsw-care-plans (HswCarePlansScreen)...");
    cy.visitWithSemantics("/clinical/hsw-care-plans");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [3/5 | 60%] - Checking shell & content for /clinical/hsw-care-plans (HswCarePlansScreen)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("hswcareplans-screen").should("be.visible");
    cy.getCy("hswcareplans-title").should("be.visible");
    cy.getCy("hswcareplans-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [3/5 | 60%] - Saving screenshot for /clinical/hsw-care-plans (HswCarePlansScreen)...");
    cy.waitAndSee();
    cy.screenshot("hsw_care_plans");
    
    cy.updateTestRegistry("hswcareplans", "PASS", "role_hsw_all_screens.cy.js", "hsw_care_plans");
    cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [3/5 | 60%] - Verified HswCarePlansScreen successfully!\n");
  });


  
  cy.checkTestRegistry("hswincidentreports").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [4/5 | 80%] - Navigating to /clinical/hsw-incident-reports (HswIncidentReportsScreen)...");
    cy.visitWithSemantics("/clinical/hsw-incident-reports");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [4/5 | 80%] - Checking shell & content for /clinical/hsw-incident-reports (HswIncidentReportsScreen)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("hswincidentreports-screen").should("be.visible");
    cy.getCy("hswincidentreports-title").should("be.visible");
    cy.getCy("hswincidentreports-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [4/5 | 80%] - Saving screenshot for /clinical/hsw-incident-reports (HswIncidentReportsScreen)...");
    cy.waitAndSee();
    cy.screenshot("hsw_incident_reports");
    
    cy.updateTestRegistry("hswincidentreports", "PASS", "role_hsw_all_screens.cy.js", "hsw_incident_reports");
    cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [4/5 | 80%] - Verified HswIncidentReportsScreen successfully!\n");
  });


  
  cy.checkTestRegistry("hswschedule").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [5/5 | 100%] - Navigating to /clinical/hsw-schedule (HswScheduleScreen)...");
    cy.visitWithSemantics("/clinical/hsw-schedule");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [5/5 | 100%] - Checking shell & content for /clinical/hsw-schedule (HswScheduleScreen)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("hswschedule-screen").should("be.visible");
    cy.getCy("hswschedule-title").should("be.visible");
    cy.getCy("hswschedule-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [5/5 | 100%] - Saving screenshot for /clinical/hsw-schedule (HswScheduleScreen)...");
    cy.waitAndSee();
    cy.screenshot("hsw_schedule");
    
    cy.updateTestRegistry("hswschedule", "PASS", "role_hsw_all_screens.cy.js", "hsw_schedule");
    cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [5/5 | 100%] - Verified HswScheduleScreen successfully!\n");
  });


  });
});
