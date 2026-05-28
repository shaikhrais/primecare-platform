// AUTO-GENERATED ROLE-APP REDIRECT SPEC. DO NOT EDIT.
// Generated from SQLite governance database.
// Dynamic targets: app = governance, role = infrastructure

describe("Auth Redirect - infrastructure", () => {
  it("performs dynamic SSO auth and verifies landing on governance app shell", () => {
    cy.loginAsRole("infrastructure");
  });
});
