const fs = require('fs');
const path = require('path');

const files = [
  'apps/web-admin/src/app/routes/platform/admin/pages/ai/index.tsx',
  'apps/web-admin/src/app/routes/platform/admin/pages/claims/index.tsx',
  'apps/web-admin/src/app/routes/platform/admin/pages/security/index.tsx',
  'apps/web-admin/src/app/routes/platform/admin/pages/webhooks/index.tsx',
  'apps/web-admin/src/app/routes/shared/pages/error/index.tsx'
];

files.forEach(file => {
    const fullPath = path.resolve(process.cwd(), file);
    if (!fs.existsSync(fullPath)) return;
    
    let content = fs.readFileSync(fullPath, 'utf8');
    
    // Fix double exports
    content = content.replace(/export export /g, 'export ');
    content = content.replace(/export export\n/g, 'export\n');
    
    // Fix useState missing
    if (content.includes('useState(') && !content.includes('useState }')) {
        content = content.replace(/import React from 'react';/, "import React, { useState } from 'react';");
    }
    
    // Fix block scoping by uniquely typing `cols` and `TableColumn` inside each merged block
    let blocks = content.split('// --- Merged from ');
    for (let i = 1; i < blocks.length; i++) {
        // uniquely scope TableColumn
        blocks[i] = blocks[i].replace(/type TableColumn =/g, `type TableColumn_${i} =`);
        blocks[i] = blocks[i].replace(/TableColumn\[\]/g, `TableColumn_${i}[]`);
        blocks[i] = blocks[i].replace(/TableColumn</g, `TableColumn_${i}<`);
        blocks[i] = blocks[i].replace(/: TableColumn/g, `: TableColumn_${i}`);
        
        // uniquely scope cols
        // Match `const cols :` or `const cols:` or `const cols =`
        // We will just do a sweeping replace for the whole block since `cols` is highly specific
        blocks[i] = blocks[i].replace(/\bcols\b/g, `cols_${i}`);
    }
    content = blocks.join('// --- Merged from ');
    
    fs.writeFileSync(fullPath, content, 'utf8');
    console.log(`Patched AST scopes in ${file}`);
});
