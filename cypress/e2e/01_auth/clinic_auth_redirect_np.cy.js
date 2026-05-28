// AUTO-GENERATED ROLE-APP REDIRECT SPEC. DO NOT EDIT.
// Generated from SQLite governance database.
// Dynamic targets: app = clinic, role = np

describe("Auth Redirect - np", () => {
  it("performs dynamic SSO auth and verifies landing on clinic app shell", () => {
    cy.loginAsRole("np");
  });
});
