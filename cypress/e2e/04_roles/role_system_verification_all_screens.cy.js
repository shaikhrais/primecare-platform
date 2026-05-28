// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - system_verification", () => {
  it("tests all screens for role system_verification", () => {
    cy.loginAsRole("system_verification");


  cy.visitWithSemantics("/common/qa-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("qadashboard-screen").should("be.visible");
  cy.getCy("qadashboard-title").should("be.visible");
  cy.getCy("qadashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("qa_dashboard");

  cy.visitWithSemantics("/common/system-verification-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("systemverificationdashboard-screen").should("be.visible");
  cy.getCy("systemverificationdashboard-title").should("be.visible");
  cy.getCy("systemverificationdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("system_verification_dashboard");

  cy.visitWithSemantics("/staff/quality-assurance-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("qualityassurancedashboard-screen").should("be.visible");
  cy.getCy("qualityassurancedashboard-title").should("be.visible");
  cy.getCy("qualityassurancedashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("quality_assurance_dashboard");

  cy.visitWithSemantics("/common/system-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("systemanalytics-screen").should("be.visible");
  cy.getCy("systemanalytics-title").should("be.visible");
  cy.getCy("systemanalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("system_analytics");

  cy.visitWithSemantics("/common/system-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("systemcompliance-screen").should("be.visible");
  cy.getCy("systemcompliance-title").should("be.visible");
  cy.getCy("systemcompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("system_compliance");

  cy.visitWithSemantics("/common/system-verification-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("systemverificationanalytics-screen").should("be.visible");
  cy.getCy("systemverificationanalytics-title").should("be.visible");
  cy.getCy("systemverificationanalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("system_verification_analytics");

  cy.visitWithSemantics("/common/system-verification-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("systemverificationcompliance-screen").should("be.visible");
  cy.getCy("systemverificationcompliance-title").should("be.visible");
  cy.getCy("systemverificationcompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("system_verification_compliance");

  cy.visitWithSemantics("/common/system-verification-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("systemverificationworkflow-screen").should("be.visible");
  cy.getCy("systemverificationworkflow-title").should("be.visible");
  cy.getCy("systemverificationworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("system_verification_workflow");

  cy.visitWithSemantics("/common/system-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("systemworkflow-screen").should("be.visible");
  cy.getCy("systemworkflow-title").should("be.visible");
  cy.getCy("systemworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("system_workflow");

  });
});
