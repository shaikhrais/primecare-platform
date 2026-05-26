describe("One Role All Screens Enterprise Test", () => {
  const roleCode = Cypress.env("ROLE_CODE") || "psw";

  it("logs in and tests all allowed screens for role", () => {
    cy.loginAsRole(roleCode);

    cy.fixture("governance/screens.json").then((screens) => {
      const roleScreens = screens.filter((screen) => {
        return (screen.allowed_roles_text || "")
          .toLowerCase()
          .includes(roleCode.toLowerCase());
      });

      if (roleScreens.length === 0) {
        throw new Error(`No screens found for role ${roleCode}`);
      }

      for (const screen of roleScreens) {
        cy.log(`Opening ${screen.screen_name}`);
        cy.visit(screen.route_path);
        cy.waitAndSee();

        cy.verifyShellExists();
        cy.verifyNotBlank();

        let keys = {};
        try {
          keys = JSON.parse(screen.data_cy_required_json || "{}");
        } catch (e) {
          throw new Error(`Invalid data_cy_required_json for ${screen.screen_name}`);
        }

        if (keys.screen_root) {
          cy.get(`[data-cy="${keys.screen_root}"]`).should("be.visible");
        }

        if (keys.page_title) {
          cy.get(`[data-cy="${keys.page_title}"]`).should("be.visible");
        }

        if (keys.primary_content) {
          cy.get(`[data-cy="${keys.primary_content}"]`).should("be.visible");
        }

        cy.screenshot(`${roleCode}-${screen.screen_code}`);
        cy.waitAndSee();
      }
    });
  });
});
