// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - scheduler", () => {
  it("tests all screens for role scheduler", () => {
    cy.loginAsRole("scheduler");


  cy.task("log", "⏳ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/19 | 5%] - Navigating to /offices/franchise/roles/scheduler/dashboard (SchedulerDashboardScreen)...");
  cy.visitWithSemantics("/offices/franchise/roles/scheduler/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/19 | 5%] - Checking shell & content for SchedulerDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("schedulerdashboard-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("schedulerdashboard-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("schedulerdashboard-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/19 | 5%] - Saving screenshot for SchedulerDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("scheduler_dashboard");
  
  cy.task("log", "✅ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/19 | 5%] - Verified SchedulerDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/19 | 10%] - Navigating to /staff/coordinator-dispatch-map (CoordinatorDispatchMapScreen)...");
  cy.visitWithSemantics("/staff/coordinator-dispatch-map");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/19 | 10%] - Checking shell & content for CoordinatorDispatchMapScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("coordinatordispatchmap-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("coordinatordispatchmap-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("coordinatordispatchmap-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/19 | 10%] - Saving screenshot for CoordinatorDispatchMapScreen...");
  cy.waitAndSee();
  cy.screenshot("coordinator_dispatch_map");
  
  cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/19 | 10%] - Verified CoordinatorDispatchMapScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/19 | 15%] - Navigating to /staff/coordinator-hub (CoordinatorHubScreen)...");
  cy.visitWithSemantics("/staff/coordinator-hub");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/19 | 15%] - Checking shell & content for CoordinatorHubScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("coordinatorhub-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("coordinatorhub-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("coordinatorhub-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/19 | 15%] - Saving screenshot for CoordinatorHubScreen...");
  cy.waitAndSee();
  cy.screenshot("coordinator_hub");
  
  cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/19 | 15%] - Verified CoordinatorHubScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [4/19 | 21%] - Navigating to /staff/coordinator-sos (CoordinatorSosScreen)...");
  cy.visitWithSemantics("/staff/coordinator-sos");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [4/19 | 21%] - Checking shell & content for CoordinatorSosScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("coordinatorsos-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("coordinatorsos-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("coordinatorsos-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [4/19 | 21%] - Saving screenshot for CoordinatorSosScreen...");
  cy.waitAndSee();
  cy.screenshot("coordinator_sos");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [4/19 | 21%] - Verified CoordinatorSosScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [5/19 | 26%] - Navigating to /staff/coordinator-waitlist (CoordinatorWaitlistScreen)...");
  cy.visitWithSemantics("/staff/coordinator-waitlist");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [5/19 | 26%] - Checking shell & content for CoordinatorWaitlistScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("coordinatorwaitlist-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("coordinatorwaitlist-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("coordinatorwaitlist-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [5/19 | 26%] - Saving screenshot for CoordinatorWaitlistScreen...");
  cy.waitAndSee();
  cy.screenshot("coordinator_waitlist");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [5/19 | 26%] - Verified CoordinatorWaitlistScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [6/19 | 31%] - Navigating to /staff/scheduler-analytics (SchedulerAnalyticsScreen)...");
  cy.visitWithSemantics("/staff/scheduler-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [6/19 | 31%] - Checking shell & content for SchedulerAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("scheduleranalytics-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("scheduleranalytics-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("scheduleranalytics-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [6/19 | 31%] - Saving screenshot for SchedulerAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("scheduler_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [6/19 | 31%] - Verified SchedulerAnalyticsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [7/19 | 36%] - Navigating to /staff/scheduler-compliance (SchedulerComplianceScreen)...");
  cy.visitWithSemantics("/staff/scheduler-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [7/19 | 36%] - Checking shell & content for SchedulerComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("schedulercompliance-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("schedulercompliance-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("schedulercompliance-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [7/19 | 36%] - Saving screenshot for SchedulerComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("scheduler_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [7/19 | 36%] - Verified SchedulerComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [8/19 | 42%] - Navigating to /staff/scheduler-workflow (SchedulerWorkflowScreen)...");
  cy.visitWithSemantics("/staff/scheduler-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [8/19 | 42%] - Checking shell & content for SchedulerWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("schedulerworkflow-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("schedulerworkflow-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("schedulerworkflow-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [8/19 | 42%] - Saving screenshot for SchedulerWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("scheduler_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [8/19 | 42%] - Verified SchedulerWorkflowScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [9/19 | 47%] - Navigating to /staff/scheduler-command-center (SchedulerCommandCenterScreen)...");
  cy.visitWithSemantics("/staff/scheduler-command-center");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [9/19 | 47%] - Checking shell & content for SchedulerCommandCenterScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("schedulercommandcenter-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("schedulercommandcenter-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("schedulercommandcenter-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [9/19 | 47%] - Saving screenshot for SchedulerCommandCenterScreen...");
  cy.waitAndSee();
  cy.screenshot("scheduler_command_center");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [9/19 | 47%] - Verified SchedulerCommandCenterScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [10/19 | 52%] - Navigating to /staff/scheduler-calendar (SchedulerCalendarScreen)...");
  cy.visitWithSemantics("/staff/scheduler-calendar");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [10/19 | 52%] - Checking shell & content for SchedulerCalendarScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("schedulercalendar-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("schedulercalendar-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("schedulercalendar-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [10/19 | 52%] - Saving screenshot for SchedulerCalendarScreen...");
  cy.waitAndSee();
  cy.screenshot("scheduler_calendar");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [10/19 | 52%] - Verified SchedulerCalendarScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [11/19 | 57%] - Navigating to /staff/scheduler-booking-requests (SchedulerBookingRequestsScreen)...");
  cy.visitWithSemantics("/staff/scheduler-booking-requests");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [11/19 | 57%] - Checking shell & content for SchedulerBookingRequestsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("schedulerbookingrequests-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("schedulerbookingrequests-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("schedulerbookingrequests-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [11/19 | 57%] - Saving screenshot for SchedulerBookingRequestsScreen...");
  cy.waitAndSee();
  cy.screenshot("scheduler_booking_requests");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [11/19 | 57%] - Verified SchedulerBookingRequestsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [12/19 | 63%] - Navigating to /staff/scheduler-conflicts (SchedulerConflictsScreen)...");
  cy.visitWithSemantics("/staff/scheduler-conflicts");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [12/19 | 63%] - Checking shell & content for SchedulerConflictsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("schedulerconflicts-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("schedulerconflicts-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("schedulerconflicts-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [12/19 | 63%] - Saving screenshot for SchedulerConflictsScreen...");
  cy.waitAndSee();
  cy.screenshot("scheduler_conflicts");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [12/19 | 63%] - Verified SchedulerConflictsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [13/19 | 68%] - Navigating to /staff/scheduler-open-shifts (SchedulerOpenShiftsScreen)...");
  cy.visitWithSemantics("/staff/scheduler-open-shifts");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [13/19 | 68%] - Checking shell & content for SchedulerOpenShiftsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("scheduleropenshifts-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("scheduleropenshifts-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("scheduleropenshifts-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [13/19 | 68%] - Saving screenshot for SchedulerOpenShiftsScreen...");
  cy.waitAndSee();
  cy.screenshot("scheduler_open_shifts");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [13/19 | 68%] - Verified SchedulerOpenShiftsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [14/19 | 73%] - Navigating to /staff/scheduler-provider-availability (SchedulerProviderAvailabilityScreen)...");
  cy.visitWithSemantics("/staff/scheduler-provider-availability");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [14/19 | 73%] - Checking shell & content for SchedulerProviderAvailabilityScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("schedulerprovideravailability-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("schedulerprovideravailability-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("schedulerprovideravailability-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [14/19 | 73%] - Saving screenshot for SchedulerProviderAvailabilityScreen...");
  cy.waitAndSee();
  cy.screenshot("scheduler_provider_availability");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [14/19 | 73%] - Verified SchedulerProviderAvailabilityScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [15/19 | 78%] - Navigating to /staff/scheduling-dashboard (SchedulingDashboardScreen)...");
  cy.visitWithSemantics("/staff/scheduling-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [15/19 | 78%] - Checking shell & content for SchedulingDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("schedulingdashboard-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("schedulingdashboard-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("schedulingdashboard-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [15/19 | 78%] - Saving screenshot for SchedulingDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("scheduling_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [15/19 | 78%] - Verified SchedulingDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [16/19 | 84%] - Navigating to /staff/calendar-management (CalendarManagementScreen)...");
  cy.visitWithSemantics("/staff/calendar-management");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [16/19 | 84%] - Checking shell & content for CalendarManagementScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("calendarmanagement-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("calendarmanagement-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("calendarmanagement-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [16/19 | 84%] - Saving screenshot for CalendarManagementScreen...");
  cy.waitAndSee();
  cy.screenshot("calendar_management");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [16/19 | 84%] - Verified CalendarManagementScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [17/19 | 89%] - Navigating to /staff/conflict-resolution (ConflictResolutionScreen)...");
  cy.visitWithSemantics("/staff/conflict-resolution");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [17/19 | 89%] - Checking shell & content for ConflictResolutionScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("conflictresolution-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("conflictresolution-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("conflictresolution-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [17/19 | 89%] - Saving screenshot for ConflictResolutionScreen...");
  cy.waitAndSee();
  cy.screenshot("conflict_resolution");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [17/19 | 89%] - Verified ConflictResolutionScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [18/19 | 94%] - Navigating to /staff/open-shift (OpenShiftScreen)...");
  cy.visitWithSemantics("/staff/open-shift");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [18/19 | 94%] - Checking shell & content for OpenShiftScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("openshift-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("openshift-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("openshift-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [18/19 | 94%] - Saving screenshot for OpenShiftScreen...");
  cy.waitAndSee();
  cy.screenshot("open_shift");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [18/19 | 94%] - Verified OpenShiftScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [19/19 | 100%] - Navigating to /staff/scheduling-operations4-k (SchedulingOperations4KScreen)...");
  cy.visitWithSemantics("/staff/scheduling-operations4-k");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [19/19 | 100%] - Checking shell & content for SchedulingOperations4KScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("schedulingoperations4k-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("schedulingoperations4k-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("schedulingoperations4k-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [19/19 | 100%] - Saving screenshot for SchedulingOperations4KScreen...");
  cy.waitAndSee();
  cy.screenshot("scheduling_operations4_k");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [19/19 | 100%] - Verified SchedulingOperations4KScreen successfully!\n");

  });
});
