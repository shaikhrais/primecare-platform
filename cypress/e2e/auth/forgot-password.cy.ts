import { LoginPage } from "../pages/auth/LoginPage";
import { ForgotPasswordPage } from "../pages/auth/ForgotPasswordPage";

describe("Authentication - Forgot Password Flow", () => {
  const loginPage = new LoginPage();
  const forgotPasswordPage = new ForgotPasswordPage();

  beforeEach(() => {
    cy.clearAuthState();
    // Intercept forgot-password API request to prevent ECONNREFUSED when running locally
    cy.intercept("POST", "**/auth/forgot-password", {
      statusCode: 200,
      body: { status: "success" }
    }).as("forgotPasswordMock");
  });

  it("should open the Forgot Password recovery dialog", () => {
    loginPage.visit()
      .openForgotPassword();
      
    forgotPasswordPage.getDialogTitle().should("be.visible");
    forgotPasswordPage.getInstructions().should("be.visible");
    forgotPasswordPage.getEmailInput().should("be.visible");
    forgotPasswordPage.getCancelButton().should("be.visible");
    forgotPasswordPage.getSendRecoveryButton().should("be.visible");
    
    forgotPasswordPage.clickCancel()
      .assertDialogNotVisible();
  });

  it("should submit the password recovery request successfully", () => {
    loginPage.visit()
      .openForgotPassword();
      
    forgotPasswordPage.typeEmail("ceo@primecare.com")
      .clickSendRecovery();
      
    cy.wait("@forgotPasswordMock");
    loginPage.assertValidationError("Password reset link sent to ceo@primecare.com");
  });
});
