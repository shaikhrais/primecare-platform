describe("Language Governance EN/FR/ES", () => {
  it("switches EN FR ES and verifies topbar/sidebar/content", () => {
    cy.fixture("governance/languages.json").then((languages) => {
      const activeLocales = languages.map((l) => l.locale_code);

      expect(activeLocales).to.deep.eq(["en", "fr", "es"]);

      cy.loginAsRole("psw");
      cy.wait(2000);

      cy.verifyShellExists();

      for (const locale of activeLocales) {
        cy.switchLanguage(locale);

        cy.get('[data-cy="app-topbar"]').should("exist");
        cy.get('[data-cy="app-sidebar"]').should("exist");
        cy.get('[data-cy="app-content-slot"]').should("exist");

        cy.get('[data-cy="app-shell"]').should("be.visible");
        cy.get('[data-cy="app-content-slot"]').should("be.visible");
        cy.get("body").invoke("text").should("not.be.empty");
        cy.wait(2000);
        cy.screenshot(`language-${locale}-shell`, { capture: "viewport" });
        cy.wait(2000);
      }

      cy.reload();
      cy.wait(2000);

      cy.verifyShellExists();
      cy.get('[data-cy="topbar-language-switcher"]').should("exist");
    });
  });
});
