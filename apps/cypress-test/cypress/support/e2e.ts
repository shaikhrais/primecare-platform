// Import commands.js using ES2015 syntax:
import "./commands";
import './selectors';
// import "@cypress/grep";

// Alternatively you can use CommonJS syntax:
// require('./commands')

beforeEach(() => {
    cy.step("Global BeforeEach: Preserving session or resetting state (if needed)");
});

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

        // Ignore specific non-critical warnings that might be logged as errors
        if (errorMsg.includes('ReactDOM.render is no longer supported')) return;

        throw new Error(`Browser Console Error: ${errorMsg}`);
    });
});
