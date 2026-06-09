// AUTO-GENERATED ROLE-APP REDIRECT SPEC. DO NOT EDIT.
// Generated from SQLite governance database.
// Dynamic targets: app = governance, role = volunteer

describe("Auth Redirect - volunteer", () => {
  it("performs dynamic SSO auth and verifies landing on governance app shell", () => {
    cy.loginAsRole("volunteer");
  });
});
