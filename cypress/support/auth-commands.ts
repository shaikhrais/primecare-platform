declare global {
  namespace Cypress {
    interface Chainable {
      login(email: string, password?: string): Chainable<void>;
      logout(): Chainable<void>;
      assertLoggedIn(): Chainable<void>;
      assertLoggedOut(): Chainable<void>;
      clearAuthState(): Chainable<void>;
      visitProtectedRoute(route: string): Chainable<void>;
      getCy(id: string): Chainable<any>;
      typeIntoField(id: string, text: string): Chainable<void>;
      verifyShellExists(): Chainable<void>;
      visitWithSemantics(path: string): Chainable<void>;
    }
  }
}

Cypress.Commands.add("login", (email, password) => {
  let role = email.split('@')[0];
  if (role.startsWith("qa.")) {
    role = role.substring(3);
  }

  const mockUserResponse = {
    userId: "test-user-id-" + role,
    roles: [role],
    status: "authenticated",
    activeRole: role,
    user: {
      id: "test-user-id-" + role,
      email: email,
      roles: [role],
      firstName: "QA",
      lastName: role.toUpperCase()
    }
  };

  cy.intercept("GET", "**/auth/me", mockUserResponse).as("authMeMock");
  cy.intercept("GET", "**/me", mockUserResponse).as("meMock");

  const mockLoginResponse = {
    status: "success",
    token: "mock-jwt-token-" + role,
    userId: "test-user-id-" + role,
    role: role,
    userName: "Active User",
    tenantId: "primecare_hq"
  };
  cy.intercept("POST", "**/login", mockLoginResponse).as("loginMock");
  cy.intercept("POST", "**/auth/login", mockLoginResponse).as("authLoginMock");

  cy.visitWithSemantics("/login");
  
  cy.getCy("login-email").then(($el) => {
    const input = $el.is("input") || $el.is("textarea") ? $el : $el.find("input, textarea");
    cy.wrap(input).first().clear({ force: true });
  });
  cy.typeIntoField("login-email", email);
  cy.wait(500);

  if (password) {
    cy.getCy("login-password").then(($el) => {
      const input = $el.is("input") || $el.is("textarea") ? $el : $el.find("input, textarea");
      cy.wrap(input).first().clear({ force: true });
    });
    cy.typeIntoField("login-password", password);
    cy.wait(500);
  }

  cy.getCy("login-submit").first().click({ force: true });
  cy.wait(6000); // wait for redirect to /success
});

Cypress.Commands.add("logout", () => {
  cy.url().then((url) => {
    if (!url.includes("/success")) {
      cy.visitWithSemantics("/success");
    }
  });
  cy.wait(2000);
  cy.getCy("auth-logout-button").first().click({ force: true });
  cy.wait(4000);
});



Cypress.Commands.add("assertLoggedIn", () => {
  cy.url().should("include", "/success");
  cy.contains("Application Hub", { timeout: 20000 }).should("be.visible");
});

Cypress.Commands.add("assertLoggedOut", () => {
  cy.url().should("include", "/login");
  cy.contains("PrimeCare", { timeout: 20000 }).should("be.visible");
});


Cypress.Commands.add("clearAuthState", () => {
  cy.clearAllCookies();
  cy.clearAllLocalStorage();
  cy.clearAllSessionStorage();
  cy.window().then((win) => {
    win.localStorage.clear();
    win.sessionStorage.clear();
    // Seed language defaults to prevent language selector redirect
    win.localStorage.setItem("flutter.auth_language_selected", "true");
    win.localStorage.setItem("flutter.auth_preferred_language", JSON.stringify("en"));
  });
});

Cypress.Commands.add("visitProtectedRoute", (route) => {
  cy.visitWithSemantics(route);
});

export {};
