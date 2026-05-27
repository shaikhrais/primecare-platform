// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.

describe("App All Roles All Screens - Clinic Portal", () => {
  it("tests psw role inside clinic portal dashboard", () => {
    cy.loginAsRole("psw");
    
    // Open a valid clinic screen under psw role
    cy.visitWithSemantics("/#/success");
    cy.waitAndSee();
    cy.verifyNotBlank();
    cy.screenshot("clinic_portal_psw_dashboard");
  });
});
