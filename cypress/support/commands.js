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
        display: inline-block !important;
        visibility: visible !important;
        opacity: 1 !important;
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

    const password = user.password || "Test@12345";
    const targetBaseUrl = user.app_url; // Always use the deployed Cloudflare app URL!

    // Intercept background session restoration checks on SSO portal to prevent auto-login race conditions.
    cy.intercept("GET", "**/me", (req) => {
      const authHeader = req.headers.authorization || req.headers.Authorization || "";
      const hasTokenInHeader = authHeader.startsWith("Bearer ") && authHeader.substring(7).trim().length > 0;
      
      let hasToken = hasTokenInHeader;
      let isAuthPortal = false;
      let pathname = "/";
      
      try {
        const win = Cypress.state('window');
        if (win) {
          const currentUrl = new URL(win.location.href);
          hasToken = hasToken || currentUrl.searchParams.has("token") || currentUrl.hash.includes("token");
          pathname = currentUrl.pathname;
          isAuthPortal = currentUrl.hostname.includes("primecare-auth");
        }
      } catch (_) {}

      // Fallback using referer header if window context is not fully ready
      if (!hasToken || pathname === "/") {
        try {
          const referer = req.headers.referer || req.headers.origin || "";
          if (referer) {
            const refUrl = new URL(referer);
            hasToken = hasToken || refUrl.searchParams.has("token") || refUrl.hash.includes("token") || refUrl.search.includes("token");
            pathname = refUrl.pathname;
            isAuthPortal = isAuthPortal || refUrl.hostname.includes("primecare-auth");
          }
        } catch (_) {}
      }

      const isInitialLoad = !hasToken;

      if (isInitialLoad) {
        req.reply({
          statusCode: 401,
          body: { status: "error", message: "Unauthorized" }
        });
      } else {
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
      }
    }).as("ssoHandshake");

    const cleanPostLoginRoute = user.post_login_route.startsWith("/")
      ? user.post_login_route.substring(1)
      : user.post_login_route;

    // Preliminary visit to target host root to get window and clear service workers + Cache Storage
    cy.visit(targetBaseUrl + "/?enable-semantics=true").then((win) => {
      if (win.caches) {
        win.caches.keys().then((keys) => {
          keys.forEach((key) => {
            win.caches.delete(key);
          });
        });
      }
      if (win.navigator && win.navigator.serviceWorker) {
        win.navigator.serviceWorker.getRegistrations().then((registrations) => {
          for (let registration of registrations) {
            registration.unregister();
          }
        });
      }
    });
    cy.wait(2000);

    // Visit the protected dashboard route first to establish top origin context
    const loginCacheBuster = `cb=${Date.now()}`;
    cy.visit(targetBaseUrl + user.post_login_route + "?enable-semantics=true&" + loginCacheBuster, {
      onBeforeLoad(win) {
        cy.stub(win, "open").callsFake((url) => {
          win.location.href = url;
        });
      }
    });
    cy.wait(4000);

    // Perform SSO authentication dynamically inside cy.origin block
    cy.origin("https://primecare-auth.pages.dev", { args: { user, password } }, ({ user, password }) => {
      // Force clear all storage to prevent session bleeding
      cy.clearCookies();
      cy.clearLocalStorage();

      // Wiping IndexedDB to fully clear any persistent SharedPreferences/Hive session states in Flutter
      cy.window().then((win) => {
        try {
          win.sessionStorage.clear();
        } catch (_) {}
        try {
          win.indexedDB.databases().then((dbs) => {
            dbs.forEach((db) => {
              if (db.name) win.indexedDB.deleteDatabase(db.name);
            });
          });
        } catch (_) {}
      });

      // Use native Cypress visit to cleanly navigate and wait for the page load!
      cy.visit(`/login?force_login=true&redirect_uri=${encodeURIComponent(user.redirect_url)}`);
      
      // Wait for Flutter app to fully mount and render UI elements
      cy.contains("Authorized Access", { includeShadowDom: true, timeout: 20000 }).should("be.visible");
      cy.wait(2000);

      const resolvedEmail = user.email;

      // Highly resilient native typing with validation retries for Flutter CanvasKit input fields
      const setValueRobustly = (selector, value, isLog = true) => {
        const typeAndVerify = (retries = 3) => {
          if (retries <= 0) {
            throw new Error(`Failed to robustly type value in ${selector}`);
          }

          cy.get(selector, { includeShadowDom: true })
            .first()
            .should("be.visible")
            .click({ force: true })
            .clear({ force: true })
            .wait(200);

          // Perform native type to ensure Flutter's text input channel registers key events
          cy.get(selector, { includeShadowDom: true })
            .first()
            .type(value, { force: true, log: isLog, delay: 40 });

          cy.wait(800);

          cy.get(selector, { includeShadowDom: true }).first().then(($input) => {
            const currentVal = $input.val();
            if (currentVal !== value) {
              cy.log(`Value mismatch: expected "${value}" but got "${currentVal}". Retrying type operation...`);
              typeAndVerify(retries - 1);
            } else {
              cy.log(`Value successfully verified: "${currentVal}"`);
            }
          });
        };

        typeAndVerify();
      };

      setValueRobustly('input[type="text"], input[type="email"]', resolvedEmail, true);
      setValueRobustly('input[type="password"]', password, false);

      // Take screenshot of filled login
      cy.screenshot(`auth-login-${user.role_code}`);

      // Click Initiate Session
      cy.get("body", { includeShadowDom: true }).then(($body) => {
        const hasInitiateSession = $body.text().includes("INITIATE SESSION");
        if (hasInitiateSession) {
          cy.log("SSO Portal: Clicking semantic INITIATE SESSION button...");
          cy.contains("INITIATE SESSION", { includeShadowDom: true }).click({ force: true });
        } else {
          cy.log("SSO Portal: Clicking fallback submit button...");
          cy.get('button, input[type="submit"]', { includeShadowDom: true }).first().click({ force: true });
        }
      });
      
      cy.wait(5000);

      // Assert and click the Consent approve button
      cy.get('[aria-label*="Approve & Continue"], flt-semantics[aria-label*="Approve & Continue"]', { includeShadowDom: true, timeout: 25000 })
        .first()
        .click({ force: true });

      cy.wait(4000); // Allow browser to start transition and change origin back
    });

    // Back to primary app origin context! Assert redirection is complete.
    cy.url({ timeout: 45000 }).should("not.include", "primecare-auth.pages.dev");
    cy.wait(6000); // Remaining delay to let the clinic portal process the deep link callback
    cy.wait(2000);
    cy.document().then((doc) => {
      const style = doc.createElement("style");
      style.innerHTML = `
        flt-semantics[aria-label*="data-cy:"], [aria-label*="data-cy:"] {
          min-width: 1px !important;
          min-height: 1px !important;
          display: inline-block !important;
          visibility: visible !important;
          opacity: 1 !important;
        }
      `;
      doc.head.appendChild(style);
    });
    cy.wait(500);

    // Verify dynamic sidebar, topbar, and shell rendering
    cy.get('[aria-label*="data-cy:app-shell"], [data-cy="app-shell"]', { includeShadowDom: true, timeout: 15000 })
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
