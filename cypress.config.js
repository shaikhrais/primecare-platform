const { defineConfig } = require("cypress");
const { spawnSync } = require("child_process");

module.exports = defineConfig({
  video: true,
  screenshotOnRunFailure: true,
  includeShadowDom: true,
  trashAssetsBeforeRuns: false,
  chromeWebSecurity: false,
  defaultCommandTimeout: 15000,
  pageLoadTimeout: 90000,
  viewportWidth: 1920,
  viewportHeight: 1080,
  e2e: {
    baseUrl: process.env.CYPRESS_BASE_URL,
    specPattern: "cypress/e2e/**/*.cy.{js,ts}",
    supportFile: "cypress/support/e2e.js",
    setupNodeEvents(on, config) {
      on("task", {
        log(message) {
          console.log(message);
          return null;
        },
        queryDb({ query, params }) {
          const paramsStr = JSON.stringify(params || []);
          const result = spawnSync("python", ["tools/governance/query_db.py", query, paramsStr], { encoding: "utf-8" });
          if (result.error) {
            throw result.error;
          }
          if (result.status !== 0) {
            throw new Error(result.stderr || result.stdout);
          }
          return JSON.parse(result.stdout);
        }
      });
      return config;
    },
  },
});
