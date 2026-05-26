describe("Language Governance Test", () => {
  it("changes language from topbar and verifies UI updates", () => {
    cy.visit("/psw/dashboard");
    cy.wait(2000);

    cy.get('[data-cy="app-topbar"]').should("exist");
    cy.get('[data-cy="topbar-language-switcher"]').should("exist").click();
    cy.wait(2000);

    cy.get('[data-cy="topbar-language-option-fr"]').click();
    cy.wait(2000);

    cy.get('[data-cy="app-topbar"]').should("contain.text", "FR");
    cy.get('[data-cy="app-sidebar"]').should("exist");
    cy.get('[data-cy="app-content-slot"]').should("exist");

    cy.reload();
    cy.wait(2000);

    cy.get('[data-cy="topbar-language-switcher"]').should("contain.text", "FR");

    cy.screenshot("language-change-psw-dashboard-fr");
  });
});
