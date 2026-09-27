export function getExpectedComponents(roleKey: string, screenCode: string): Cypress.Chainable<string[]> {
  const query = "SELECT required_components_json FROM screens WHERE role_key = ? AND screen_code = ?";
  return cy.task("queryDb", { query, params: [roleKey, screenCode] }).then((rows: any) => {
    if (!rows || rows.length === 0 || !rows[0].required_components_json) {
      return [];
    }
    try {
      return JSON.parse(rows[0].required_components_json);
    } catch (e) {
      return [];
    }
  });
}

export function getExpectedSidebarLinks(roleKey: string): Cypress.Chainable<string[]> {
  const query = "SELECT sidebar_config_json FROM roles WHERE role_code = ?";
  return cy.task("queryDb", { query, params: [roleKey] }).then((rows: any) => {
    if (rows && rows.length > 0 && rows[0].sidebar_config_json) {
      try {
        const config = JSON.parse(rows[0].sidebar_config_json);
        if (config && Array.isArray(config.items)) {
          return config.items.map((item: any) => item.label);
        }
      } catch (e) {
        // ignore and fallback
      }
    }
    // Fallback to screens table
    const fallbackQuery = "SELECT DISTINCT screen_name FROM screens WHERE role_key = ? AND show_in_sidebar = 1 ORDER BY menu_order ASC";
    return cy.task("queryDb", { query: fallbackQuery, params: [roleKey] }).then((fallbackRows: any) => {
      if (!fallbackRows) return [];
      return fallbackRows.map((r: any) => {
        let name: string = r.screen_name;
        const prefixes = ["ceo", "rmt", "ciso", "psw", "rn", "physician", "clinical director", "coo", "cfo", "cto"];
        for (const p of prefixes) {
          if (name.toLowerCase().startsWith(p + " ")) {
            name = name.substring(p.length + 1).trim();
            break;
          }
        }
        return name;
      });
    });
  });
}

export function getRoleDashboardRoute(roleKey: string): Cypress.Chainable<string> {
  const query = "SELECT route_path FROM screens WHERE role_key = ? AND (screen_code LIKE '%dashboard%' OR route_path LIKE '%dashboard%') LIMIT 1";
  return cy.task("queryDb", { query, params: [roleKey] }).then((rows: any) => {
    if (!rows || rows.length === 0) return "";
    return rows[0].route_path;
  });
}
