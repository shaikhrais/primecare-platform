// Import commands.js using ES2015 syntax:
import "./commands";
// import "@cypress/grep";

// Alternatively you can use CommonJS syntax:
// require('./commands')

beforeEach(() => {
    cy.step("Global BeforeEach: Preserving session or resetting state (if needed)");
});
