describe('CfoExpensesScreen E2E Test', () => {
  beforeEach(() => {
    cy.visit('/offices/corporate/roles/cfo/expenses');
  });

  it('should mount screen and display elements', () => {
    cy.get('[data-cy="cfo_expenses-screen"]').should('exist');
    // TODO: Add assertions for sections and elements
  });
});
