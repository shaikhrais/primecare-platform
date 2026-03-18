const fs = require('fs');
const path = require('path');

const files = [
  'apps/web-admin/src/app/routes/auth/components/index.tsx',
  'apps/web-admin/src/app/routes/auth/pages/onboarding/components/index.tsx',
  'apps/web-admin/src/app/routes/platform/admin/pages/franchise/index.tsx',
  'apps/web-admin/src/app/routes/platform/admin/pages/supply-chain/index.tsx',
  'apps/web-admin/src/app/routes/shared/pages/index.tsx',
  'apps/web-admin/src/app/routes/tenancy/manager/pages/engagement/index.tsx',
  'apps/web-admin/src/app/routes/tenancy/manager/pages/iot/index.tsx',
];

files.forEach(file => {
    const fullPath = path.resolve(process.cwd(), file);
    if (!fs.existsSync(fullPath)) return;
    
    let content = fs.readFileSync(fullPath, 'utf8');
    
    // Fix double exports
    content = content.replace(/export export /g, 'export ');
    content = content.replace(/export\nexport /g, 'export\n');
    content = content.replace(/export\s+export\s+/g, 'export ');
    
    // Fix useState missing
    if (content.includes('useState(') && !content.includes('useState }')) {
        content = content.replace(/import React from 'react';/, "import React, { useState } from 'react';");
    }
    
    fs.writeFileSync(fullPath, content, 'utf8');
    console.log(`Patched AST scopes in ${file}`);
});
