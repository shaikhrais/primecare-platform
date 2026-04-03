const fs = require('fs');
const path = require('path');

const targetDir = path.join(__dirname, 'services');
if (fs.existsSync(targetDir)) {
  fs.readdirSync(targetDir).forEach(serviceName => {
    let pkgPath = path.join(targetDir, serviceName, 'package.json');
    if (fs.existsSync(pkgPath)) {
      let pkg = JSON.parse(fs.readFileSync(pkgPath, 'utf8'));
      if(!pkg.dependencies) pkg.dependencies = {};
      pkg.dependencies["hono"] = "^4.0.0";
      pkg.dependencies["@hono/zod-openapi"] = "^0.9.5";
      pkg.dependencies["zod"] = "^3.22.4";
      pkg.dependencies["@primecare/shared-auth"] = "^1.0.0";
      pkg.dependencies["@primecare/shared-utils"] = "^1.0.0";
      pkg.dependencies["@primecare/shared-events"] = "^1.0.0";
      pkg.dependencies["@primecare/shared-types"] = "^1.0.0";
      fs.writeFileSync(pkgPath, JSON.stringify(pkg, null, 2), 'utf8');
      console.log(`Injected vital npm dependencies -> ${serviceName}`);
    }
  });
}
