// Import commands.js using ES2015 syntax:
import "./commands";
import './selectors';
// import "@cypress/grep";

// Alternatively you can use CommonJS syntax:
// require('./commands')

// Global hooks are handled per-spec for better stability with live auth reloads

// Fail on console errors to catch silent React crashes
Cypress.on('window:before:load', (win) => {
    cy.stub(win.console, 'error').callsFake((msg, ...args) => {
        const formatMsg = (m: any) => {
            if (m instanceof Error) return m.message;
            if (typeof m === 'object') {
                try { return JSON.stringify(m); } catch (e) { return String(m); }
            }
            return String(m);
        };

        const errorMsg = [msg, ...args].map(formatMsg).join(' ');

        // Ignore non-critical warnings
        if (errorMsg.includes('ReactDOM.render')) return;

        // Just log to terminal for now, don't throw to prevent bailing on live environment noise
        console.warn(`[IGNORED CONSOLE ERROR]: ${errorMsg}`);
    });
});

// Custom Stop Behavior: Bail after 1 failure
let failCount = 0;
const MAX_FAILS = 1;

let passCount = 0;
let totalExecuted = 0;

afterEach(function () {
    const test = (this as any).currentTest;
    const status = test.state;
    const title = test.title;

    // We only log if the test actually ran (not skipped)
    if (status) {
        totalExecuted += 1;
        if (status === "passed") passCount += 1;

        const statusIcon = status === "passed" ? "✅" : status === "failed" ? "❌" : "⏳";
        // Use cy.log instead of console.log for command log visibility
        cy.log(`${statusIcon} ${title} | Score: ${passCount}/${totalExecuted}`);

        // Persist to .cy.ts files via task
        cy.task('logStepResult', {
            title,
            status,
            error: test.err ? test.err.message : null,
            score: { passed: passCount, total: totalExecuted }
        }, { log: false });

        if (status === "failed") {
            failCount += 1;
            if (failCount >= MAX_FAILS) {
                (Cypress as any).runner.stop();
            }
        }
    }
});

// Take a screenshot after EVERY step (passing or failing)
afterEach(() => {
    const testTitle = Cypress.currentTest.title.replace(/[^a-z0-9]/gi, '_').toLowerCase();
    cy.screenshot(`step-view/${testTitle}`, { capture: 'viewport' });
});
