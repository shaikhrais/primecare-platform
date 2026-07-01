import { LoginPage } from "../pages/auth/LoginPage";
import { AppHubPage } from "../pages/auth/AppHubPage";

describe("Authentication - Login Flow", () => {
  const loginPage = new LoginPage();
  const appHubPage = new AppHubPage();

  beforeEach(() => {
    cy.clearAuthState();
  });

  it("should render the login page correctly", () => {
    loginPage.visit()
      .assertTitleVisible();
    loginPage.getEmailField().should("be.visible");
    loginPage.getPasswordField().should("be.visible");
    loginPage.getSubmitButton().should("be.visible");
  });

  it("should show validation errors when fields are empty", () => {
    loginPage.visit();
    cy.wait(2000);
    loginPage.clickSubmit()
      .assertValidationError("Identifier is required")
      .assertValidationError("Security token is required");
  });

  it("should show validation error for invalid email format", () => {
    loginPage.visit();
    cy.wait(2000);
    
    loginPage.typeEmail("invalid-email");
    loginPage.typePassword("somepassword");
    loginPage.clickSubmit()
      .assertValidationError("Invalid email format");
  });

  it("should display an error for incorrect credentials", () => {
    // Intercept login and force it to fail with a 401
    cy.intercept("POST", "**/auth/login", {
      statusCode: 401,
      body: { error: "Authentication failed. Invalid credentials." }
    }).as("loginFailure");

    loginPage.visit();
    cy.wait(2000);
    
    loginPage.typeEmail("wrong@primecare.com");
    loginPage.typePassword("wrongpassword");
    loginPage.clickSubmit();
    
    cy.wait("@loginFailure");
    loginPage.assertValidationError("Authentication failed");
  });

  it("should log in successfully with valid test credentials", () => {
    cy.login("ceo@primecare.com", "password");
    appHubPage.assertTitleVisible();
  });
});
