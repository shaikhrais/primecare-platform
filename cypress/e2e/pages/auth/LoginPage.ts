export class LoginPage {
  visit() {
    cy.visitWithSemantics("/login");
    return this;
  }

  getEmailField() {
    return cy.getCy("login-email");
  }

  getPasswordField() {
    return cy.getCy("login-password");
  }

  getSubmitButton() {
    return cy.getCy("login-submit");
  }

  getForgotPasswordLink() {
    return cy.contains("Forgot Password?");
  }

  clearEmail() {
    this.getEmailField().then(($el) => {
      const input = $el.is("input") || $el.is("textarea") ? $el : $el.find("input, textarea");
      cy.wrap(input).first().clear({ force: true });
    });
    return this;
  }

  clearPassword() {
    this.getPasswordField().then(($el) => {
      const input = $el.is("input") || $el.is("textarea") ? $el : $el.find("input, textarea");
      cy.wrap(input).first().clear({ force: true });
    });
    return this;
  }

  typeEmail(email: string) {
    this.clearEmail();
    cy.typeIntoField("login-email", email);
    cy.wait(500);
    return this;
  }

  typePassword(password: string) {
    this.clearPassword();
    cy.typeIntoField("login-password", password);
    cy.wait(500);
    return this;
  }

  clickSubmit() {
    this.getSubmitButton().first().click({ force: true });
    return this;
  }

  openForgotPassword() {
    this.getForgotPasswordLink().first().click({ force: true });
    cy.wait(2000);
    return this;
  }

  assertTitleVisible() {
    cy.contains("Welcome to PrimeCare", { timeout: 15000 }).should("be.visible");
    return this;
  }

  assertValidationError(errorText: string) {
    cy.contains(errorText, { timeout: 5000 }).should("be.visible");
    return this;
  }
}
