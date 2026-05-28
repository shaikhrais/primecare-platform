// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - clinical_director", () => {
  it("tests all screens for role clinical_director", () => {
    cy.loginAsRole("clinical_director");


  cy.visitWithSemantics("/clinical/clinical-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clinicaldashboard-screen").should("be.visible");
  cy.getCy("clinicaldashboard-title").should("be.visible");
  cy.getCy("clinicaldashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("clinical_dashboard");

  cy.visitWithSemantics("/common/clinic-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clinicdashboard-screen").should("be.visible");
  cy.getCy("clinicdashboard-title").should("be.visible");
  cy.getCy("clinicdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("clinic_dashboard");

  cy.visitWithSemantics("/clinical/clinical-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clinicalanalytics-screen").should("be.visible");
  cy.getCy("clinicalanalytics-title").should("be.visible");
  cy.getCy("clinicalanalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("clinical_analytics");

  cy.visitWithSemantics("/clinical/clinical-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clinicalcompliance-screen").should("be.visible");
  cy.getCy("clinicalcompliance-title").should("be.visible");
  cy.getCy("clinicalcompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("clinical_compliance");

  cy.visitWithSemantics("/clinical/clinical-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clinicalworkflow-screen").should("be.visible");
  cy.getCy("clinicalworkflow-title").should("be.visible");
  cy.getCy("clinicalworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("clinical_workflow");

  cy.visitWithSemantics("/common/clinic-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clinicanalytics-screen").should("be.visible");
  cy.getCy("clinicanalytics-title").should("be.visible");
  cy.getCy("clinicanalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("clinic_analytics");

  cy.visitWithSemantics("/common/clinic-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cliniccompliance-screen").should("be.visible");
  cy.getCy("cliniccompliance-title").should("be.visible");
  cy.getCy("cliniccompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("clinic_compliance");

  cy.visitWithSemantics("/common/clinic-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clinicworkflow-screen").should("be.visible");
  cy.getCy("clinicworkflow-title").should("be.visible");
  cy.getCy("clinicworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("clinic_workflow");

  cy.visitWithSemantics("/clinical/clinical-director-staff-quality");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clinicaldirectorstaffquality-screen").should("be.visible");
  cy.getCy("clinicaldirectorstaffquality-title").should("be.visible");
  cy.getCy("clinicaldirectorstaffquality-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("clinical_director_staff_quality");

  cy.visitWithSemantics("/clinical/clinical-director-incident-review");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clinicaldirectorincidentreview-screen").should("be.visible");
  cy.getCy("clinicaldirectorincidentreview-title").should("be.visible");
  cy.getCy("clinicaldirectorincidentreview-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("clinical_director_incident_review");

  cy.visitWithSemantics("/clinical/clinical-director-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clinicaldirectorcompliance-screen").should("be.visible");
  cy.getCy("clinicaldirectorcompliance-title").should("be.visible");
  cy.getCy("clinicaldirectorcompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("clinical_director_compliance");

  cy.visitWithSemantics("/clinical/clinical-director-reports");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clinicaldirectorreports-screen").should("be.visible");
  cy.getCy("clinicaldirectorreports-title").should("be.visible");
  cy.getCy("clinicaldirectorreports-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("clinical_director_reports");

  cy.visitWithSemantics("/clinical/clinical-director-approvals");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clinicaldirectorapprovals-screen").should("be.visible");
  cy.getCy("clinicaldirectorapprovals-title").should("be.visible");
  cy.getCy("clinicaldirectorapprovals-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("clinical_director_approvals");

  cy.visitWithSemantics("/clinical/clinical-director-performance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clinicaldirectorperformance-screen").should("be.visible");
  cy.getCy("clinicaldirectorperformance-title").should("be.visible");
  cy.getCy("clinicaldirectorperformance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("clinical_director_performance");

  cy.visitWithSemantics("/clinical/clinical-quality");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clinicalquality-screen").should("be.visible");
  cy.getCy("clinicalquality-title").should("be.visible");
  cy.getCy("clinicalquality-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("clinical_quality");

  cy.visitWithSemantics("/clinical/staff-performance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("staffperformance-screen").should("be.visible");
  cy.getCy("staffperformance-title").should("be.visible");
  cy.getCy("staffperformance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("staff_performance");

  cy.visitWithSemantics("/clinical/compliance-review");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("compliancereview-screen").should("be.visible");
  cy.getCy("compliancereview-title").should("be.visible");
  cy.getCy("compliancereview-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("compliance_review");

  cy.visitWithSemantics("/clinical/incident-oversight");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("incidentoversight-screen").should("be.visible");
  cy.getCy("incidentoversight-title").should("be.visible");
  cy.getCy("incidentoversight-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("incident_oversight");

  cy.visitWithSemantics("/clinical/clinical-operations4-k");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clinicaloperations4k-screen").should("be.visible");
  cy.getCy("clinicaloperations4k-title").should("be.visible");
  cy.getCy("clinicaloperations4k-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("clinical_operations4_k");

  });
});
