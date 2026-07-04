describe('Receptionist Visitors E2E Test', () => {
  beforeEach(() => {
    cy.visit('/generated/receptionist-visitors');
  });

  it('should mount screen and display elements', () => {
    cy.get('[data-cy="receptionist_visitors-screen"]').should('exist');
    // TODO: Add assertions for sections and elements
  });
});
