describe("Language Governance EN FR ES", () => {
  it("switches languages and verifies visible UI", () => {
    cy.loginAsRole(Cypress.env("ROLE_CODE") || "psw");

    const locales = ["en", "fr", "es"];

    for (const locale of locales) {
      cy.switchLanguage(locale);
      cy.verifyShellExists();
      cy.verifyNotBlank();
      cy.screenshot(`language-${locale}`);
    }

    cy.reload();
    cy.waitAndSee();
    cy.verifyShellExists();
    cy.verifyNotBlank();
  });
});
