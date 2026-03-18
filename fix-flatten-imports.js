const fs = require('fs');
const files = [
  'apps/web-admin/src/app/routes/auth/onboarding/onboarding.tsx',
  'apps/web-admin/src/app/routes/platform/superuser.tsx',
  'apps/web-admin/src/app/routes/tenancy/allied-health.tsx',
  'apps/web-admin/src/app/routes/tenancy/finance.tsx',
  'apps/web-admin/src/app/routes/tenancy/hr.tsx',
  'apps/web-admin/src/app/routes/tenancy/marketing.tsx',
  'apps/web-admin/src/app/routes/tenancy/qa.tsx'
];

files.forEach(f => {
  if (!fs.existsSync(f)) return;
  let c = fs.readFileSync(f, 'utf8');
  // How many steps to go up?
  // apps/web-admin/src/app/routes/auth/onboarding/onboarding.tsx -> 2 steps up to routes -> ../../shared/PageSectionRegistry
  // apps/web-admin/src/app/routes/platform/superuser.tsx -> 1 step up to routes -> ../shared/PageSectionRegistry
  
  let relative = '../shared/PageSectionRegistry';
  if (f.includes('onboarding.tsx')) {
      relative = '../../shared/PageSectionRegistry';
  }
  
  if (!c.includes('import { PageSectionRegistry }')) {
     c = `import { PageSectionRegistry } from '${relative}';\n` + c;
     fs.writeFileSync(f, c);
     console.log('Fixed registry imports in', f);
  }
});

// Fix tenancyImports.ts
const importsFile = 'apps/web-admin/src/app/routes/tenancy/tenancyImports.ts';
if (fs.existsSync(importsFile)) {
    let c = fs.readFileSync(importsFile, 'utf8');
    c = c.replace(/'\.\/allied-health\/treatments'/g, "'./allied-health'");
    c = c.replace(/'\.\/allied-health\/sign-off'/g, "'./allied-health'");
    fs.writeFileSync(importsFile, c);
    console.log('Fixed tenancyImports.ts');
}

// Fix test files
const testFiles = [
    'apps/web-admin/src/test/OwnerCoverage_allied.test.ts',
    'apps/web-admin/src/test/PageExports_batch4.test.ts'
];
testFiles.forEach(f => {
    if (!fs.existsSync(f)) return;
    let c = fs.readFileSync(f, 'utf8');
    c = c.replace(/allied-health\/(treatments|sign-off)'/g, "allied-health'");
    fs.writeFileSync(f, c);
    console.log('Fixed test file', f);
});
