describe('Partnership Manager Partners E2E Test', () => {
  beforeEach(() => {
    cy.visit('/offices/business_development/roles/partnership_manager/partners');
  });

  it('should mount screen and display elements', () => {
    cy.get('[data-cy="partnership_manager_partners-screen"]').should('exist');
    // TODO: Add assertions for sections and elements
  });
});
