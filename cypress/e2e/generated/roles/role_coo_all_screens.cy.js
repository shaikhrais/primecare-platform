// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.


function login() {
  cy.visit("/login");
  cy.wait(2000);

  cy.get('[data-cy="login-email"]').should("be.visible").clear().type("qa.coo@test.primecare.local");
  cy.get('[data-cy="login-password"]').should("be.visible").clear().type(Cypress.env("TEST_PASSWORD"), { log: false });
  cy.get('[data-cy="login-submit"]').should("be.visible").click();

  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");
}

describe("Role All Screens - coo", () => {
  it("tests all screens for role coo", () => {
    login();


  cy.visit("/executive/coo-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="coodashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="coodashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="coodashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("coo_dashboard");

  cy.visit("/staff/volunteer-coordinator-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="volunteercoordinatordashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="volunteercoordinatordashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="volunteercoordinatordashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("volunteer_coordinator_dashboard");

  cy.visit("/executive/coo-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="cooanalytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="cooanalytics-title"]`).should("be.visible");
  cy.get(`[data-cy="cooanalytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("coo_analytics");

  cy.visit("/executive/coo-compliance");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="coocompliance-screen"]`).should("be.visible");
  cy.get(`[data-cy="coocompliance-title"]`).should("be.visible");
  cy.get(`[data-cy="coocompliance-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("coo_compliance");

  cy.visit("/executive/coo-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="cooworkflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="cooworkflow-title"]`).should("be.visible");
  cy.get(`[data-cy="cooworkflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("coo_workflow");

  cy.visit("/executive/coo-command-center");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="coocommandcenter-screen"]`).should("be.visible");
  cy.get(`[data-cy="coocommandcenter-title"]`).should("be.visible");
  cy.get(`[data-cy="coocommandcenter-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("coo_command_center");

  cy.visit("/executive/coo-operations-overview");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="coooperationsoverview-screen"]`).should("be.visible");
  cy.get(`[data-cy="coooperationsoverview-title"]`).should("be.visible");
  cy.get(`[data-cy="coooperationsoverview-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("coo_operations_overview");

  cy.visit("/executive/coo-staffing");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="coostaffing-screen"]`).should("be.visible");
  cy.get(`[data-cy="coostaffing-title"]`).should("be.visible");
  cy.get(`[data-cy="coostaffing-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("coo_staffing");

  cy.visit("/executive/coo-scheduling-health");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="cooschedulinghealth-screen"]`).should("be.visible");
  cy.get(`[data-cy="cooschedulinghealth-title"]`).should("be.visible");
  cy.get(`[data-cy="cooschedulinghealth-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("coo_scheduling_health");

  cy.visit("/executive/coo-workflow-issues");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="cooworkflowissues-screen"]`).should("be.visible");
  cy.get(`[data-cy="cooworkflowissues-title"]`).should("be.visible");
  cy.get(`[data-cy="cooworkflowissues-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("coo_workflow_issues");

  cy.visit("/executive/coo-branch-comparison");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="coobranchcomparison-screen"]`).should("be.visible");
  cy.get(`[data-cy="coobranchcomparison-title"]`).should("be.visible");
  cy.get(`[data-cy="coobranchcomparison-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("coo_branch_comparison");

  cy.visit("/executive/intake-coordinator-referrals");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="intakecoordinatorreferrals-screen"]`).should("be.visible");
  cy.get(`[data-cy="intakecoordinatorreferrals-title"]`).should("be.visible");
  cy.get(`[data-cy="intakecoordinatorreferrals-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("intake_coordinator_referrals");

  cy.visit("/executive/intake-coordinator-new-client-intake");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="intakecoordinatornewclientintake-screen"]`).should("be.visible");
  cy.get(`[data-cy="intakecoordinatornewclientintake-title"]`).should("be.visible");
  cy.get(`[data-cy="intakecoordinatornewclientintake-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("intake_coordinator_new_client_intake");

  cy.visit("/executive/intake-coordinator-assessment-queue");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="intakecoordinatorassessmentqueue-screen"]`).should("be.visible");
  cy.get(`[data-cy="intakecoordinatorassessmentqueue-title"]`).should("be.visible");
  cy.get(`[data-cy="intakecoordinatorassessmentqueue-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("intake_coordinator_assessment_queue");

  cy.visit("/executive/intake-coordinator-booking");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="intakecoordinatorbooking-screen"]`).should("be.visible");
  cy.get(`[data-cy="intakecoordinatorbooking-title"]`).should("be.visible");
  cy.get(`[data-cy="intakecoordinatorbooking-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("intake_coordinator_booking");

  cy.visit("/executive/intake-coordinator-documents");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="intakecoordinatordocuments-screen"]`).should("be.visible");
  cy.get(`[data-cy="intakecoordinatordocuments-title"]`).should("be.visible");
  cy.get(`[data-cy="intakecoordinatordocuments-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("intake_coordinator_documents");

  cy.visit("/executive/intake-coordinator-follow-up");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="intakecoordinatorfollowup-screen"]`).should("be.visible");
  cy.get(`[data-cy="intakecoordinatorfollowup-title"]`).should("be.visible");
  cy.get(`[data-cy="intakecoordinatorfollowup-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("intake_coordinator_follow_up");

  cy.visit("/executive/operations-command-center");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="operationscommandcenter-screen"]`).should("be.visible");
  cy.get(`[data-cy="operationscommandcenter-title"]`).should("be.visible");
  cy.get(`[data-cy="operationscommandcenter-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("operations_command_center");

  cy.visit("/executive/staffing-overview");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="staffingoverview-screen"]`).should("be.visible");
  cy.get(`[data-cy="staffingoverview-title"]`).should("be.visible");
  cy.get(`[data-cy="staffingoverview-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("staffing_overview");

  cy.visit("/executive/workflow-issue");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="workflowissue-screen"]`).should("be.visible");
  cy.get(`[data-cy="workflowissue-title"]`).should("be.visible");
  cy.get(`[data-cy="workflowissue-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("workflow_issue");

  cy.visit("/executive/service-quality");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="servicequality-screen"]`).should("be.visible");
  cy.get(`[data-cy="servicequality-title"]`).should("be.visible");
  cy.get(`[data-cy="servicequality-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("service_quality");

  cy.visit("/executive/branch-performance");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="branchperformance-screen"]`).should("be.visible");
  cy.get(`[data-cy="branchperformance-title"]`).should("be.visible");
  cy.get(`[data-cy="branchperformance-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("branch_performance");

  cy.visit("/staff/training-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="trainingdashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="trainingdashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="trainingdashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("training_dashboard");

  cy.visit("/staff/course-assignment");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="courseassignment-screen"]`).should("be.visible");
  cy.get(`[data-cy="courseassignment-title"]`).should("be.visible");
  cy.get(`[data-cy="courseassignment-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("course_assignment");

  cy.visit("/staff/certification-tracking");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="certificationtracking-screen"]`).should("be.visible");
  cy.get(`[data-cy="certificationtracking-title"]`).should("be.visible");
  cy.get(`[data-cy="certificationtracking-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("certification_tracking");

  cy.visit("/staff/staff-progress");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="staffprogress-screen"]`).should("be.visible");
  cy.get(`[data-cy="staffprogress-title"]`).should("be.visible");
  cy.get(`[data-cy="staffprogress-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("staff_progress");

  });
});
