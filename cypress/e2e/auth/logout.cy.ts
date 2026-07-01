import { AppHubPage } from "../pages/auth/AppHubPage";
import { LoginPage } from "../pages/auth/LoginPage";

describe("Authentication - Logout Flow", () => {
  const appHubPage = new AppHubPage();
  const loginPage = new LoginPage();

  beforeEach(() => {
    cy.clearAuthState();
  });

  it("should log out successfully and redirect to login page", () => {
    cy.login("ceo@primecare.com", "password");
    appHubPage.assertTitleVisible();
    appHubPage.clickLogout();
    loginPage.assertTitleVisible();
  });
});
