/// <reference types="cypress" />
const apiTests = require("../../fixtures/generated/api-tests.json");

describe("Database-Driven Dynamic API Integration Tests", () => {
  const runId = "api_run_" + Date.now();

  before(() => {
    // Optional: run any suite-level setup
  });

  apiTests.tests.forEach((test: any) => {
    describe(`API Test Case: ${test.test_code}`, () => {
      let startedAt = 0;

      beforeEach(() => {
        startedAt = Date.now();
        cy.clearAllCookies();
        cy.clearAllLocalStorage();
        cy.clearAllSessionStorage();
      });

      it(`Verifies endpoint ${test.method} ${test.endpoint_path}`, () => {
        if (test.auth_required) {
          cy.loginAsRole(test.role);
        }

        // Run HTTP request
        cy.request({
          method: test.method,
          url: test.endpoint_path,
          body: test.request_body,
          failOnStatusCode: false,
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json"
          }
        }).then((response) => {
          const duration = Date.now() - startedAt;
          let status = "passed";
          let errorMsg = null;

          try {
            // 1. Verify Status Code
            expect(response.status).to.eq(test.expected_status_code);

            // 2. Verify Expected Keys
            if (test.expected_keys && test.expected_keys.length > 0) {
              const body = response.body || {};
              test.expected_keys.forEach((key: string) => {
                expect(body).to.have.property(key);
              });
            }

            // 3. Verify Forbidden Keys
            if (test.forbidden_keys && test.forbidden_keys.length > 0) {
              const body = response.body || {};
              test.forbidden_keys.forEach((key: string) => {
                expect(body).to.not.have.property(key);
              });
            }
          } catch (e: any) {
            status = "failed";
            errorMsg = e.message;
            throw e;
          } finally {
            // Write result back to DB
            const insertResultQuery = `
              INSERT INTO api_test_results (api_test_definition_id, api_id, run_id, status, status_code, error_message, response_time_ms)
              VALUES (?, ?, ?, ?, ?, ?, ?)
            `;
            const params = [
              test.test_definition_id,
              test.api_id,
              runId,
              status,
              response.status,
              errorMsg,
              duration
            ];
            cy.task("queryDb", { query: insertResultQuery, params });

            // Update api_registry status
            const newStatus = status === "passed" ? "tested" : "implemented";
            cy.task("queryDb", {
              query: "UPDATE api_registry SET status = ? WHERE id = ?",
              params: [newStatus, test.api_id]
            });

            // Write issues if failed
            if (status === "failed") {
              const findBlockedScreensQuery = `
                SELECT screen_id FROM screen_api_map WHERE api_id = ?
              `;
              cy.task("queryDb", { query: findBlockedScreensQuery, params: [test.api_id] }).then((rows: any) => {
                if (rows && rows.length > 0) {
                  rows.forEach((row: any) => {
                    const insertIssueQuery = `
                      INSERT INTO screen_issues (screen_id, issue_type, severity, description, fixed)
                      VALUES (?, 'api_failure', 'high', ?, 0)
                    `;
                    const desc = `API failure blocking screen. Test: ${test.test_code}. Error: ${errorMsg}`;
                    cy.task("queryDb", { query: insertIssueQuery, params: [row.screen_id, desc] });
                  });
                }
              });
            }
          }
        });
      });
    });
  });
});
