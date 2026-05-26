const { defineConfig } = require("cypress");

module.exports = defineConfig({
  video: true,
  screenshotOnRunFailure: true,
  trashAssetsBeforeRuns: false,
  defaultCommandTimeout: 15000,
  pageLoadTimeout: 90000,
  viewportWidth: 1920,
  viewportHeight: 1080,
  retries: {
    runMode: 0,
    openMode: 0
  },
  e2e: {
    setupNodeEvents(on, config) {
      return config;
    },
    baseUrl: process.env.CYPRESS_BASE_URL || "http://localhost:3000"
  }
});
