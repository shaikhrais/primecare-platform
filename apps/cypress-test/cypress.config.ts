import { defineConfig } from "cypress";

export default defineConfig({
    video: true,
    screenshotsFolder: "cypress/screenshots",
    videosFolder: "cypress/videos",
    downloadsFolder: "cypress/downloads",

    reporter: "cypress-multi-reporters",
    reporterOptions: {
        configFile: "reporter-config.json",
    },

    e2e: {
        baseUrl: "http://localhost:5173",
        supportFile: "cypress/support/e2e.ts",
        specPattern: "cypress/e2e/**/*.cy.{ts,tsx,js}",
        defaultCommandTimeout: 10000,
        pageLoadTimeout: 60000,
        retries: { runMode: 2, openMode: 0 },
        env: {
            ADMIN_BASE_URL: "http://localhost:5173",
            MARKETING_BASE_URL: "http://localhost:5174",
            API_BASE_URL: "http://localhost:8787",
        },
    },
});
