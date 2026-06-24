beforeEach(() => {
  // Prevent any service worker installation or loading to ensure we always fetch fresh assets directly from the network.
  cy.intercept("GET", "**/flutter_service_worker.js", { statusCode: 404 });
});

Cypress.Commands.add("getCy", (id) => {
  return cy.get(`[aria-label*="data-cy:${id}"], [data-cy="${id}"], flt-semantics:contains("data-cy:${id}")`, {
    includeShadowDom: true,
  });
});

Cypress.Commands.add("typeIntoField", (id, text) => {
  cy.getCy(id).then(($el) => {
    if ($el.is("input") || $el.is("textarea")) {
      cy.wrap($el).first().type(text, { force: true });
    } else {
      cy.wrap($el).find("input, textarea").first().type(text, { force: true });
    }
  });
});

Cypress.Commands.add("waitAndSee", () => {
  cy.wait(2000);
});

Cypress.Commands.add("visitWithSemantics", (path) => {
  const visitOptions = {
    onBeforeLoad(win) {
      if (win.navigator && win.navigator.serviceWorker) {
        win.navigator.serviceWorker.getRegistrations().then((registrations) => {
          for (let registration of registrations) {
            registration.unregister();
          }
        });
      }
      if (win.caches) {
        win.caches.keys().then((keys) => {
          keys.forEach((key) => {
            win.caches.delete(key);
          });
        });
      }
    }
  };

  const cacheBuster = `cb=${Date.now()}`;
  if (path.startsWith("http://") || path.startsWith("https://")) {
    const querySymbol = path.includes("?") ? "&" : "?";
    cy.visit(`${path}${querySymbol}enable-semantics=true&${cacheBuster}`, visitOptions);
  } else {
    cy.location("origin").then((origin) => {
      const baseUrl = origin && origin !== "null" ? origin : "";
      const querySymbol = path.includes("?") ? "&" : "?";
      cy.visit(`${baseUrl}${path}${querySymbol}enable-semantics=true&${cacheBuster}`, visitOptions);
    });
  }
  cy.wait(2000);
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
});

Cypress.Commands.add("verifyNotBlank", () => {
  cy.get("body").should("be.visible");
  cy.get("body").invoke("text").then((text) => {
    if (!text || text.trim().length < 5) {
      throw new Error("Page body text is empty or too small. Possible blank render.");
    }
  });
});

Cypress.Commands.add("verifyShellExists", () => {
  cy.getCy('app-shell').should("be.visible");
  cy.getCy('app-topbar').should("be.visible");
  cy.getCy('app-sidebar').should("be.visible");
  cy.getCy('app-content-slot').should("be.visible");
});

Cypress.Commands.add("loginAsRole", (roleCode) => {
  cy.clearAllCookies();
  cy.clearAllLocalStorage();
  cy.clearAllSessionStorage();

  cy.fixture("governance/test_users.json").then((users) => {
    const user = users.find((u) => u.role_code === roleCode);
    if (!user) throw new Error(`No test user for role ${roleCode}`);

    const authUrl = "https://primecare-auth.pages.dev/login";

    const mockToken = "mock-jwt-token-" + user.role_code;
    const mockUserId = "test-user-id-" + user.role_code;

    // Intercept POST **/login request from the login form
    cy.intercept("POST", "**/login", (req) => {
      req.reply({
        statusCode: 200,
        body: {
          status: "success",
          token: mockToken,
          userId: mockUserId,
          role: user.role_code,
          userName: "Active User",
          tenantId: "primecare_hq"
        }
      });
    }).as("loginMock");

    // Intercept GET **/auth/me or **/me to return mock user data for session restoration
    const mockUserResponse = {
      token: mockToken,
      role: user.role_code,
      roles: user.role_code,
      userId: mockUserId,
      tenantId: "primecare_hq",
      activeRole: user.role_code,
      user: {
        id: mockUserId,
        firstName: "QA",
        lastName: user.role_code.toUpperCase(),
        roles: [user.role_code],
        tenantId: "primecare_hq",
        preferredLanguage: "en",
        email: user.email
      }
    };

    cy.intercept("GET", "**/auth/me", (req) => {
      const auth = req.headers["authorization"] || req.headers["Authorization"] || "";
      if (auth.includes(mockToken) || auth.includes("sso-token")) {
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
      if (auth.includes(mockToken) || auth.includes("sso-token")) {
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

    // Visit the live auth login page with redirect_uri to match real-world SSO flow
    const cacheBuster = `cb=${Date.now()}`;
    const url = `${authUrl}?redirect_uri=${encodeURIComponent(user.redirect_url)}&enable-semantics=true&${cacheBuster}`;

    cy.visit(url, {
      onBeforeLoad(win) {
        // Clear any existing stored credentials to ensure clean login form load
        win.localStorage.clear();
        win.sessionStorage.clear();
        // Seed the language preference so we don't get redirected to the /language view!
        win.localStorage.setItem("flutter.auth_language_selected", "true");
        win.localStorage.setItem("flutter.auth_preferred_language", JSON.stringify("en"));
      }
    });

    cy.wait(4000);

    // Apply the standard semantics layout rules to prevent double-render coordinate issues
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
    cy.wait(1000);

    // Actively type email and password into the login fields with stabilizing delays
    cy.typeIntoField("login-email", user.email);
    cy.wait(1000);
    cy.typeIntoField("login-password", user.password);
    cy.wait(1000);

    // Click the submit button to initiate login
    cy.getCy("login-submit").first().click({ force: true });

    // Wait for E2E cross-origin redirect to complete and land on the actual dashboard
    cy.wait(8000);

    // Verify the URL includes the role-specific post-login route
    cy.url().should("include", user.post_login_route);

    // Verify that the shell layout is present on the dashboard
    cy.verifyShellExists();
  });
});

Cypress.Commands.add("switchLanguage", (locale) => {
  // Resiliently locate language switcher using custom test tags, semantic tooltips, or active locale indicator
  cy.document().then((doc) => {
    // 1. Try standard attribute selectors first
    const selectors = [
      '[aria-label*="data-cy:topbar-language-switcher"]',
      '[data-cy="topbar-language-switcher"]',
      '[aria-label*="Change Language"]',
      '[aria-label*="change language"]'
    ];
    
    let foundElement = null;
    for (const sel of selectors) {
      const el = doc.querySelector(sel);
      if (el) {
        foundElement = el;
        break;
      }
    }
    
    // 2. Fallback to scanning flt-semantics text content
    if (!foundElement) {
      const semantics = doc.querySelectorAll('flt-semantics');
      for (let i = 0; i < semantics.length; i++) {
        const text = semantics[i].textContent || "";
        if (text.trim() === "EN" || text.trim() === "FR" || text.trim() === "ES") {
          foundElement = semantics[i];
          break;
        }
      }
    }
    
    if (foundElement) {
      cy.wrap(foundElement).first().click({ force: true });
    } else {
      // General click fallback matching any active language label
      cy.contains(/EN|FR|ES/, { timeout: 10000 }).first().click({ force: true });
    }
  });

  cy.waitAndSee();

  // Resiliently select language option
  const langNames = {
    en: /English|EN/i,
    fr: /Français|FR/i,
    es: /Español|ES/i
  };

  cy.document().then((doc) => {
    const optionSelectors = [
      `[aria-label*="data-cy:topbar-language-option-${locale}"]`,
      `[data-cy="topbar-language-option-${locale}"]`
    ];

    let foundOption = null;
    for (const sel of optionSelectors) {
      const el = doc.querySelector(sel);
      if (el) {
        foundOption = el;
        break;
      }
    }

    // Fallback to scanning flt-semantics for option text content
    if (!foundOption) {
      const semantics = doc.querySelectorAll('flt-semantics');
      const targetText = locale.toUpperCase();
      for (let i = 0; i < semantics.length; i++) {
        const text = semantics[i].textContent || "";
        if (text.trim().includes(targetText)) {
          foundOption = semantics[i];
          break;
        }
      }
    }

    if (foundOption) {
      cy.wrap(foundOption).first().click({ force: true });
    } else {
      // Fallback to searching by standard English/Français/Español text content
      cy.contains(langNames[locale], { timeout: 10000 }).first().click({ force: true });
    }
  });

  cy.waitAndSee();
  cy.verifyNotBlank();
});

Cypress.Commands.add("checkTestRegistry", (screenId, force = false) => {
  if (force) {
    return cy.wrap(false);
  }
  const registryPath = "cypress/fixtures/governance/e2e_test_registry.json";
  return cy.readFile(registryPath, { failOnDoesNotExist: false }).then((registry) => {
    if (!registry) {
      return cy.wrap(false);
    }
    const entry = registry[screenId];
    if (entry && entry.status === "PASS") {
      return cy.task("log", `⏭️ [SKIP] Screen '${screenId}' is already verified (PASS) on ${entry.tested_at}. Skipping redundant E2E checks.`).then(() => {
        return true;
      });
    }
    return cy.wrap(false);
  });
});

Cypress.Commands.add("updateTestRegistry", (screenId, status, specName, screenshotName) => {
  const registryPath = "cypress/fixtures/governance/e2e_test_registry.json";
  return cy.readFile(registryPath, { failOnDoesNotExist: false }).then((registry) => {
    const currentRegistry = registry || {};
    currentRegistry[screenId] = {
      screen_code: screenId,
      status: status,
      tested_at: new Date().toISOString(),
      screenshot_url: screenshotName ? `cypress/screenshots/${specName}/${screenshotName}.png` : null,
      video_url: `cypress/videos/${specName}.mp4`
    };
    return cy.writeFile(registryPath, currentRegistry);
  });
});
