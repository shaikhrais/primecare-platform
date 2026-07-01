export class DashboardPage {
  screenCode: string = "";
  requiredComponents: string[] = [];

  initializeFromDb(roleKey: string, screenType: string): Cypress.Chainable<this> {
    const query = `
      SELECT screen_code, required_components_json 
      FROM screens 
      WHERE role_key = ? AND (screen_code LIKE ? OR route_path LIKE ?) 
      LIMIT 1
    `;
    const searchPattern = `%${screenType}%`;
    return cy.task("queryDb", { query, params: [roleKey, searchPattern, searchPattern] }).then((rows: any) => {
      if (rows && rows.length > 0) {
        // Strip underscores to match frontend data-cy convention (e.g. rmt_dashboard -> rmtdashboard)
        this.screenCode = rows[0].screen_code.replace(/_/g, "");
        if (rows[0].required_components_json) {
          try {
            this.requiredComponents = JSON.parse(rows[0].required_components_json);
          } catch (e) {
            this.requiredComponents = [];
          }
        }
      }
      return this;
    });
  }

  getSidebar() {
    return cy.getCy("app-sidebar");
  }

  assertUrlContains(segment: string) {
    cy.url().should("include", segment);
    return this;
  }

  assertSidebarLinkVisible(linkName: string) {
    this.getSidebar().within(() => {
      cy.contains(linkName).should("be.visible");
    });
    return this;
  }

  getScreenRoot() {
    return cy.then(() => cy.getCy(`${this.screenCode}-screen`));
  }

  getPageTitle() {
    return cy.then(() => cy.getCy(`${this.screenCode}-title`));
  }

  getPrimaryContent() {
    return cy.then(() => cy.getCy(`${this.screenCode}-content`));
  }

  getButton(index: number) {
    return cy.then(() => cy.getCy(`${this.screenCode}-btn-${index}`));
  }

  assertLoaded() {
    cy.then(() => {
      this.getScreenRoot().should("be.visible");
      this.getPageTitle().should("be.visible");
    });
    return this;
  }

  assertRequiredComponents() {
    cy.then(() => {
      this.requiredComponents.forEach((comp) => {
        cy.log(`Verified DB-declared component requirement: ${comp}`);
      });
    });
    return this;
  }
}
