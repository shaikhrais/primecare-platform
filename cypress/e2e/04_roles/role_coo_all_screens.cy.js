// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - coo", () => {
  it("tests all screens for role coo", () => {
    cy.loginAsRole("coo");


  cy.visit("/executive/coo-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("coodashboard-screen").should("be.visible");
  cy.getCy("coodashboard-title").should("be.visible");
  cy.getCy("coodashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("coo_dashboard");

  cy.visit("/staff/volunteer-coordinator-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("volunteercoordinatordashboard-screen").should("be.visible");
  cy.getCy("volunteercoordinatordashboard-title").should("be.visible");
  cy.getCy("volunteercoordinatordashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("volunteer_coordinator_dashboard");

  cy.visit("/executive/coo-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cooanalytics-screen").should("be.visible");
  cy.getCy("cooanalytics-title").should("be.visible");
  cy.getCy("cooanalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("coo_analytics");

  cy.visit("/executive/coo-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("coocompliance-screen").should("be.visible");
  cy.getCy("coocompliance-title").should("be.visible");
  cy.getCy("coocompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("coo_compliance");

  cy.visit("/executive/coo-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cooworkflow-screen").should("be.visible");
  cy.getCy("cooworkflow-title").should("be.visible");
  cy.getCy("cooworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("coo_workflow");

  cy.visit("/executive/coo-command-center");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("coocommandcenter-screen").should("be.visible");
  cy.getCy("coocommandcenter-title").should("be.visible");
  cy.getCy("coocommandcenter-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("coo_command_center");

  cy.visit("/executive/coo-operations-overview");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("coooperationsoverview-screen").should("be.visible");
  cy.getCy("coooperationsoverview-title").should("be.visible");
  cy.getCy("coooperationsoverview-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("coo_operations_overview");

  cy.visit("/executive/coo-staffing");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("coostaffing-screen").should("be.visible");
  cy.getCy("coostaffing-title").should("be.visible");
  cy.getCy("coostaffing-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("coo_staffing");

  cy.visit("/executive/coo-scheduling-health");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cooschedulinghealth-screen").should("be.visible");
  cy.getCy("cooschedulinghealth-title").should("be.visible");
  cy.getCy("cooschedulinghealth-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("coo_scheduling_health");

  cy.visit("/executive/coo-workflow-issues");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cooworkflowissues-screen").should("be.visible");
  cy.getCy("cooworkflowissues-title").should("be.visible");
  cy.getCy("cooworkflowissues-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("coo_workflow_issues");

  cy.visit("/executive/coo-branch-comparison");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("coobranchcomparison-screen").should("be.visible");
  cy.getCy("coobranchcomparison-title").should("be.visible");
  cy.getCy("coobranchcomparison-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("coo_branch_comparison");

  cy.visit("/executive/intake-coordinator-referrals");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("intakecoordinatorreferrals-screen").should("be.visible");
  cy.getCy("intakecoordinatorreferrals-title").should("be.visible");
  cy.getCy("intakecoordinatorreferrals-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("intake_coordinator_referrals");

  cy.visit("/executive/intake-coordinator-new-client-intake");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("intakecoordinatornewclientintake-screen").should("be.visible");
  cy.getCy("intakecoordinatornewclientintake-title").should("be.visible");
  cy.getCy("intakecoordinatornewclientintake-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("intake_coordinator_new_client_intake");

  cy.visit("/executive/intake-coordinator-assessment-queue");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("intakecoordinatorassessmentqueue-screen").should("be.visible");
  cy.getCy("intakecoordinatorassessmentqueue-title").should("be.visible");
  cy.getCy("intakecoordinatorassessmentqueue-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("intake_coordinator_assessment_queue");

  cy.visit("/executive/intake-coordinator-booking");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("intakecoordinatorbooking-screen").should("be.visible");
  cy.getCy("intakecoordinatorbooking-title").should("be.visible");
  cy.getCy("intakecoordinatorbooking-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("intake_coordinator_booking");

  cy.visit("/executive/intake-coordinator-documents");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("intakecoordinatordocuments-screen").should("be.visible");
  cy.getCy("intakecoordinatordocuments-title").should("be.visible");
  cy.getCy("intakecoordinatordocuments-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("intake_coordinator_documents");

  cy.visit("/executive/intake-coordinator-follow-up");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("intakecoordinatorfollowup-screen").should("be.visible");
  cy.getCy("intakecoordinatorfollowup-title").should("be.visible");
  cy.getCy("intakecoordinatorfollowup-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("intake_coordinator_follow_up");

  cy.visit("/executive/operations-command-center");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("operationscommandcenter-screen").should("be.visible");
  cy.getCy("operationscommandcenter-title").should("be.visible");
  cy.getCy("operationscommandcenter-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("operations_command_center");

  cy.visit("/executive/staffing-overview");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("staffingoverview-screen").should("be.visible");
  cy.getCy("staffingoverview-title").should("be.visible");
  cy.getCy("staffingoverview-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("staffing_overview");

  cy.visit("/executive/workflow-issue");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("workflowissue-screen").should("be.visible");
  cy.getCy("workflowissue-title").should("be.visible");
  cy.getCy("workflowissue-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("workflow_issue");

  cy.visit("/executive/service-quality");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("servicequality-screen").should("be.visible");
  cy.getCy("servicequality-title").should("be.visible");
  cy.getCy("servicequality-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("service_quality");

  cy.visit("/executive/branch-performance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("branchperformance-screen").should("be.visible");
  cy.getCy("branchperformance-title").should("be.visible");
  cy.getCy("branchperformance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("branch_performance");

  cy.visit("/staff/training-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("trainingdashboard-screen").should("be.visible");
  cy.getCy("trainingdashboard-title").should("be.visible");
  cy.getCy("trainingdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("training_dashboard");

  cy.visit("/staff/course-assignment");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("courseassignment-screen").should("be.visible");
  cy.getCy("courseassignment-title").should("be.visible");
  cy.getCy("courseassignment-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("course_assignment");

  cy.visit("/staff/certification-tracking");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("certificationtracking-screen").should("be.visible");
  cy.getCy("certificationtracking-title").should("be.visible");
  cy.getCy("certificationtracking-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("certification_tracking");

  cy.visit("/staff/staff-progress");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("staffprogress-screen").should("be.visible");
  cy.getCy("staffprogress-title").should("be.visible");
  cy.getCy("staffprogress-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("staff_progress");

  });
});
