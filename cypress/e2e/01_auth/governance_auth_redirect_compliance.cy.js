// AUTO-GENERATED ROLE-APP REDIRECT SPEC. DO NOT EDIT.
// Generated from SQLite governance database.
// Dynamic targets: app = governance, role = compliance

describe("Auth Redirect - compliance", () => {
  it("performs dynamic SSO auth and verifies landing on governance app shell", () => {
    cy.loginAsRole("compliance");
  });
});
