// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - social_worker", () => {
  it("tests all screens for role social_worker", () => {
    cy.loginAsRole("social_worker");


  
  cy.checkTestRegistry("socialworkerdashboard").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [1/4 | 25%] - Navigating to /offices/clinical/roles/social_worker/dashboard (SocialWorkerDashboardScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/social_worker/dashboard");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [1/4 | 25%] - Checking shell & content for /offices/clinical/roles/social_worker/dashboard (SocialWorkerDashboardScreen)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("socialworkerdashboard-screen").should("be.visible");
    cy.getCy("socialworkerdashboard-title").should("be.visible");
    cy.getCy("socialworkerdashboard-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [1/4 | 25%] - Saving screenshot for /offices/clinical/roles/social_worker/dashboard (SocialWorkerDashboardScreen)...");
    cy.waitAndSee();
    cy.screenshot("social_worker_dashboard");
    
    cy.updateTestRegistry("socialworkerdashboard", "PASS", "role_social_worker_all_screens.cy.js", "social_worker_dashboard");
    cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [1/4 | 25%] - Verified SocialWorkerDashboardScreen successfully!\n");
  });


  
  cy.checkTestRegistry("socialworkeranalytics").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [2/4 | 50%] - Navigating to /offices/clinical/roles/social_worker/analytics (SocialWorkerAnalyticsScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/social_worker/analytics");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [2/4 | 50%] - Checking shell & content for /offices/clinical/roles/social_worker/analytics (SocialWorkerAnalyticsScreen)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("socialworkeranalytics-screen").should("be.visible");
    cy.getCy("socialworkeranalytics-title").should("be.visible");
    cy.getCy("socialworkeranalytics-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [2/4 | 50%] - Saving screenshot for /offices/clinical/roles/social_worker/analytics (SocialWorkerAnalyticsScreen)...");
    cy.waitAndSee();
    cy.screenshot("social_worker_analytics");
    
    cy.updateTestRegistry("socialworkeranalytics", "PASS", "role_social_worker_all_screens.cy.js", "social_worker_analytics");
    cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [2/4 | 50%] - Verified SocialWorkerAnalyticsScreen successfully!\n");
  });


  
  cy.checkTestRegistry("socialworkercompliance").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [3/4 | 75%] - Navigating to /offices/clinical/roles/social_worker/compliance (SocialWorkerComplianceScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/social_worker/compliance");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [3/4 | 75%] - Checking shell & content for /offices/clinical/roles/social_worker/compliance (SocialWorkerComplianceScreen)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("socialworkercompliance-screen").should("be.visible");
    cy.getCy("socialworkercompliance-title").should("be.visible");
    cy.getCy("socialworkercompliance-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [3/4 | 75%] - Saving screenshot for /offices/clinical/roles/social_worker/compliance (SocialWorkerComplianceScreen)...");
    cy.waitAndSee();
    cy.screenshot("social_worker_compliance");
    
    cy.updateTestRegistry("socialworkercompliance", "PASS", "role_social_worker_all_screens.cy.js", "social_worker_compliance");
    cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [3/4 | 75%] - Verified SocialWorkerComplianceScreen successfully!\n");
  });


  
  cy.checkTestRegistry("socialworkerworkflow").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [4/4 | 100%] - Navigating to /offices/clinical/roles/social_worker/workflow (SocialWorkerWorkflowScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/social_worker/workflow");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [4/4 | 100%] - Checking shell & content for /offices/clinical/roles/social_worker/workflow (SocialWorkerWorkflowScreen)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("socialworkerworkflow-screen").should("be.visible");
    cy.getCy("socialworkerworkflow-title").should("be.visible");
    cy.getCy("socialworkerworkflow-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [4/4 | 100%] - Saving screenshot for /offices/clinical/roles/social_worker/workflow (SocialWorkerWorkflowScreen)...");
    cy.waitAndSee();
    cy.screenshot("social_worker_workflow");
    
    cy.updateTestRegistry("socialworkerworkflow", "PASS", "role_social_worker_all_screens.cy.js", "social_worker_workflow");
    cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [4/4 | 100%] - Verified SocialWorkerWorkflowScreen successfully!\n");
  });


  });
});
