export class ForgotPasswordPage {
  getDialogTitle() {
    return cy.contains("Password Recovery");
  }

  getInstructions() {
    return cy.contains("Enter your email address");
  }

  getEmailInput() {
    return cy.get('input, textarea').last();
  }

  getCancelButton() {
    return cy.contains("CANCEL");
  }

  getSendRecoveryButton() {
    return cy.contains("SEND RECOVERY LINK");
  }

  typeEmail(email: string) {
    this.getEmailInput().type(email, { force: true });
    cy.wait(500);
    return this;
  }

  clickCancel() {
    this.getCancelButton().click({ force: true });
    return this;
  }

  clickSendRecovery() {
    this.getSendRecoveryButton().click({ force: true });
    cy.wait(3000);
    return this;
  }

  assertDialogNotVisible() {
    this.getDialogTitle().should("not.exist");
    return this;
  }
}
