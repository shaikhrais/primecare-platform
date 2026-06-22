describe("Auth Redirect Debug", () => {
  it("redirects correctly to redirect_uri after login", () => {
    cy.clearAllCookies();
    cy.clearAllLocalStorage();
    cy.clearAllSessionStorage();

    const mockToken = "mock-token-exchange-success";
    const mockUserResponse = {
      token: mockToken,
      role: "ceo",
      roles: "ceo",
      userId: "ceo-user-id",
      tenantId: "primecare_hq",
      activeRole: "ceo",
      user: {
        id: "ceo-user-id",
        firstName: "QA",
        lastName: "CEO",
        roles: ["ceo"],
        tenantId: "primecare_hq",
        preferredLanguage: "en",
        email: "qa.ceo@test.primecare.local"
      }
    };

    // Intercept POST **/login request
    cy.intercept("POST", "**/login", (req) => {
      req.reply({
        statusCode: 200,
        body: {
          status: "success",
          token: mockToken,
          userId: "ceo-user-id",
          role: "ceo",
          userName: "Active User",
          tenantId: "primecare_hq"
        }
      });
    }).as("loginMock");

    // Intercept GET **/auth/me or **/me to return mock user data only when authorized
    cy.intercept("GET", "**/auth/me", (req) => {
      const auth = req.headers["authorization"] || req.headers["Authorization"] || "";
      if (auth.includes(mockToken)) {
        req.reply({
          statusCode: 200,
          body: mockUserResponse
        });
      } else {
        req.reply({
          statusCode: 401,
          body: { status: "error", message: "Unauthorized" }
        });
      }
    }).as("meMock");

    cy.intercept("GET", "**/me", (req) => {
      const auth = req.headers["authorization"] || req.headers["Authorization"] || "";
      if (auth.includes(mockToken)) {
        req.reply({
          statusCode: 200,
          body: mockUserResponse
        });
      } else {
        req.reply({
          statusCode: 401,
          body: { status: "error", message: "Unauthorized" }
        });
      }
    }).as("meMock2");

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
    cy.wait(1000);
    cy.typeIntoField("login-password", "Test@12345");
    cy.wait(1000);

    // Click the submit button to initiate login
    cy.getCy("login-submit").first().click({ force: true });

    // Wait for the redirects
    cy.wait(8000);

    // Verify that the user successfully landed on the redirect_uri path
    cy.url().should("include", "/success");
    cy.contains("Application Hub").should("be.visible");
  });
});
