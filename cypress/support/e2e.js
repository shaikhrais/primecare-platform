import "./commands";
import "./auth-commands";
import "./commands.ts";

Cypress.on("window:before:load", (win) => {
  if (win.top) {
    win.top.browserLogs = win.top.browserLogs || [];
  }

  const logPrefixes = { log: "[BROWSER LOG]", warn: "[BROWSER WARN]", error: "[BROWSER ERROR]" };
  for (const level of ["log", "warn", "error"]) {
    const original = win.console[level];
    win.console[level] = (...args) => {
      original.apply(win.console, args);
      const msg = args.map(arg => {
        try {
          return typeof arg === 'object' ? JSON.stringify(arg) : String(arg);
        } catch (_) {
          return String(arg);
        }
      }).join(" ");
      if (win.top && win.top.browserLogs) {
        win.top.browserLogs.push(`${logPrefixes[level]} ${msg}`);
      }
    };
  }

  if (win.navigator && win.navigator.serviceWorker) {
    win.navigator.serviceWorker.getRegistrations().then((registrations) => {
      registrations.forEach((registration) => {
        registration.unregister();
      });
    });
  }
  if (win.caches) {
    win.caches.keys().then((keys) => {
      keys.forEach((key) => {
        win.caches.delete(key);
      });
    });
  }
});

let apiLogs = [];

// Print collected logs after each test run
afterEach(() => {
  cy.window().then((win) => {
    if (win.top && win.top.browserLogs && win.top.browserLogs.length > 0) {
      cy.task("log", "\n=== BROWSER LOGS START ===");
      win.top.browserLogs.forEach((log) => {
        cy.task("log", log);
      });
      cy.task("log", "=== BROWSER LOGS END ===\n");
      win.top.browserLogs = [];
    }
  });

  cy.task("log", "\n=== API LOGS START ===");
  apiLogs.forEach((log) => {
    cy.task("log", log);
  });
  cy.task("log", "=== API LOGS END ===\n");
  apiLogs = [];
});

// Completely block the service worker script from loading to guarantee no caching
beforeEach(() => {
  apiLogs = [];
  
  // Intercept all requests to log them
  cy.intercept("**", (req) => {
    // Only capture API or relevant requests to avoid cluttering logs with static assets
    const url = req.url;
    if (url.includes("/api/") || url.includes("/v1/") || url.includes("/auth/")) {
      req.continue((res) => {
        apiLogs.push(`[API CALL] ${req.method} ${req.url} => ${res.statusCode}`);
      });
    }
  });

  // Clear logs container at the start of each test
  cy.window().then((win) => {
    if (win.top) {
      win.top.browserLogs = [];
    }
  });

  cy.intercept("**/flutter_service_worker.js*", {
    statusCode: 404,
    body: "Service worker blocked by Cypress cache-buster"
  });
});

