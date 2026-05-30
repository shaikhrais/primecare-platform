import "./commands";

Cypress.on("fail", (error, runnable) => {
  throw error;
});

// Enforce cache busting by unregistering all Service Workers and clearing Cache Storage before loading the window
Cypress.on("window:before:load", (win) => {
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

// Completely block the service worker script from loading to guarantee no caching
beforeEach(() => {
  cy.intercept("**/flutter_service_worker.js*", {
    statusCode: 404,
    body: "Service worker blocked by Cypress cache-buster"
  });
});


