describe("Auth Redirect Debug", () => {
  it("redirects correctly to redirect_uri after login", () => {
    cy.clearAllCookies();
    cy.clearAllLocalStorage();
    cy.clearAllSessionStorage();

    // Intercept POST **/login request
    cy.intercept("POST", "**/login", (req) => {
      req.reply({
        statusCode: 200,
        body: {
          status: "success",
          token: "mock-token-exchange-success",
          userId: "ceo-user-id",
          role: "ceo",
          userName: "Active User",
          tenantId: "primecare_hq"
        }
      });
    }).as("loginMock");

    const redirectUri = "https://primecare-auth.pages.dev/success";
    const loginUrl = `https://primecare-auth.pages.dev/login?redirect_uri=${encodeURIComponent(redirectUri)}&enable-semantics=true`;

    cy.visit(loginUrl, {
      onBeforeLoad(win) {
        win.localStorage.setItem("flutter.auth_language_selected", "true");
        win.localStorage.setItem("flutter.auth_preferred_language", JSON.stringify("en"));
      }
    });

    cy.wait(4000);

    // Apply the standard semantics layout rules
    cy.document().then((doc) => {
      const style = doc.createElement("style");
      style.innerHTML = `
        flt-semantics[aria-label*="data-cy:"], [aria-label*="data-cy:"] {
          min-width: 1px !important;
          min-height: 1px !important;
          visibility: visible !important;
          opacity: 0.001 !important;
        }
      `;
      doc.head.appendChild(style);
    });
    cy.wait(500);

    // Actively type email and password into the login fields
    cy.typeIntoField("login-email", "ceo@primecare.com");
    cy.typeIntoField("login-password", "Test@12345");

    // Click the submit button to initiate login
    cy.getCy("login-submit").first().click({ force: true });

    // Wait for the redirects
    cy.wait(8000);

    // Verify that the user successfully landed on the redirect_uri path
    cy.url().should("include", "/success");
    cy.contains("Identity Portal").should("be.visible");
  });
});
