import os
import sqlite3
import json

PROJECT_ROOT = r"C:\Users\Admin2\Documents\GitHub\primecare-platform"
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")
FIXTURE_PATH = os.path.join(PROJECT_ROOT, "cypress", "fixtures", "generated", "api-tests.json")
CYPRESS_SPEC_PATH = os.path.join(PROJECT_ROOT, "cypress", "e2e", "generated", "db-api-tests.cy.ts")

def main():
    print("==============================================================")
    print("EXPORTING API TESTS FROM DB TO CYPRESS FIXTURE & GENERATING SPEC")
    print("==============================================================")

    if not os.path.exists(DB_PATH):
        print(f"Error: Database not found at {DB_PATH}")
        return

    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    c = conn.cursor()

    # Query all active api test definitions
    c.execute("""
        SELECT td.id AS test_def_id, td.api_id, td.test_code, td.test_name, td.expected_status_code, 
               td.request_body_json, td.expected_response_keys_json, td.forbidden_response_keys_json,
               a.api_code, a.endpoint_path, a.method, a.auth_required, a.role_required
        FROM api_test_definitions td
        JOIN api_registry a ON td.api_id = a.id
        WHERE td.enabled = 1
        ORDER BY td.id ASC
    """)
    rows = c.fetchall()
    print(f"Found {len(rows)} API test definitions.")

    tests = []
    for r in rows:
        expected_keys = []
        if r["expected_response_keys_json"]:
            try:
                expected_keys = json.loads(r["expected_response_keys_json"])
            except:
                pass
                
        forbidden_keys = []
        if r["forbidden_response_keys_json"]:
            try:
                forbidden_keys = json.loads(r["forbidden_response_keys_json"])
            except:
                pass

        req_body = None
        if r["request_body_json"]:
            try:
                req_body = json.loads(r["request_body_json"])
            except:
                req_body = r["request_body_json"]

        tests.append({
            "test_definition_id": r["test_def_id"],
            "api_id": r["api_id"],
            "test_code": r["test_code"],
            "test_name": r["test_name"],
            "expected_status_code": r["expected_status_code"],
            "request_body": req_body,
            "expected_keys": expected_keys,
            "forbidden_keys": forbidden_keys,
            "api_code": r["api_code"],
            "endpoint_path": r["endpoint_path"].replace(":id", "test-id-123"), # Safe fallback for ID placeholders
            "method": r["method"],
            "auth_required": bool(r["auth_required"]),
            "role": r["role_required"] or "guest"
        })

    # Save to fixture
    os.makedirs(os.path.dirname(FIXTURE_PATH), exist_ok=True)
    with open(FIXTURE_PATH, "w", encoding="utf-8") as f:
        json.dump({"tests": tests}, f, indent=2)
    print(f"Saved E2E API tests fixture to: {FIXTURE_PATH}")

    # Generate Cypress spec code
    cypress_code = """/// <reference types="cypress" />
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
"""

    os.makedirs(os.path.dirname(CYPRESS_SPEC_PATH), exist_ok=True)
    with open(CYPRESS_SPEC_PATH, "w", encoding="utf-8") as f:
        f.write(cypress_code)
    print(f"Generated Cypress E2E API tests spec at: {CYPRESS_SPEC_PATH}")

    conn.close()
    print("API TEST GENERATION COMPLETE!")
    print("==============================================================")

if __name__ == "__main__":
    main()
