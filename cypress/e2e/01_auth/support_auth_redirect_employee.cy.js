// AUTO-GENERATED ROLE-APP REDIRECT SPEC. DO NOT EDIT.
// Generated from SQLite governance database.
// Dynamic targets: app = support, role = employee

describe("Auth Redirect - employee", () => {
  it("performs dynamic SSO auth and verifies landing on support app shell", () => {
    cy.loginAsRole("employee");
  });
});
