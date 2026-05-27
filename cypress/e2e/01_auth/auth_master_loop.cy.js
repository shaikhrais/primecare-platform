// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.

describe("Auth - Master Loop All Roles", () => {
  beforeEach(() => {
    // Clean up local storage and cookies to isolate each role's session
    cy.clearCookies();
    cy.clearLocalStorage();
  });

  it("verifies login for all platform roles sequentially", () => {
    cy.fixture("governance/test_users.json").then((users) => {
      // Execute login and shell validation for every single role in the system
      users.forEach((user) => {
        cy.log(`-----------------------------------------------`);
        cy.log(`🔑 INITIATING LOGIN TEST FOR ROLE: ${user.role_code.toUpperCase()}`);
        cy.log(`-----------------------------------------------`);

        // Use custom reusable command defined in cypress/support/commands.js
        cy.loginAsRole(user.role_code);

        // Reset session state immediately
        cy.clearCookies();
        cy.clearLocalStorage();
      });
    });
  });
});
