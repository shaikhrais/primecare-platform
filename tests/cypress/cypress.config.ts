import { defineConfig } from "cypress";

export default defineConfig({
    e2e: {
        baseUrl: 'https://primecare-admin.pages.dev',
        supportFile: 'cypress/support/e2e.ts',
        specPattern: 'cypress/e2e/**/*.cy.{js,jsx,ts,tsx}',
        viewportWidth: 1280,
        viewportHeight: 720,
        video: false,
        screenshotOnRunFailure: true,
        chromeWebSecurity: false,
        env: {
            marketingUrl: 'https://primecare-web.pages.dev'
        }
    },
});
