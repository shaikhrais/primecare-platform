// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - intake", () => {
  it("tests all screens for role intake", () => {
    cy.loginAsRole("intake");


  
  cy.checkTestRegistry("intakedashboard").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/12 | 8%] - Navigating to /offices/clinical/roles/intake_coordinator/dashboard (IntakeDashboardScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/intake_coordinator/dashboard");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/12 | 8%] - Checking shell & content for /offices/clinical/roles/intake_coordinator/dashboard (IntakeDashboardScreen)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("intakedashboard-screen").should("be.visible");
    cy.getCy("intakedashboard-title").should("be.visible");
    cy.getCy("intakedashboard-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/12 | 8%] - Saving screenshot for /offices/clinical/roles/intake_coordinator/dashboard (IntakeDashboardScreen)...");
    cy.waitAndSee();
    cy.screenshot("intake_dashboard");
    
    cy.updateTestRegistry("intakedashboard", "PASS", "role_intake_all_screens.cy.js", "intake_dashboard");
    cy.task("log", "✅ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/12 | 8%] - Verified IntakeDashboardScreen successfully!\n");
  });


  
  cy.checkTestRegistry("intakecoordinatordashboard").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/12 | 16%] - Navigating to /offices/clinical/roles/intake_coordinator/coordinator-dashboard (IntakeCoordinatorDashboardScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/intake_coordinator/coordinator-dashboard");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/12 | 16%] - Checking shell & content for /offices/clinical/roles/intake_coordinator/coordinator-dashboard (IntakeCoordinatorDashboardScreen)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("intakecoordinatordashboard-screen").should("be.visible");
    cy.getCy("intakecoordinatordashboard-title").should("be.visible");
    cy.getCy("intakecoordinatordashboard-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/12 | 16%] - Saving screenshot for /offices/clinical/roles/intake_coordinator/coordinator-dashboard (IntakeCoordinatorDashboardScreen)...");
    cy.waitAndSee();
    cy.screenshot("intake_coordinator_dashboard");
    
    cy.updateTestRegistry("intakecoordinatordashboard", "PASS", "role_intake_all_screens.cy.js", "intake_coordinator_dashboard");
    cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/12 | 16%] - Verified IntakeCoordinatorDashboardScreen successfully!\n");
  });


  
  cy.checkTestRegistry("intakeanalytics").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [3/12 | 25%] - Navigating to /offices/clinical/roles/intake_coordinator/analytics (IntakeAnalyticsScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/intake_coordinator/analytics");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [3/12 | 25%] - Checking shell & content for /offices/clinical/roles/intake_coordinator/analytics (IntakeAnalyticsScreen)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("intakeanalytics-screen").should("be.visible");
    cy.getCy("intakeanalytics-title").should("be.visible");
    cy.getCy("intakeanalytics-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [3/12 | 25%] - Saving screenshot for /offices/clinical/roles/intake_coordinator/analytics (IntakeAnalyticsScreen)...");
    cy.waitAndSee();
    cy.screenshot("intake_analytics");
    
    cy.updateTestRegistry("intakeanalytics", "PASS", "role_intake_all_screens.cy.js", "intake_analytics");
    cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [3/12 | 25%] - Verified IntakeAnalyticsScreen successfully!\n");
  });


  
  cy.checkTestRegistry("intakecompliance").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [4/12 | 33%] - Navigating to /offices/clinical/roles/intake_coordinator/compliance (IntakeComplianceScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/intake_coordinator/compliance");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [4/12 | 33%] - Checking shell & content for /offices/clinical/roles/intake_coordinator/compliance (IntakeComplianceScreen)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("intakecompliance-screen").should("be.visible");
    cy.getCy("intakecompliance-title").should("be.visible");
    cy.getCy("intakecompliance-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [4/12 | 33%] - Saving screenshot for /offices/clinical/roles/intake_coordinator/compliance (IntakeComplianceScreen)...");
    cy.waitAndSee();
    cy.screenshot("intake_compliance");
    
    cy.updateTestRegistry("intakecompliance", "PASS", "role_intake_all_screens.cy.js", "intake_compliance");
    cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [4/12 | 33%] - Verified IntakeComplianceScreen successfully!\n");
  });


  
  cy.checkTestRegistry("intakeworkflow").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [5/12 | 41%] - Navigating to /offices/clinical/roles/intake_coordinator/workflow (IntakeWorkflowScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/intake_coordinator/workflow");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [5/12 | 41%] - Checking shell & content for /offices/clinical/roles/intake_coordinator/workflow (IntakeWorkflowScreen)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("intakeworkflow-screen").should("be.visible");
    cy.getCy("intakeworkflow-title").should("be.visible");
    cy.getCy("intakeworkflow-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [5/12 | 41%] - Saving screenshot for /offices/clinical/roles/intake_coordinator/workflow (IntakeWorkflowScreen)...");
    cy.waitAndSee();
    cy.screenshot("intake_workflow");
    
    cy.updateTestRegistry("intakeworkflow", "PASS", "role_intake_all_screens.cy.js", "intake_workflow");
    cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [5/12 | 41%] - Verified IntakeWorkflowScreen successfully!\n");
  });


  
  cy.checkTestRegistry("intakecoordinatoranalytics").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [6/12 | 50%] - Navigating to /offices/clinical/roles/intake_coordinator/coordinator-analytics (IntakeCoordinatorAnalyticsScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/intake_coordinator/coordinator-analytics");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [6/12 | 50%] - Checking shell & content for /offices/clinical/roles/intake_coordinator/coordinator-analytics (IntakeCoordinatorAnalyticsScreen)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("intakecoordinatoranalytics-screen").should("be.visible");
    cy.getCy("intakecoordinatoranalytics-title").should("be.visible");
    cy.getCy("intakecoordinatoranalytics-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [6/12 | 50%] - Saving screenshot for /offices/clinical/roles/intake_coordinator/coordinator-analytics (IntakeCoordinatorAnalyticsScreen)...");
    cy.waitAndSee();
    cy.screenshot("intake_coordinator_analytics");
    
    cy.updateTestRegistry("intakecoordinatoranalytics", "PASS", "role_intake_all_screens.cy.js", "intake_coordinator_analytics");
    cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [6/12 | 50%] - Verified IntakeCoordinatorAnalyticsScreen successfully!\n");
  });


  
  cy.checkTestRegistry("intakecoordinatorcompliance").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [7/12 | 58%] - Navigating to /offices/clinical/roles/intake_coordinator/coordinator-compliance (IntakeCoordinatorComplianceScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/intake_coordinator/coordinator-compliance");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [7/12 | 58%] - Checking shell & content for /offices/clinical/roles/intake_coordinator/coordinator-compliance (IntakeCoordinatorComplianceScreen)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("intakecoordinatorcompliance-screen").should("be.visible");
    cy.getCy("intakecoordinatorcompliance-title").should("be.visible");
    cy.getCy("intakecoordinatorcompliance-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [7/12 | 58%] - Saving screenshot for /offices/clinical/roles/intake_coordinator/coordinator-compliance (IntakeCoordinatorComplianceScreen)...");
    cy.waitAndSee();
    cy.screenshot("intake_coordinator_compliance");
    
    cy.updateTestRegistry("intakecoordinatorcompliance", "PASS", "role_intake_all_screens.cy.js", "intake_coordinator_compliance");
    cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [7/12 | 58%] - Verified IntakeCoordinatorComplianceScreen successfully!\n");
  });


  
  cy.checkTestRegistry("intakecoordinatorworkflow").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [8/12 | 66%] - Navigating to /offices/clinical/roles/intake_coordinator/coordinator-workflow (IntakeCoordinatorWorkflowScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/intake_coordinator/coordinator-workflow");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [8/12 | 66%] - Checking shell & content for /offices/clinical/roles/intake_coordinator/coordinator-workflow (IntakeCoordinatorWorkflowScreen)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("intakecoordinatorworkflow-screen").should("be.visible");
    cy.getCy("intakecoordinatorworkflow-title").should("be.visible");
    cy.getCy("intakecoordinatorworkflow-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [8/12 | 66%] - Saving screenshot for /offices/clinical/roles/intake_coordinator/coordinator-workflow (IntakeCoordinatorWorkflowScreen)...");
    cy.waitAndSee();
    cy.screenshot("intake_coordinator_workflow");
    
    cy.updateTestRegistry("intakecoordinatorworkflow", "PASS", "role_intake_all_screens.cy.js", "intake_coordinator_workflow");
    cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [8/12 | 66%] - Verified IntakeCoordinatorWorkflowScreen successfully!\n");
  });


  
  cy.checkTestRegistry("referralmanagement").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [9/12 | 75%] - Navigating to /offices/clinical/roles/intake_coordinator/referral-management (ReferralManagementScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/intake_coordinator/referral-management");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [9/12 | 75%] - Checking shell & content for /offices/clinical/roles/intake_coordinator/referral-management (ReferralManagementScreen)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("referralmanagement-screen").should("be.visible");
    cy.getCy("referralmanagement-title").should("be.visible");
    cy.getCy("referralmanagement-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [9/12 | 75%] - Saving screenshot for /offices/clinical/roles/intake_coordinator/referral-management (ReferralManagementScreen)...");
    cy.waitAndSee();
    cy.screenshot("referral_management");
    
    cy.updateTestRegistry("referralmanagement", "PASS", "role_intake_all_screens.cy.js", "referral_management");
    cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [9/12 | 75%] - Verified ReferralManagementScreen successfully!\n");
  });


  
  cy.checkTestRegistry("clientintake").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [10/12 | 83%] - Navigating to /offices/clinical/roles/intake_coordinator/client-intake (ClientIntakeScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/intake_coordinator/client-intake");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [10/12 | 83%] - Checking shell & content for /offices/clinical/roles/intake_coordinator/client-intake (ClientIntakeScreen)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("clientintake-screen").should("be.visible");
    cy.getCy("clientintake-title").should("be.visible");
    cy.getCy("clientintake-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [10/12 | 83%] - Saving screenshot for /offices/clinical/roles/intake_coordinator/client-intake (ClientIntakeScreen)...");
    cy.waitAndSee();
    cy.screenshot("client_intake");
    
    cy.updateTestRegistry("clientintake", "PASS", "role_intake_all_screens.cy.js", "client_intake");
    cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [10/12 | 83%] - Verified ClientIntakeScreen successfully!\n");
  });


  
  cy.checkTestRegistry("booking").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [11/12 | 91%] - Navigating to /offices/clinical/roles/intake_coordinator/booking (BookingScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/intake_coordinator/booking");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [11/12 | 91%] - Checking shell & content for /offices/clinical/roles/intake_coordinator/booking (BookingScreen)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("booking-screen").should("be.visible");
    cy.getCy("booking-title").should("be.visible");
    cy.getCy("booking-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [11/12 | 91%] - Saving screenshot for /offices/clinical/roles/intake_coordinator/booking (BookingScreen)...");
    cy.waitAndSee();
    cy.screenshot("booking");
    
    cy.updateTestRegistry("booking", "PASS", "role_intake_all_screens.cy.js", "booking");
    cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [11/12 | 91%] - Verified BookingScreen successfully!\n");
  });


  
  cy.checkTestRegistry("followup").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [12/12 | 100%] - Navigating to /offices/clinical/roles/intake_coordinator/followup (FollowupScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/intake_coordinator/followup");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [12/12 | 100%] - Checking shell & content for /offices/clinical/roles/intake_coordinator/followup (FollowupScreen)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("followup-screen").should("be.visible");
    cy.getCy("followup-title").should("be.visible");
    cy.getCy("followup-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [12/12 | 100%] - Saving screenshot for /offices/clinical/roles/intake_coordinator/followup (FollowupScreen)...");
    cy.waitAndSee();
    cy.screenshot("followup");
    
    cy.updateTestRegistry("followup", "PASS", "role_intake_all_screens.cy.js", "followup");
    cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [12/12 | 100%] - Verified FollowupScreen successfully!\n");
  });


  });
});
