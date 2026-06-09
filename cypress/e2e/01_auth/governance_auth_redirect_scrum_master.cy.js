// AUTO-GENERATED ROLE-APP REDIRECT SPEC. DO NOT EDIT.
// Generated from SQLite governance database.
// Dynamic targets: app = governance, role = scrum_master

describe("Auth Redirect - scrum_master", () => {
  it("performs dynamic SSO auth and verifies landing on governance app shell", () => {
    cy.loginAsRole("scrum_master");
  });
});
