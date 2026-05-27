const { defineConfig } = require("cypress");

module.exports = defineConfig({
  video: true,
  screenshotOnRunFailure: true,
  includeShadowDom: true,
  trashAssetsBeforeRuns: false,
  defaultCommandTimeout: 15000,
  pageLoadTimeout: 90000,
  viewportWidth: 1920,
  viewportHeight: 1080,
  e2e: {
    baseUrl: process.env.CYPRESS_BASE_URL,
    specPattern: "cypress/e2e/**/*.cy.js",
    supportFile: "cypress/support/e2e.js",
    setupNodeEvents(on, config) {
      return config;
    },
  },
});
