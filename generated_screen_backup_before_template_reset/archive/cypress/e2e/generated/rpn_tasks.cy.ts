describe('RpnTasksScreen E2E Test', () => {
  beforeEach(() => {
    cy.visit('/offices/clinical/roles/rpn/rpn-tasks');
  });

  it('should mount screen and display elements', () => {
    cy.get('[data-cy="rpn_tasks-screen"]').should('exist');
    // TODO: Add assertions for sections and elements
  });
});
