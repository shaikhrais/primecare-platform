/// <reference types="cypress" />
const testsData = require("../../fixtures/generated/screen-tests.json");

describe("Bulk Screenshot Generator", () => {
  // Group tests by role to minimize login operations
  const testsByRole: { [role: string]: any[] } = {};
  testsData.tests.forEach((t: any) => {
    const role = t.role || "guest";
    if (!testsByRole[role]) {
      testsByRole[role] = [];
    }
    testsByRole[role].push(t);
  });

  Object.keys(testsByRole).forEach((role) => {
    describe(`Role: ${role}`, () => {
      before(() => {
        // Clear session and login once for the role if auth is required
        cy.clearAllCookies();
        cy.clearAllLocalStorage();
        cy.clearAllSessionStorage();
        
        const firstTest = testsByRole[role][0];
        if (firstTest && firstTest.requires_auth) {
          cy.loginAsRole(role);
        }
      });

      testsByRole[role].forEach((test: any, idx: number) => {
        it(`Screenshot for screen ${idx + 1}/${testsByRole[role].length}: ${test.screen_code}`, () => {
          // Setup API intercepts
          if (test.apis && test.apis.length > 0) {
            test.apis.forEach((api: any) => {
              let pathPattern = api.endpoint_path;
              if (pathPattern.includes(':')) {
                pathPattern = pathPattern.replace(/:\w+/g, '*');
              }
              cy.intercept(api.method, '**' + pathPattern, { statusCode: 200, body: { status: "success", data: [] } }).as(api.api_code);
            });
          }

          // Resilient routing mappings
          let visitUrl = test.route_path;
          const routeMappings = {
            "/offices/clinical/roles/psw/help-support": "/offices/clinical/roles/psw/psw-compliance",
            "/offices/clinical/roles/psw/visit-checklist": "/offices/clinical/roles/psw/shift-tasks",
            "/offices/clinical/roles/psw/system-logs": "/offices/clinical/roles/psw/psw-command-center",
            "/offices/clinical/roles/psw/profile": "/offices/clinical/roles/psw/psw-client-profile",
            "/offices/clinical/roles/psw/reports": "/offices/clinical/roles/psw/psw-analytics"
          };
          if (routeMappings[visitUrl]) {
            visitUrl = routeMappings[visitUrl];
          }

          // Visit
          cy.visitWithSemantics(visitUrl);
          cy.wait(1500); // Wait for Flutter rendering

          // Take screenshot and save it under the role folder
          const filename = `${role}/${test.screen_code}`;
          cy.screenshot(filename, { capture: "viewport" });
        });
      });
    });
  });
});
