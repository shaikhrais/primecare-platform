import { AppHubPage } from "../pages/auth/AppHubPage";
import { LoginPage } from "../pages/auth/LoginPage";

describe("Authentication - Protected Routes & Redirections", () => {
  const appHubPage = new AppHubPage();
  const loginPage = new LoginPage();

  beforeEach(() => {
    cy.clearAuthState();
  });

  it("should redirect unauthenticated users from /success to /login", () => {
    cy.visitProtectedRoute("/success");
    loginPage.assertTitleVisible();
  });

  it("should redirect unauthenticated users from /consent to /login", () => {
    cy.visitProtectedRoute("/consent");
    loginPage.assertTitleVisible();
  });

  it("should handle authenticated users trying to visit /login by logging them out or redirecting", () => {
    cy.login("ceo@primecare.com", "password");
    appHubPage.assertTitleVisible();
    
    loginPage.visit();
    loginPage.assertTitleVisible();
  });

  it("should redirect to login if local token is cleared/invalidated", () => {
    cy.login("ceo@primecare.com", "password");
    appHubPage.assertTitleVisible();
    
    cy.window().then((win) => {
      win.localStorage.removeItem("flutter.auth_token");
    });
    
    appHubPage.visit();
    loginPage.assertTitleVisible();
  });
});
