// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.


function login() {
  cy.visit("/login");
  cy.wait(2000);

  cy.get('[data-cy="login-email"]').should("be.visible").clear().type("qa.scheduler@test.primecare.local");
  cy.get('[data-cy="login-password"]').should("be.visible").clear().type(Cypress.env("TEST_PASSWORD"), { log: false });
  cy.get('[data-cy="login-submit"]').should("be.visible").click();

  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");
}

describe("Role All Screens - scheduler", () => {
  it("tests all screens for role scheduler", () => {
    login();


  cy.visit("/staff/scheduler-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="schedulerdashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="schedulerdashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="schedulerdashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("scheduler_dashboard");

  cy.visit("/staff/coordinator-dispatch-map");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="coordinatordispatchmap-screen"]`).should("be.visible");
  cy.get(`[data-cy="coordinatordispatchmap-title"]`).should("be.visible");
  cy.get(`[data-cy="coordinatordispatchmap-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("coordinator_dispatch_map");

  cy.visit("/staff/coordinator-hub");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="coordinatorhub-screen"]`).should("be.visible");
  cy.get(`[data-cy="coordinatorhub-title"]`).should("be.visible");
  cy.get(`[data-cy="coordinatorhub-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("coordinator_hub");

  cy.visit("/staff/coordinator-sos");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="coordinatorsos-screen"]`).should("be.visible");
  cy.get(`[data-cy="coordinatorsos-title"]`).should("be.visible");
  cy.get(`[data-cy="coordinatorsos-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("coordinator_sos");

  cy.visit("/staff/coordinator-waitlist");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="coordinatorwaitlist-screen"]`).should("be.visible");
  cy.get(`[data-cy="coordinatorwaitlist-title"]`).should("be.visible");
  cy.get(`[data-cy="coordinatorwaitlist-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("coordinator_waitlist");

  cy.visit("/staff/scheduler-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="scheduleranalytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="scheduleranalytics-title"]`).should("be.visible");
  cy.get(`[data-cy="scheduleranalytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("scheduler_analytics");

  cy.visit("/staff/scheduler-compliance");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="schedulercompliance-screen"]`).should("be.visible");
  cy.get(`[data-cy="schedulercompliance-title"]`).should("be.visible");
  cy.get(`[data-cy="schedulercompliance-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("scheduler_compliance");

  cy.visit("/staff/scheduler-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="schedulerworkflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="schedulerworkflow-title"]`).should("be.visible");
  cy.get(`[data-cy="schedulerworkflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("scheduler_workflow");

  cy.visit("/staff/scheduler-command-center");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="schedulercommandcenter-screen"]`).should("be.visible");
  cy.get(`[data-cy="schedulercommandcenter-title"]`).should("be.visible");
  cy.get(`[data-cy="schedulercommandcenter-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("scheduler_command_center");

  cy.visit("/staff/scheduler-calendar");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="schedulercalendar-screen"]`).should("be.visible");
  cy.get(`[data-cy="schedulercalendar-title"]`).should("be.visible");
  cy.get(`[data-cy="schedulercalendar-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("scheduler_calendar");

  cy.visit("/staff/scheduler-booking-requests");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="schedulerbookingrequests-screen"]`).should("be.visible");
  cy.get(`[data-cy="schedulerbookingrequests-title"]`).should("be.visible");
  cy.get(`[data-cy="schedulerbookingrequests-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("scheduler_booking_requests");

  cy.visit("/staff/scheduler-conflicts");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="schedulerconflicts-screen"]`).should("be.visible");
  cy.get(`[data-cy="schedulerconflicts-title"]`).should("be.visible");
  cy.get(`[data-cy="schedulerconflicts-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("scheduler_conflicts");

  cy.visit("/staff/scheduler-open-shifts");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="scheduleropenshifts-screen"]`).should("be.visible");
  cy.get(`[data-cy="scheduleropenshifts-title"]`).should("be.visible");
  cy.get(`[data-cy="scheduleropenshifts-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("scheduler_open_shifts");

  cy.visit("/staff/scheduler-provider-availability");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="schedulerprovideravailability-screen"]`).should("be.visible");
  cy.get(`[data-cy="schedulerprovideravailability-title"]`).should("be.visible");
  cy.get(`[data-cy="schedulerprovideravailability-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("scheduler_provider_availability");

  cy.visit("/staff/scheduling-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="schedulingdashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="schedulingdashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="schedulingdashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("scheduling_dashboard");

  cy.visit("/staff/calendar-management");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="calendarmanagement-screen"]`).should("be.visible");
  cy.get(`[data-cy="calendarmanagement-title"]`).should("be.visible");
  cy.get(`[data-cy="calendarmanagement-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("calendar_management");

  cy.visit("/staff/conflict-resolution");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="conflictresolution-screen"]`).should("be.visible");
  cy.get(`[data-cy="conflictresolution-title"]`).should("be.visible");
  cy.get(`[data-cy="conflictresolution-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("conflict_resolution");

  cy.visit("/staff/open-shift");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="openshift-screen"]`).should("be.visible");
  cy.get(`[data-cy="openshift-title"]`).should("be.visible");
  cy.get(`[data-cy="openshift-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("open_shift");

  cy.visit("/staff/scheduling-operations4-k");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="schedulingoperations4k-screen"]`).should("be.visible");
  cy.get(`[data-cy="schedulingoperations4k-title"]`).should("be.visible");
  cy.get(`[data-cy="schedulingoperations4k-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("scheduling_operations4_k");

  });
});
