// AUTO-GENERATED ROLE-APP REDIRECT SPEC. DO NOT EDIT.
// Generated from SQLite governance database.
// Dynamic targets: app = franchise, role = hr_hiring

describe("Auth Redirect - hr_hiring", () => {
  it("performs dynamic SSO auth and verifies landing on franchise app shell", () => {
    cy.loginAsRole("hr_hiring");
  });
});
