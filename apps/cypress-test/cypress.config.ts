import { defineConfig } from "cypress";
import * as fs from 'fs';
import * as path from 'path';

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
        setupNodeEvents(on, config) {
            on('task', {
                logStepResult({ title, status, score, error }) {
                    const logDir = config.projectRoot;
                    console.log(`LOGGING STEP: ${title} | Status: ${status} | Dir: ${logDir}`);
                    const files = {
                        passed: '_pass.cy.ts',
                        failed: '_fail.cy.ts',
                        pending: '_pending.cy.ts',
                        complete: '_complete.cy.ts'
                    };

                    const timestamp = new Date().toISOString();
                    const errorMsg = error ? ` | ERROR: ${error}` : '';
                    const logEntry = `  it("${title}", () => { /* status: ${status}${errorMsg} | captured at: ${timestamp} */ });\n`;

                    // Ensure files have headers
                    Object.values(files).forEach(f => {
                        const fPath = path.join(logDir, btoa(f) === btoa('_pending.cy.ts') ? f : f); // dummy check
                        const absolutePath = path.join(logDir, f);
                        if (!fs.existsSync(absolutePath)) {
                            fs.writeFileSync(absolutePath, `// Micro-Step Status Report\n// Generated: ${timestamp}\n\ndescribe("Results Suite", () => {\n`);
                        }
                    });

                    const append = (f) => fs.appendFileSync(path.join(logDir, f), logEntry);

                    append(files.complete);
                    if (status === 'passed') append(files.passed);
                    else if (status === 'failed') append(files.failed);
                    else append(files.pending);

                    // Update score in complete file (hacky but works for a list)
                    if (score) {
                        const scoreEntry = `// SCORE: ${score.passed}/${score.total} (${((score.passed / score.total) * 100).toFixed(1)}%)\n`;
                        const completePath = path.join(logDir, files.complete);
                        const content = fs.readFileSync(completePath, 'utf8');
                        if (content.includes('// SCORE:')) {
                            const updated = content.replace(/\/\/ SCORE: .*\n/, scoreEntry);
                            fs.writeFileSync(completePath, updated);
                        } else {
                            fs.writeFileSync(completePath, scoreEntry + content);
                        }
                    }

                    return null;
                },
                resetLogs() {
                    const logDir = config.projectRoot;
                    ['_pass.cy.ts', '_fail.cy.ts', '_pending.cy.ts', '_complete.cy.ts'].forEach(f => {
                        const p = path.join(logDir, f);
                        if (fs.existsSync(p)) fs.unlinkSync(p);
                    });
                    return null;
                }
            });
        },
        baseUrl: "https://primecare-admin.pages.dev",
        supportFile: "cypress/support/e2e.ts",
        specPattern: "cypress/e2e/**/*.cy.{ts,tsx,js}",
        excludeSpecPattern: ["**/_pass.cy.ts", "**/_fail.cy.ts", "**/_pending.cy.ts", "**/_complete.cy.ts"],
        defaultCommandTimeout: 15000,
        pageLoadTimeout: 60000,
        retries: { runMode: 2, openMode: 0 },
        experimentalRunAllSpecs: true,
        testIsolation: false,
        env: {
            ADMIN_BASE_URL: "https://primecare-admin.pages.dev",
            MARKETING_BASE_URL: "https://primecare-web.pages.dev",
            PSW_EMAIL: "psw.a@primecare.ca",
            PSW_PASSWORD: "admin123",
            RN_EMAIL: "rn.a@primecare.ca",
            RN_PASSWORD: "admin123",
            ADMIN_EMAIL: "admin.a@primecare.ca",
            ADMIN_PASSWORD: "admin123",
            MANAGER_EMAIL: "manager.a@primecare.ca",
            MANAGER_PASSWORD: "admin123"
        },
    },
});
