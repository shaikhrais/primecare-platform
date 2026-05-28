// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - scheduler", () => {
  it("tests all screens for role scheduler", () => {
    cy.loginAsRole("scheduler");


  cy.visitWithSemantics("/staff/scheduler-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("schedulerdashboard-screen").should("be.visible");
  cy.getCy("schedulerdashboard-title").should("be.visible");
  cy.getCy("schedulerdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("scheduler_dashboard");

  cy.visitWithSemantics("/staff/coordinator-dispatch-map");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("coordinatordispatchmap-screen").should("be.visible");
  cy.getCy("coordinatordispatchmap-title").should("be.visible");
  cy.getCy("coordinatordispatchmap-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("coordinator_dispatch_map");

  cy.visitWithSemantics("/staff/coordinator-hub");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("coordinatorhub-screen").should("be.visible");
  cy.getCy("coordinatorhub-title").should("be.visible");
  cy.getCy("coordinatorhub-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("coordinator_hub");

  cy.visitWithSemantics("/staff/coordinator-sos");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("coordinatorsos-screen").should("be.visible");
  cy.getCy("coordinatorsos-title").should("be.visible");
  cy.getCy("coordinatorsos-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("coordinator_sos");

  cy.visitWithSemantics("/staff/coordinator-waitlist");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("coordinatorwaitlist-screen").should("be.visible");
  cy.getCy("coordinatorwaitlist-title").should("be.visible");
  cy.getCy("coordinatorwaitlist-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("coordinator_waitlist");

  cy.visitWithSemantics("/staff/scheduler-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("scheduleranalytics-screen").should("be.visible");
  cy.getCy("scheduleranalytics-title").should("be.visible");
  cy.getCy("scheduleranalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("scheduler_analytics");

  cy.visitWithSemantics("/staff/scheduler-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("schedulercompliance-screen").should("be.visible");
  cy.getCy("schedulercompliance-title").should("be.visible");
  cy.getCy("schedulercompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("scheduler_compliance");

  cy.visitWithSemantics("/staff/scheduler-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("schedulerworkflow-screen").should("be.visible");
  cy.getCy("schedulerworkflow-title").should("be.visible");
  cy.getCy("schedulerworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("scheduler_workflow");

  cy.visitWithSemantics("/staff/scheduler-command-center");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("schedulercommandcenter-screen").should("be.visible");
  cy.getCy("schedulercommandcenter-title").should("be.visible");
  cy.getCy("schedulercommandcenter-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("scheduler_command_center");

  cy.visitWithSemantics("/staff/scheduler-calendar");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("schedulercalendar-screen").should("be.visible");
  cy.getCy("schedulercalendar-title").should("be.visible");
  cy.getCy("schedulercalendar-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("scheduler_calendar");

  cy.visitWithSemantics("/staff/scheduler-booking-requests");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("schedulerbookingrequests-screen").should("be.visible");
  cy.getCy("schedulerbookingrequests-title").should("be.visible");
  cy.getCy("schedulerbookingrequests-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("scheduler_booking_requests");

  cy.visitWithSemantics("/staff/scheduler-conflicts");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("schedulerconflicts-screen").should("be.visible");
  cy.getCy("schedulerconflicts-title").should("be.visible");
  cy.getCy("schedulerconflicts-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("scheduler_conflicts");

  cy.visitWithSemantics("/staff/scheduler-open-shifts");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("scheduleropenshifts-screen").should("be.visible");
  cy.getCy("scheduleropenshifts-title").should("be.visible");
  cy.getCy("scheduleropenshifts-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("scheduler_open_shifts");

  cy.visitWithSemantics("/staff/scheduler-provider-availability");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("schedulerprovideravailability-screen").should("be.visible");
  cy.getCy("schedulerprovideravailability-title").should("be.visible");
  cy.getCy("schedulerprovideravailability-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("scheduler_provider_availability");

  cy.visitWithSemantics("/staff/scheduling-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("schedulingdashboard-screen").should("be.visible");
  cy.getCy("schedulingdashboard-title").should("be.visible");
  cy.getCy("schedulingdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("scheduling_dashboard");

  cy.visitWithSemantics("/staff/calendar-management");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("calendarmanagement-screen").should("be.visible");
  cy.getCy("calendarmanagement-title").should("be.visible");
  cy.getCy("calendarmanagement-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("calendar_management");

  cy.visitWithSemantics("/staff/conflict-resolution");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("conflictresolution-screen").should("be.visible");
  cy.getCy("conflictresolution-title").should("be.visible");
  cy.getCy("conflictresolution-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("conflict_resolution");

  cy.visitWithSemantics("/staff/open-shift");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("openshift-screen").should("be.visible");
  cy.getCy("openshift-title").should("be.visible");
  cy.getCy("openshift-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("open_shift");

  cy.visitWithSemantics("/staff/scheduling-operations4-k");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("schedulingoperations4k-screen").should("be.visible");
  cy.getCy("schedulingoperations4k-title").should("be.visible");
  cy.getCy("schedulingoperations4k-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("scheduling_operations4_k");

  });
});
