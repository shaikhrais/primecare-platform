import { LoginPage } from "../pages/auth/LoginPage";
import { AppHubPage } from "../pages/auth/AppHubPage";
import { ForgotPasswordPage } from "../pages/auth/ForgotPasswordPage";
import { DashboardPage } from "../pages/auth/DashboardPage";
import { getExpectedSidebarLinks, getRoleDashboardRoute } from "../../support/db-utils";

describe("PrimeCare Auth Test Suite (TestNG Style)", () => {
  const loginPage = new LoginPage();
  const appHubPage = new AppHubPage();
  const forgotPasswordPage = new ForgotPasswordPage();
  const dashboardPage = new DashboardPage();

  beforeEach(() => {
    // Clear state before each test method (like a clean session start)
    cy.clearAuthState();
    cy.intercept("POST", "**/auth/forgot-password", {
      statusCode: 200,
      body: { status: "success" }
    }).as("forgotPasswordMock");
  });

  it("Test Priority 1: Verify Login Page Render & Empty Validations", () => {
    cy.log("====== STARTING TEST: VERIFY LOGIN PAGE RENDER & VALIDATIONS ======");
    
    loginPage.visit()
      .assertTitleVisible();
      
    loginPage.getEmailField().should("be.visible");
    loginPage.getPasswordField().should("be.visible");
    loginPage.getSubmitButton().should("be.visible");

    // Click submit empty to trigger validators
    loginPage.clickSubmit();
    
    loginPage.assertValidationError("Identifier is required");
    loginPage.assertValidationError("Security token is required");
    
    cy.log("====== TEST COMPLETED CLEANLY: VERIFY LOGIN PAGE RENDER & VALIDATIONS ======");
  });

  it("Test Priority 2: Verify Forgot Password dialog and submission", () => {
    cy.log("====== STARTING TEST: VERIFY FORGOT PASSWORD FLOW ======");
    
    loginPage.visit()
      .openForgotPassword();

    forgotPasswordPage.getDialogTitle().should("be.visible");
    forgotPasswordPage.getEmailInput().should("be.visible");

    forgotPasswordPage.typeEmail("ceo@primecare.com")
      .clickSendRecovery();

    cy.wait("@forgotPasswordMock");
    loginPage.assertValidationError("Password reset link sent to ceo@primecare.com");
    
    cy.log("====== TEST COMPLETED CLEANLY: VERIFY FORGOT PASSWORD FLOW ======");
  });

  it("Test Priority 3: Verify successful login and Hub Card navigation", () => {
    cy.log("====== STARTING TEST: VERIFY SUCCESSFUL LOGIN FLOW ======");
    
    cy.login("ceo@primecare.com", "password");
    
    appHubPage.assertTitleVisible()
      .assertUserRole("ceo")
      .assertCardVisible("Corporate Headquarters");

    appHubPage.clickCard("Corporate Headquarters");

    getRoleDashboardRoute("ceo").then((route) => {
      dashboardPage.assertUrlContains(route);
    });

    getExpectedSidebarLinks("ceo").then((links) => {
      links.slice(0, 3).forEach((linkName) => {
        dashboardPage.assertSidebarLinkVisible(linkName);
      });
    });
      
    cy.log("====== TEST COMPLETED CLEANLY: VERIFY SUCCESSFUL LOGIN FLOW ======");
  });

  it("Test Priority 4: Verify logout functionality and protected routes redirect", () => {
    cy.log("====== STARTING TEST: VERIFY LOGOUT AND ROUTE GUARDS ======");
    
    cy.login("ceo@primecare.com", "password");
    appHubPage.assertTitleVisible();
    
    appHubPage.clickLogout();
    loginPage.assertTitleVisible();

    // Verify visiting protected routes redirect back to login page
    cy.visitProtectedRoute("/success");
    loginPage.assertTitleVisible();

    cy.visitProtectedRoute("/consent");
    loginPage.assertTitleVisible();
    
    cy.log("====== TEST COMPLETED CLEANLY: VERIFY LOGOUT AND ROUTE GUARDS ======");
  });
});
