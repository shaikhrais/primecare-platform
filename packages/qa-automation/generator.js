const fs = require('fs');
const path = require('path');

// Setup Paths
const SERVICES_DIR = path.join(__dirname, '../../services');
const ARTIFACTS_DIR = path.join(__dirname, 'artifacts');

function walkDir(dir, callback) {
    fs.readdirSync(dir).forEach(f => {
        let dirPath = path.join(dir, f);
        let isDirectory = fs.statSync(dirPath).isDirectory();
        isDirectory ? walkDir(dirPath, callback) : callback(path.join(dir, f));
    });
}

function generateQA() {
    console.log('Initiating PrimeCare Static Endpoint Analyzer...');

    const routeFiles = [];
    walkDir(SERVICES_DIR, (filePath) => {
        if (filePath.endsWith('.ts')) routeFiles.push(filePath);
    });
    
    const routes = [];

    // Regex matchers
    const routeRegex = /method:\s*['"](get|post|put|delete|patch)['"],\s*path:\s*['"]([^'"]+)['"]/gi;
    const roleRegex = /requireRole\(\[\s*([^\]]+)\s*\]\)/g;

    routeFiles.forEach(file => {
        const content = fs.readFileSync(file, 'utf-8');
        
        // Only parse if it contains createRoute or Hono definitions
        if (!content.includes('createRoute') && !content.includes('app.get')) return;

        const serviceNameMatch = file.replace(/\\/g, '/').match(/services\/([^/]+)/);
        const serviceName = serviceNameMatch ? serviceNameMatch[1] : 'unknown-service';

        let match;
        while ((match = routeRegex.exec(content)) !== null) {
            const method = match[1].toUpperCase();
            const routePath = match[2];

            // Heuristic detection for roles in the same file
            let allowedRoles = [];
            let roleMatch;
            while ((roleMatch = roleRegex.exec(content)) !== null) {
                const rolesString = roleMatch[1].replace(/['"\s]/g, '');
                allowedRoles.push(...rolesString.split(','));
            }
            allowedRoles = [...new Set(allowedRoles)]; // deduplicate

            // If no roles specified, we enforce "protected" mapping natively unless it's public (like auth login)
            const isPublic = routePath.includes('/login') || routePath.includes('/register') || routePath.includes('/forgot') || routePath.includes('/public');
            let expectedRoles = allowedRoles.length ? allowedRoles : ['admin', 'ops'];

            if (isPublic) expectedRoles = [];

            routes.push({
                service: serviceName,
                method: method,
                path: routePath,
                authRequired: !isPublic,
                allowed_roles: expectedRoles,
                blocked_roles: !isPublic ? ['client', 'family'].filter(r => !expectedRoles.includes(r)) : []
            });
        }
    });

    console.log(`Discovered ${routes.length} isolated endpoints across the Microservice mesh.`);

    // 1. Generate Manifest
    fs.writeFileSync(path.join(ARTIFACTS_DIR, 'route-manifest.json'), JSON.stringify(routes, null, 2));

    // 2. Generate RBAC Matrix
    const rbacMatrix = routes.map(r => ({
        endpoint: r.path,
        method: r.method,
        allowed_roles: r.allowed_roles,
        blocked_roles: r.blocked_roles
    }));
    fs.writeFileSync(path.join(ARTIFACTS_DIR, 'rbac-matrix.json'), JSON.stringify(rbacMatrix, null, 2));

    // 3. Generate Postman Collection
    generatePostmanCollection(routes);
}

function generatePostmanCollection(routes) {
    const defaultHeaders = [{ key: 'Content-Type', value: 'application/json' }];
    
    const collection = {
        info: {
            name: 'PrimeCare Multi-Service QA Framework',
            schema: 'https://schema.getpostman.com/json/collection/v2.1.0/collection.json'
        },
        item: routes.map(route => {
            const endpointSubItems = [];

            // Helper to generate a test block
            const makeItem = (name, tokenVar, expectedCode, roleTest = false, schemaTest = false) => {
                const headers = [...defaultHeaders];
                if (tokenVar) {
                    headers.push({ key: 'Authorization', value: `Bearer {{${tokenVar}}}` });
                }

                // Testing logic
                let script = `
pm.test("Status code check", function () {
    pm.expect(pm.response.code).to.be.oneOf([200, 201, 204, 400, 401, 403, 404, 500]);
});

var code = pm.response.code;
pm.test("Expected status", function () {
    pm.expect(code).to.eql(${expectedCode});
});
`;

                return {
                    name: `(${route.method}) ${route.path} - ${name}`,
                    event: [
                        { listen: 'test', script: { exec: script.split('\\n'), type: 'text/javascript' } }
                    ],
                    request: {
                        method: route.method,
                        header: headers,
                        url: {
                            raw: `{{BASE_URL}}/v1${route.path}`,
                            host: ['{{BASE_URL}}'],
                            path: ['v1', ...route.path.split('/').filter(p => p !== '')]
                        },
                        body: (route.method === 'POST' || route.method === 'PUT') ? { mode: 'raw', raw: schemaTest ? '{"invalid":"data"}' : '{}' } : undefined
                    }
                };
            };

            if (route.authRequired) {
                endpointSubItems.push(makeItem('No Token -> Expect 401', null, 401));
                endpointSubItems.push(makeItem('Invalid Token -> Expect 401', 'INVALID_TOKEN', 401));
                endpointSubItems.push(makeItem('Expired Token -> Expect 401', 'EXPIRED_TOKEN', 401));
                
                if (route.blocked_roles.length > 0) {
                    endpointSubItems.push(makeItem('Wrong Role (Client) -> Expect 403', 'CLIENT_TOKEN', 403, true));
                }
                
                endpointSubItems.push(makeItem('Correct Role Access -> Expect 200/201/204', 'ADMIN_TOKEN', route.method === 'POST' ? 201 : 200));
                
                if (route.method === 'POST' || route.method === 'PUT') {
                    endpointSubItems.push(makeItem('Invalid Body Schema -> Expect 400', 'ADMIN_TOKEN', 400, false, true));
                }
                
                endpointSubItems.push(makeItem('Cross-Tenant Access -> Expect 403', 'FOREIGN_TENANT_TOKEN', 403));
            } else {
                endpointSubItems.push(makeItem('Public Access -> Expect 200/201', null, 200));
            }

            return {
                name: `${route.service} | ${route.path}`,
                item: endpointSubItems
            };
        })
    };

    fs.writeFileSync(path.join(ARTIFACTS_DIR, 'primecare.postman_collection.json'), JSON.stringify(collection, null, 2));
    console.log('Postman Newman Collection synthesized successfully!');
}

generateQA();
