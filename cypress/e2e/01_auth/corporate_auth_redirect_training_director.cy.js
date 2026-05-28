// AUTO-GENERATED ROLE-APP REDIRECT SPEC. DO NOT EDIT.
// Generated from SQLite governance database.
// Dynamic targets: app = corporate, role = training_director

describe("Auth Redirect - training_director", () => {
  it("performs dynamic SSO auth and verifies landing on corporate app shell", () => {
    cy.loginAsRole("training_director");
  });
});
