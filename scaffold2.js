const fs = require('fs');
const path = require('path');

function writePkg(dir, name, type) {
    const isService = type === 'service';
    const pkg = {
        name: `@primecare/${name}`,
        version: "1.0.0",
        private: true,
        main: isService ? "src/index.ts" : "index.ts",
        scripts: isService ? {
            "dev": "wrangler dev src/index.ts",
            "build": "tsc",
            "deploy": "wrangler deploy src/index.ts"
        } : {
            "build": "tsc"
        },
        dependencies: isService ? {
            "hono": "^4.2.0"
        } : {},
        devDependencies: {
            "typescript": "^5.0.0"
        }
    };
    
    // Create src directory if service
    if (isService) {
        fs.mkdirSync(path.join(dir, 'src'), { recursive: true });
        const tsContent = `import { Hono } from 'hono';\nconst app = new Hono();\napp.get('/', (c) => c.text('Hello from ${name}'));\nexport default app;`;
        fs.writeFileSync(path.join(dir, 'src', 'index.ts'), tsContent);
    } else {
        fs.writeFileSync(path.join(dir, 'index.ts'), `export const ${name.replace(/-/g, '_')} = "${name}";`);
    }

    fs.writeFileSync(path.join(dir, 'package.json'), JSON.stringify(pkg, null, 2));

    const tsconfig = {
        "compilerOptions": {
            "target": "ESNext",
            "module": "ESNext",
            "moduleResolution": "Bundler",
            "strict": true,
            "skipLibCheck": true,
            "declaration": true,
            "outDir": "./dist"
        },
        "include": isService ? ["src/**/*"] : ["index.ts"]
    };
    fs.writeFileSync(path.join(dir, 'tsconfig.json'), JSON.stringify(tsconfig, null, 2));
}

// Packages
writePkg('packages/shared-types', 'shared-types', 'package');
writePkg('packages/shared-auth', 'shared-auth', 'package');
writePkg('packages/shared-events', 'shared-events', 'package');
writePkg('packages/shared-utils', 'shared-utils', 'package');

// Services
writePkg('services/api-gateway', 'api-gateway', 'service');
writePkg('services/auth-service', 'auth-service', 'service');
writePkg('services/provider-service', 'provider-service', 'service');
writePkg('services/client-service', 'client-service', 'service');
writePkg('services/scheduling-service', 'scheduling-service', 'service');
writePkg('services/visit-service', 'visit-service', 'service');
writePkg('services/notes-service', 'notes-service', 'service');
writePkg('services/billing-service', 'billing-service', 'service');
writePkg('services/notification-service', 'notification-service', 'service');
writePkg('services/compliance-service', 'compliance-service', 'service');
writePkg('services/franchise-reporting-service', 'franchise-reporting-service', 'service');

console.log("Scaffolding complete!");
