describe('SocialMediaScreen E2E Test', () => {
  beforeEach(() => {
    cy.visit('/management/social-media');
  });

  it('should mount screen and display elements', () => {
    cy.get('[data-cy="social_media-screen"]').should('exist');
    // TODO: Add assertions for sections and elements
  });
});
