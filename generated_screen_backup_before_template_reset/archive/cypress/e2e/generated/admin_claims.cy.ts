describe('Admin Claims E2E Test', () => {
  beforeEach(() => {
    cy.visit('/offices/franchise/roles/admin/claims');
  });

  it('should mount screen and display elements', () => {
    cy.get('[data-cy="admin_claims-screen"]').should('exist');
    // TODO: Add assertions for sections and elements
  });
});
