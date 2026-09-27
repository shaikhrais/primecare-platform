export class AppHubPage {
  visit() {
    cy.visitWithSemantics("/success");
    return this;
  }

  getLogoutButton() {
    return cy.document().then((doc) => {
      const host = doc.querySelector('flt-glass-pane')?.shadowRoot || doc;
      const jq = Cypress.$(host);
      const selectors = [
        '[aria-label*="auth-logout-button"]',
        '[data-cy="auth-logout-button"]',
        '[aria-label*="Sign Out"]',
        '[aria-label*="sign out"]',
        '[aria-label*="logout"]',
        'flt-semantics:contains("Sign Out")',
        'flt-semantics:contains("logout")'
      ];
      for (const sel of selectors) {
        const el = jq.find(sel);
        if (el.length > 0) {
          return cy.wrap(el.first());
        }
      }
      return cy.getCy("auth-logout-button");
    });
  }

  clickLogout() {
    this.getLogoutButton().first().click({ force: true });
    cy.wait(4000);
    return this;
  }

  assertTitleVisible() {
    cy.contains("Application Hub", { timeout: 20000 }).should("be.visible");
    return this;
  }

  assertUserRole(role: string) {
    cy.contains(role.toUpperCase()).should("be.visible");
    return this;
  }

  assertCardVisible(cardName: string) {
    cy.contains(cardName).should("be.visible");
    return this;
  }

  clickCard(cardName: string) {
    cy.contains(cardName).first().click({ force: true });
    cy.wait(8000);
    return this;
  }
}
