// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - volunteer_coordinator", () => {
  it("tests all screens for role volunteer_coordinator", () => {
    cy.loginAsRole("volunteer_coordinator");


  cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/7 | 14%] - Navigating to /offices/corporate/roles/volunteer_coordinator/dashboard (VolunteerCoordinatorDashboardScreen)...");
  cy.visitWithSemantics("/offices/corporate/roles/volunteer_coordinator/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/7 | 14%] - Checking shell & content for VolunteerCoordinatorDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("volunteercoordinatordashboard-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("volunteercoordinatordashboard-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("volunteercoordinatordashboard-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/7 | 14%] - Saving screenshot for VolunteerCoordinatorDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("volunteer_coordinator_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/7 | 14%] - Verified VolunteerCoordinatorDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [2/7 | 28%] - Navigating to /executive/intake-coordinator-referrals (IntakeCoordinatorReferralsScreen)...");
  cy.visitWithSemantics("/executive/intake-coordinator-referrals");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [2/7 | 28%] - Checking shell & content for IntakeCoordinatorReferralsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("intakecoordinatorreferrals-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("intakecoordinatorreferrals-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("intakecoordinatorreferrals-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [2/7 | 28%] - Saving screenshot for IntakeCoordinatorReferralsScreen...");
  cy.waitAndSee();
  cy.screenshot("intake_coordinator_referrals");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [2/7 | 28%] - Verified IntakeCoordinatorReferralsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [3/7 | 42%] - Navigating to /executive/intake-coordinator-new-client-intake (IntakeCoordinatorNewClientIntakeScreen)...");
  cy.visitWithSemantics("/executive/intake-coordinator-new-client-intake");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [3/7 | 42%] - Checking shell & content for IntakeCoordinatorNewClientIntakeScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("intakecoordinatornewclientintake-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("intakecoordinatornewclientintake-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("intakecoordinatornewclientintake-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [3/7 | 42%] - Saving screenshot for IntakeCoordinatorNewClientIntakeScreen...");
  cy.waitAndSee();
  cy.screenshot("intake_coordinator_new_client_intake");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [3/7 | 42%] - Verified IntakeCoordinatorNewClientIntakeScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [4/7 | 57%] - Navigating to /executive/intake-coordinator-assessment-queue (IntakeCoordinatorAssessmentQueueScreen)...");
  cy.visitWithSemantics("/executive/intake-coordinator-assessment-queue");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [4/7 | 57%] - Checking shell & content for IntakeCoordinatorAssessmentQueueScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("intakecoordinatorassessmentqueue-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("intakecoordinatorassessmentqueue-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("intakecoordinatorassessmentqueue-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [4/7 | 57%] - Saving screenshot for IntakeCoordinatorAssessmentQueueScreen...");
  cy.waitAndSee();
  cy.screenshot("intake_coordinator_assessment_queue");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [4/7 | 57%] - Verified IntakeCoordinatorAssessmentQueueScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [5/7 | 71%] - Navigating to /executive/intake-coordinator-booking (IntakeCoordinatorBookingScreen)...");
  cy.visitWithSemantics("/executive/intake-coordinator-booking");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [5/7 | 71%] - Checking shell & content for IntakeCoordinatorBookingScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("intakecoordinatorbooking-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("intakecoordinatorbooking-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("intakecoordinatorbooking-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [5/7 | 71%] - Saving screenshot for IntakeCoordinatorBookingScreen...");
  cy.waitAndSee();
  cy.screenshot("intake_coordinator_booking");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [5/7 | 71%] - Verified IntakeCoordinatorBookingScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [6/7 | 85%] - Navigating to /executive/intake-coordinator-documents (IntakeCoordinatorDocumentsScreen)...");
  cy.visitWithSemantics("/executive/intake-coordinator-documents");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [6/7 | 85%] - Checking shell & content for IntakeCoordinatorDocumentsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("intakecoordinatordocuments-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("intakecoordinatordocuments-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("intakecoordinatordocuments-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [6/7 | 85%] - Saving screenshot for IntakeCoordinatorDocumentsScreen...");
  cy.waitAndSee();
  cy.screenshot("intake_coordinator_documents");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [6/7 | 85%] - Verified IntakeCoordinatorDocumentsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [7/7 | 100%] - Navigating to /executive/intake-coordinator-follow-up (IntakeCoordinatorFollowUpScreen)...");
  cy.visitWithSemantics("/executive/intake-coordinator-follow-up");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [7/7 | 100%] - Checking shell & content for IntakeCoordinatorFollowUpScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("intakecoordinatorfollowup-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("intakecoordinatorfollowup-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("intakecoordinatorfollowup-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [7/7 | 100%] - Saving screenshot for IntakeCoordinatorFollowUpScreen...");
  cy.waitAndSee();
  cy.screenshot("intake_coordinator_follow_up");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [7/7 | 100%] - Verified IntakeCoordinatorFollowUpScreen successfully!\n");

  });
});
