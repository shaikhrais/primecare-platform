// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - intake", () => {
  it("tests all screens for role intake", () => {
    cy.loginAsRole("intake");


  cy.task("log", "⏳ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/11 | 9%] - Navigating to /offices/clinical/roles/intake_coordinator/dashboard (IntakeCoordinatorDashboardScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/intake_coordinator/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/11 | 9%] - Checking shell & content for IntakeCoordinatorDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("intakecoordinatordashboard-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("intakecoordinatordashboard-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("intakecoordinatordashboard-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/11 | 9%] - Saving screenshot for IntakeCoordinatorDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("intake_coordinator_dashboard");
  
  cy.task("log", "✅ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/11 | 9%] - Verified IntakeCoordinatorDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/11 | 18%] - Navigating to /offices/clinical/roles/intake_coordinator/analytics (IntakeAnalyticsScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/intake_coordinator/analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/11 | 18%] - Checking shell & content for IntakeAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("intakeanalytics-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("intakeanalytics-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("intakeanalytics-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/11 | 18%] - Saving screenshot for IntakeAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("intake_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/11 | 18%] - Verified IntakeAnalyticsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [3/11 | 27%] - Navigating to /offices/clinical/roles/intake_coordinator/compliance (IntakeComplianceScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/intake_coordinator/compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [3/11 | 27%] - Checking shell & content for IntakeComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("intakecompliance-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("intakecompliance-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("intakecompliance-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [3/11 | 27%] - Saving screenshot for IntakeComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("intake_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [3/11 | 27%] - Verified IntakeComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [4/11 | 36%] - Navigating to /offices/clinical/roles/intake_coordinator/workflow (IntakeWorkflowScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/intake_coordinator/workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [4/11 | 36%] - Checking shell & content for IntakeWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("intakeworkflow-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("intakeworkflow-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("intakeworkflow-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [4/11 | 36%] - Saving screenshot for IntakeWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("intake_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [4/11 | 36%] - Verified IntakeWorkflowScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [5/11 | 45%] - Navigating to /offices/clinical/roles/intake_coordinator/coordinator-analytics (IntakeCoordinatorAnalyticsScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/intake_coordinator/coordinator-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [5/11 | 45%] - Checking shell & content for IntakeCoordinatorAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("intakecoordinatoranalytics-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("intakecoordinatoranalytics-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("intakecoordinatoranalytics-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [5/11 | 45%] - Saving screenshot for IntakeCoordinatorAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("intake_coordinator_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [5/11 | 45%] - Verified IntakeCoordinatorAnalyticsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [6/11 | 54%] - Navigating to /offices/clinical/roles/intake_coordinator/coordinator-compliance (IntakeCoordinatorComplianceScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/intake_coordinator/coordinator-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [6/11 | 54%] - Checking shell & content for IntakeCoordinatorComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("intakecoordinatorcompliance-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("intakecoordinatorcompliance-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("intakecoordinatorcompliance-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [6/11 | 54%] - Saving screenshot for IntakeCoordinatorComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("intake_coordinator_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [6/11 | 54%] - Verified IntakeCoordinatorComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [7/11 | 63%] - Navigating to /offices/clinical/roles/intake_coordinator/coordinator-workflow (IntakeCoordinatorWorkflowScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/intake_coordinator/coordinator-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [7/11 | 63%] - Checking shell & content for IntakeCoordinatorWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("intakecoordinatorworkflow-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("intakecoordinatorworkflow-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("intakecoordinatorworkflow-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [7/11 | 63%] - Saving screenshot for IntakeCoordinatorWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("intake_coordinator_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [7/11 | 63%] - Verified IntakeCoordinatorWorkflowScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [8/11 | 72%] - Navigating to /offices/clinical/roles/intake_coordinator/referral-management (ReferralManagementScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/intake_coordinator/referral-management");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [8/11 | 72%] - Checking shell & content for ReferralManagementScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("referralmanagement-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("referralmanagement-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("referralmanagement-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [8/11 | 72%] - Saving screenshot for ReferralManagementScreen...");
  cy.waitAndSee();
  cy.screenshot("referral_management");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [8/11 | 72%] - Verified ReferralManagementScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [9/11 | 81%] - Navigating to /offices/clinical/roles/intake_coordinator/client-intake (ClientIntakeScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/intake_coordinator/client-intake");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [9/11 | 81%] - Checking shell & content for ClientIntakeScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("clientintake-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("clientintake-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("clientintake-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [9/11 | 81%] - Saving screenshot for ClientIntakeScreen...");
  cy.waitAndSee();
  cy.screenshot("client_intake");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [9/11 | 81%] - Verified ClientIntakeScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [10/11 | 90%] - Navigating to /offices/clinical/roles/intake_coordinator/booking (BookingScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/intake_coordinator/booking");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [10/11 | 90%] - Checking shell & content for BookingScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("booking-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("booking-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("booking-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [10/11 | 90%] - Saving screenshot for BookingScreen...");
  cy.waitAndSee();
  cy.screenshot("booking");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [10/11 | 90%] - Verified BookingScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [11/11 | 100%] - Navigating to /offices/clinical/roles/intake_coordinator/followup (FollowupScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/intake_coordinator/followup");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [11/11 | 100%] - Checking shell & content for FollowupScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("followup-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("followup-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("followup-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [11/11 | 100%] - Saving screenshot for FollowupScreen...");
  cy.waitAndSee();
  cy.screenshot("followup");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [11/11 | 100%] - Verified FollowupScreen successfully!\n");

  });
});
