const fs = require('fs');

function addImports(file, importsStr) {
    if (!fs.existsSync(file)) return;
    let content = fs.readFileSync(file, 'utf8');
    content = importsStr + '\n' + content;
    fs.writeFileSync(file, content, 'utf8');
    console.log('Patched imports in ' + file);
}

// page-registry.tsx
addImports('apps/web-admin/src/app/routes/platform/admin/page-registry.tsx', 
  "import { BarChart3, ClipboardList, Layers, Compass, Wand2, FileText, Wrench, Globe, BookOpen, AlertTriangle } from 'lucide-react';");

// reseller.tsx
addImports('apps/web-admin/src/app/routes/platform/admin/reseller.tsx', 
  "import { AdminRegistry } from 'prime-care-shared';");

// security.tsx
addImports('apps/web-admin/src/app/routes/platform/admin/security.tsx', 
  "import { AdminRegistry } from 'prime-care-shared';\nimport { apiClient } from '../../../../../shared/utils/apiClient';\nimport { useRegistryQuery } from '../../../../../shared/hooks/useRegistryQuery';\nimport { useQueryClient } from '@tanstack/react-query';");

// users.tsx
addImports('apps/web-admin/src/app/routes/platform/admin/users.tsx', 
  "import { AdminRegistry } from 'prime-care-shared';\nimport { apiClient } from '../../../../../shared/utils/apiClient';");
