describe('Receptionist Calls E2E Test', () => {
  beforeEach(() => {
    cy.visit('/generated/receptionist-calls');
  });

  it('should mount screen and display elements', () => {
    cy.get('[data-cy="receptionist_calls-screen"]').should('exist');
    // TODO: Add assertions for sections and elements
  });
});
