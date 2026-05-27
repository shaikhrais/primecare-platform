// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - qa_specialist", () => {
  it("tests all screens for role qa_specialist", () => {
    cy.loginAsRole("qa_specialist");


  cy.visit("/common/qa-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("qaanalytics-screen").should("be.visible");
  cy.getCy("qaanalytics-title").should("be.visible");
  cy.getCy("qaanalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("qa_analytics");

  cy.visit("/common/qa-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("qacompliance-screen").should("be.visible");
  cy.getCy("qacompliance-title").should("be.visible");
  cy.getCy("qacompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("qa_compliance");

  cy.visit("/common/qa-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("qaworkflow-screen").should("be.visible");
  cy.getCy("qaworkflow-title").should("be.visible");
  cy.getCy("qaworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("qa_workflow");

  cy.visit("/staff/quality-assurance-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("qualityassuranceanalytics-screen").should("be.visible");
  cy.getCy("qualityassuranceanalytics-title").should("be.visible");
  cy.getCy("qualityassuranceanalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("quality_assurance_analytics");

  cy.visit("/staff/quality-assurance-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("qualityassurancecompliance-screen").should("be.visible");
  cy.getCy("qualityassurancecompliance-title").should("be.visible");
  cy.getCy("qualityassurancecompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("quality_assurance_compliance");

  cy.visit("/staff/quality-assurance-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("qualityassuranceworkflow-screen").should("be.visible");
  cy.getCy("qualityassuranceworkflow-title").should("be.visible");
  cy.getCy("qualityassuranceworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("quality_assurance_workflow");

  cy.visit("/staff/quality-audit");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("qualityaudit-screen").should("be.visible");
  cy.getCy("qualityaudit-title").should("be.visible");
  cy.getCy("qualityaudit-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("quality_audit");

  cy.visit("/staff/failed-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("failedworkflow-screen").should("be.visible");
  cy.getCy("failedworkflow-title").should("be.visible");
  cy.getCy("failedworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("failed_workflow");

  cy.visit("/staff/testing-overview");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("testingoverview-screen").should("be.visible");
  cy.getCy("testingoverview-title").should("be.visible");
  cy.getCy("testingoverview-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("testing_overview");

  cy.visit("/staff/defect-tracking");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("defecttracking-screen").should("be.visible");
  cy.getCy("defecttracking-title").should("be.visible");
  cy.getCy("defecttracking-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("defect_tracking");

  });
});
