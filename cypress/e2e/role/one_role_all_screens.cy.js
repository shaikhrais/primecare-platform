describe("One Role All Screens Test", () => {
  const roleCode = Cypress.env("ROLE_CODE") || "psw";

  it("logs in as one role and tests all allowed screens", () => {
    cy.loginAsRole(roleCode);
    cy.wait(2000);

    cy.verifyShellExists();

    cy.fixture("governance/screens.json").then((screens) => {
      const roleScreens = screens.filter((screen) => {
        const allowed = screen.allowed_roles_text || "";
        return allowed.toLowerCase().includes(roleCode.toLowerCase());
      });

      if (roleScreens.length === 0) {
        throw new Error(`No screens found for role: ${roleCode}`);
      }

      for (const screen of roleScreens) {
        cy.log(`Testing screen: ${screen.screen_name}`);
        cy.visit(screen.route_path);
        cy.wait(2000);

        cy.verifyShellExists();

        let dataCy = {};
        try {
          dataCy = JSON.parse(screen.data_cy_required_json || "{}");
        } catch (e) {
          throw new Error(`Invalid data_cy_required_json for ${screen.screen_name}`);
        }

        if (dataCy.screen_root) {
          cy.get(`[data-cy="${dataCy.screen_root}"]`).should("exist");
        }

        if (dataCy.page_title) {
          cy.get(`[data-cy="${dataCy.page_title}"]`).should("exist");
        }

        if (dataCy.primary_content) {
          cy.get(`[data-cy="${dataCy.primary_content}"]`).should("exist");
        }

        cy.get('[data-cy="app-shell"]').should("be.visible");
        cy.get('[data-cy="app-content-slot"]').should("be.visible");
        if (dataCy.screen_root) {
          cy.get(`[data-cy="${dataCy.screen_root}"]`).should("be.visible");
        }
        cy.get("body").invoke("text").should("not.be.empty");
        cy.wait(2000);
        cy.screenshot(`${roleCode}-${screen.screen_code}`, { capture: "viewport" });
        cy.wait(2000);
      }
    });
  });
});
