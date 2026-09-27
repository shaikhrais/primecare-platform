# Cypress test generator
def generate_cypress_spec(screen_name, route_path, elements):
    spec = f"describe('{screen_name} E2E', () => {\n"
    spec += f"  it('should render components', () => {\n"
    spec += f"    cy.visit('{route_path}')\n"
    for el in elements:
        spec += f"    cy.get('[aria-label=\"{el}\"]').should('be.visible')\n"
    spec += "  })\n})"
    return spec
