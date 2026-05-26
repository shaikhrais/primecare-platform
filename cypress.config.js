const { defineConfig } = require("cypress");

module.exports = defineConfig({
  video: true,
  screenshotOnRunFailure: true,
  defaultCommandTimeout: 10000,
  pageLoadTimeout: 60000,
  e2e: {
    setupNodeEvents(on, config) {
      return config;
    },
  },
});
