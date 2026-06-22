// AUTO-GENERATED ROLE-APP REDIRECT SPEC. DO NOT EDIT.
// Generated from SQLite governance database.
// Dynamic targets: app = franchise, role = scheduler

describe("Auth Redirect - scheduler", () => {
  it("performs dynamic SSO auth and verifies landing on franchise app shell", () => {
    cy.loginAsRole("scheduler");
  });
});
