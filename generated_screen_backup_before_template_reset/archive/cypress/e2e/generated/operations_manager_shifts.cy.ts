describe('Operations Manager Shifts E2E Test', () => {
  beforeEach(() => {
    cy.visit('/offices/franchise/roles/operations_manager/shifts');
  });

  it('should mount screen and display elements', () => {
    cy.get('[data-cy="operations_manager_shifts-screen"]').should('exist');
    // TODO: Add assertions for sections and elements
  });
});
