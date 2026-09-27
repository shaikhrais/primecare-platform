describe('HrHiringOffersScreen E2E Test', () => {
  beforeEach(() => {
    cy.visit('/offices/franchise/roles/hr_hiring/offers');
  });

  it('should mount screen and display elements', () => {
    cy.get('[data-cy="hr_hiring_offers-screen"]').should('exist');
    // TODO: Add assertions for sections and elements
  });
});
