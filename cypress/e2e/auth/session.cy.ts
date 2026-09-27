import { AppHubPage } from "../pages/auth/AppHubPage";

describe("Authentication - Session & State Persistence", () => {
  const appHubPage = new AppHubPage();

  beforeEach(() => {
    cy.clearAuthState();
  });

  it("should create correct localStorage keys upon successful login", () => {
    cy.login("ceo@primecare.com", "password");
    appHubPage.assertTitleVisible();
    
    cy.window().then((win) => {
      const token = win.localStorage.getItem("flutter.auth_token");
      const role = win.localStorage.getItem("flutter.auth_role");
      
      expect(token).to.not.be.null;
      expect(role).to.not.be.null;
      
      const cleanRole = role!.replace(/"/g, "").trim();
      expect(cleanRole).to.equal("ceo");
    });
  });

  it("should persist session and correct role after page refresh", () => {
    cy.login("ceo@primecare.com", "password");
    appHubPage.assertTitleVisible();
    
    appHubPage.visit()
      .assertUserRole("ceo");
  });
});
