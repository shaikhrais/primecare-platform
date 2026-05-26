import "./commands";

Cypress.on("fail", (error, runnable) => {
  throw error;
});
