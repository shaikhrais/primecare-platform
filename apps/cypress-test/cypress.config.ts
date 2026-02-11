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
        baseUrl: "https://primecare-admin.pages.dev",
        supportFile: "cypress/support/e2e.ts",
        specPattern: "cypress/e2e/**/*.cy.{ts,tsx,js}",
        defaultCommandTimeout: 15000,
        pageLoadTimeout: 60000,
        retries: { runMode: 2, openMode: 0 },
        env: {
            ADMIN_BASE_URL: "https://primecare-admin.pages.dev",
            MARKETING_BASE_URL: "https://primecare-web.pages.dev",
            API_BASE_URL: "https://primecare-api.itpro-mohammed.workers.dev",
        },
    },
});
