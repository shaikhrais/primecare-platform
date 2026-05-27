// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - psw", () => {
  it("tests all screens for role psw", () => {
    cy.loginAsRole("psw");


  cy.visit("/psw/psw-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswdashboard-screen").should("be.visible");
  cy.getCy("pswdashboard-title").should("be.visible");
  cy.getCy("pswdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("psw_dashboard");

  cy.visit("/psw/psw-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswanalytics-screen").should("be.visible");
  cy.getCy("pswanalytics-title").should("be.visible");
  cy.getCy("pswanalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("psw_analytics");

  cy.visit("/psw/psw-clients");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswclients-screen").should("be.visible");
  cy.getCy("pswclients-title").should("be.visible");
  cy.getCy("pswclients-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("psw_clients");

  cy.visit("/psw/psw-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswcompliance-screen").should("be.visible");
  cy.getCy("pswcompliance-title").should("be.visible");
  cy.getCy("pswcompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("psw_compliance");

  cy.visit("/psw/psw-messages");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswmessages-screen").should("be.visible");
  cy.getCy("pswmessages-title").should("be.visible");
  cy.getCy("pswmessages-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("psw_messages");

  cy.visit("/psw/psw-shift-tracker");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswshifttracker-screen").should("be.visible");
  cy.getCy("pswshifttracker-title").should("be.visible");
  cy.getCy("pswshifttracker-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("psw_shift_tracker");

  cy.visit("/psw/psw-tasks");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswtasks-screen").should("be.visible");
  cy.getCy("pswtasks-title").should("be.visible");
  cy.getCy("pswtasks-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("psw_tasks");

  cy.visit("/psw/psw-visit-notes");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswvisitnotes-screen").should("be.visible");
  cy.getCy("pswvisitnotes-title").should("be.visible");
  cy.getCy("pswvisitnotes-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("psw_visit_notes");

  cy.visit("/psw/psw-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswworkflow-screen").should("be.visible");
  cy.getCy("pswworkflow-title").should("be.visible");
  cy.getCy("pswworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("psw_workflow");

  cy.visit("/psw/psw-command-center");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswcommandcenter-screen").should("be.visible");
  cy.getCy("pswcommandcenter-title").should("be.visible");
  cy.getCy("pswcommandcenter-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("psw_command_center");

  cy.visit("/psw/psw-my-shifts");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswmyshifts-screen").should("be.visible");
  cy.getCy("pswmyshifts-title").should("be.visible");
  cy.getCy("pswmyshifts-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("psw_my_shifts");

  cy.visit("/psw/psw-client-profile");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswclientprofile-screen").should("be.visible");
  cy.getCy("pswclientprofile-title").should("be.visible");
  cy.getCy("pswclientprofile-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("psw_client_profile");

  cy.visit("/psw/psw-visit-notes");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswvisitnotes-screen").should("be.visible");
  cy.getCy("pswvisitnotes-title").should("be.visible");
  cy.getCy("pswvisitnotes-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("psw_visit_notes");

  cy.visit("/psw/psw-vitals-log");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswvitalslog-screen").should("be.visible");
  cy.getCy("pswvitalslog-title").should("be.visible");
  cy.getCy("pswvitalslog-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("psw_vitals_log");

  cy.visit("/psw/psw-incident-report");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswincidentreport-screen").should("be.visible");
  cy.getCy("pswincidentreport-title").should("be.visible");
  cy.getCy("pswincidentreport-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("psw_incident_report");

  cy.visit("/psw/psw-care-plan");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswcareplan-screen").should("be.visible");
  cy.getCy("pswcareplan-title").should("be.visible");
  cy.getCy("pswcareplan-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("psw_care_plan");

  cy.visit("/psw/psw-messages");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswmessages-screen").should("be.visible");
  cy.getCy("pswmessages-title").should("be.visible");
  cy.getCy("pswmessages-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("psw_messages");

  cy.visit("/psw/psw-documents");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswdocuments-screen").should("be.visible");
  cy.getCy("pswdocuments-title").should("be.visible");
  cy.getCy("pswdocuments-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("psw_documents");

  cy.visit("/psw/shift-tasks");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("shifttasks-screen").should("be.visible");
  cy.getCy("shifttasks-title").should("be.visible");
  cy.getCy("shifttasks-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("shift_tasks");

  cy.visit("/psw/visit-notes");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("visitnotes-screen").should("be.visible");
  cy.getCy("visitnotes-title").should("be.visible");
  cy.getCy("visitnotes-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("visit_notes");

  cy.visit("/psw/vitals-entry");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("vitalsentry-screen").should("be.visible");
  cy.getCy("vitalsentry-title").should("be.visible");
  cy.getCy("vitalsentry-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("vitals_entry");

  cy.visit("/psw/incident-report");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("incidentreport-screen").should("be.visible");
  cy.getCy("incidentreport-title").should("be.visible");
  cy.getCy("incidentreport-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("incident_report");

  });
});
