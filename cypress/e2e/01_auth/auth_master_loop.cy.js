// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.

const users = require("../../fixtures/governance/test_users.json");

describe("Auth - Master Loop All Roles", () => {
  users.forEach((user) => {
    it(`verifies login for role: ${user.role_code}`, () => {
      // Use custom reusable command defined in cypress/support/commands.js
      cy.loginAsRole(user.role_code);
    });
  });
});
