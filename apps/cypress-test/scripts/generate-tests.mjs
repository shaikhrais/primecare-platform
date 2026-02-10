import fs from "fs";
import path from "path";

// Simple path resolution based on process execution root (project root)
const root = process.cwd();
const registryDir = path.join(root, "cypress", "fixtures", "registry");
const outDir = path.join(root, "cypress", "e2e", "generated");

if (!fs.existsSync(outDir)) {
  fs.mkdirSync(outDir, { recursive: true });
}

function readJson(file) {
  const fullPath = path.join(registryDir, file);
  if (!fs.existsSync(fullPath)) {
    throw new Error(`Registry file missing: ${fullPath}`);
  }
  return JSON.parse(fs.readFileSync(fullPath, "utf8"));
}

console.log("Reading registries from:", registryDir);

const marketing = readJson("routes.marketing.json");
const admin = readJson("routes.admin.json");
const matrix = readJson("access.matrix.json");
const contracts = readJson("contracts.json");

function write(fileName, content) {
  const fullPath = path.join(outDir, fileName);
  fs.writeFileSync(fullPath, content, "utf8");
  console.log("Generated:", fileName);
}

const commonHeader = `
Cypress.on('uncaught:exception', (err, runnable) => {
  // returning false here prevents Cypress from failing the test
  return false;
});
`;

// 1) Marketing smoke
write(
  "00_marketing.smoke.cy.ts",
  commonHeader + `
describe("Generated: Marketing Smoke", { tags: ["@smoke","@marketing"] }, () => {
  it("loads all marketing routes", () => {
    cy.fixture("registry/routes.marketing.json").then((cfg) => {
      const baseUrl = Cypress.env(cfg.baseUrlEnv);
      expect(baseUrl).to.exist;

      cfg.routes.forEach((r: any) => {
        cy.log(\`\${r.key} -> \${r.path}\`);
        cy.visit(new URL(r.path, baseUrl).toString(), { failOnStatusCode: false });
        cy.assertNoAppCrash();
      });
    });
  });
});
`
);

// 2) Admin smoke (guest + protected check)
write(
  "01_admin.smoke.cy.ts",
  commonHeader + `
describe("Generated: Admin Smoke", { tags: ["@smoke","@admin"] }, () => {
  it("guest routes load and protected routes redirect", { tags: ["@security"] }, () => {
    cy.fixture("registry/routes.admin.json").then((cfg) => {
      const baseUrl = Cypress.env(cfg.baseUrlEnv);
      expect(baseUrl).to.exist;

      cfg.routes.forEach((r: any) => {
        cy.log(\`Checking route as guest: \${r.key}\`);
        
        // Ensure clean state for guest check
        cy.clearLocalStorage();
        cy.clearCookies();
        
        cy.visitRoute(cfg.baseUrlEnv, r.path);

        if (r.auth && r.auth !== "guest" && r.auth !== "any") {
          cy.assertRedirectToLogin();
        } else {
            cy.assertNoAppCrash();
        }
      });
    });
  });
});
`
);

// 3) Access matrix
write(
  "10_access.matrix.cy.ts",
  commonHeader + `
type Role = "guest"|"client"|"psw"|"manager"|"staff";

describe("Generated: Access Matrix", { tags: ["@security","@rbac"] }, () => {
  it("enforces route permissions", () => {
    cy.fixture("registry/routes.admin.json").then((routesCfg) => {
      cy.fixture("registry/access.matrix.json").then((m) => {
        const baseUrl = Cypress.env(routesCfg.baseUrlEnv);
        const redirect = m.redirectWhenDenied || "/login";

        const routeByKey = new Map<string, any>();
        routesCfg.routes.forEach((r:any) => routeByKey.set(r.key, r));

        (m.roles as Role[]).forEach((role) => {
          cy.log(\`Testing as role: \${role}\`);
          
          m.rules.forEach((rule:any) => {
            const route = routeByKey.get(rule.routeKey);
            if (!route) return;

            const allowed = rule.allowed.includes(role);
            
            cy.log(\`Testing access to \${route.key} (\${route.path}) - Expected Allowed: \${allowed}\`);
            
            // Clean state before each check
            cy.logout();
            if (role !== "guest") cy.loginAs(role);

            cy.visitRoute(routesCfg.baseUrlEnv, route.path);

            if (!allowed) {
                cy.url().should("include", redirect);
            } else {
                cy.url().should("not.include", redirect);
                cy.assertNoAppCrash();
            }
          });
        });
      });
    });
  });
});
`
);

// 4) Contract tests (staff/admin role)
write(
  "20_contracts.cy.ts",
  commonHeader + `
describe("Generated: Contracts", { tags: ["@contract"] }, () => {
  it("staff pages contain required data-cy elements", () => {
    cy.loginAs("staff");
    cy.fixture("registry/routes.admin.json").then((routesCfg) => {
      cy.fixture("registry/contracts.json").then((c) => {
        const baseUrl = Cypress.env(routesCfg.baseUrlEnv);

        Object.entries(c).forEach(([routeKey, selectors]) => {
          const route = routesCfg.routes.find((r:any) => r.key === routeKey);
          if (!route) return;

          cy.log(\`Verifying contract for page: \${routeKey}\`);
          cy.visitRoute(routesCfg.baseUrlEnv, route.path);
          cy.assertContract(selectors as string[]);
        });
      });
    });
  });
});
`
);
