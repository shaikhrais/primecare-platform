beforeEach(() => {
  // Prevent any service worker installation or loading to ensure we always fetch fresh assets directly from the network.
  cy.intercept("GET", "**/flutter_service_worker.js", { statusCode: 404 });
});

Cypress.Commands.add("getCy", (id) => {
  return cy.get(`[aria-label*="data-cy:${id}"], [data-cy="${id}"]`, {
    includeShadowDom: true,
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

    const targetBaseUrl = user.app_url; // Always use the deployed Cloudflare app URL!

    // Mock the workers API me endpoint to return successful profile immediately!
    cy.intercept("GET", "**/me", (req) => {
      req.reply({
        statusCode: 200,
        body: {
          status: "success",
          userId: user.role_code + "-user-id",
          email: user.email,
          roles: [user.role_code],
          tenantId: "primecare_hq",
          firstName: "Active",
          lastName: "User"
        }
      });
    }).as("meMock");

    // Visit the target post-login route directly, seeding local storage BEFORE the app scripts run!
    const cacheBuster = `cb=${Date.now()}`;
    cy.visit(targetBaseUrl + user.post_login_route + "?enable-semantics=true&" + cacheBuster, {
      onBeforeLoad(win) {
        win.localStorage.setItem("flutter.auth_token", JSON.stringify("mock-token-exchange-success"));
        win.localStorage.setItem("flutter.auth_role", JSON.stringify(user.role_code));
        win.localStorage.setItem("flutter.auth_tenant_id", JSON.stringify("primecare_hq"));
        win.localStorage.setItem("flutter.auth_username", JSON.stringify("Active User"));
        win.localStorage.setItem("flutter.auth_user_id", JSON.stringify(user.role_code + "-user-id"));
        win.localStorage.setItem("flutter.auth_preferred_language", JSON.stringify("en"));

        win.sessionStorage.setItem("flutter.auth_token", JSON.stringify("mock-token-exchange-success"));
        win.sessionStorage.setItem("flutter.auth_role", JSON.stringify(user.role_code));
        win.document.cookie = "session_token=mock-token-exchange-success; path=/; domain=" + win.location.hostname + ";";
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
    cy.wait(500);

    // Verify dynamic sidebar, topbar, and shell rendering to guarantee dashboard has successfully loaded!
    cy.get('[aria-label*="data-cy:app-shell"], [data-cy="app-shell"]', { includeShadowDom: true, timeout: 20000 })
      .should("be.visible");
    cy.get('[aria-label*="data-cy:app-topbar"], [data-cy="app-topbar"]', { includeShadowDom: true })
      .should("be.visible");
    cy.get('[aria-label*="data-cy:app-sidebar"], [data-cy="app-sidebar"]', { includeShadowDom: true })
      .should("be.visible");
    cy.get('[aria-label*="data-cy:app-content-slot"], [data-cy="app-content-slot"]', { includeShadowDom: true })
      .should("be.visible");
      
    // Assert correct landing route
    cy.url().should("include", user.post_login_route);
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
