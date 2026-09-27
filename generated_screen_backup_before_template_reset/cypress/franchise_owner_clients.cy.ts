describe('FranchiseOwnerClientsScreen E2E Test', () => {
  beforeEach(() => {
    cy.visit('/offices/franchise/roles/franchise_owner/clients');
  });

  it('should mount screen and display elements', () => {
    cy.get('[data-cy="franchise_owner_clients-screen"]').should('exist');
    // TODO: Add assertions for sections and elements
  });
});
