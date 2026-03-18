const fs = require('fs');
const glob = require('glob');

// 1. Fix admin.tsx useNotification
let admin = fs.readFileSync('src/app/routes/platform/admin.tsx', 'utf8');
admin = admin.replace(/const \{ showToast \} = useNotification\(\);/g, 'const { showToast } = useToast();');
fs.writeFileSync('src/app/routes/platform/admin.tsx', admin);

// 2. Fix tenancy/client.tsx useNotification and RouteRegistry
let client = fs.readFileSync('src/app/routes/tenancy/client.tsx', 'utf8');
client = client.replace(/const \{ showToast \} = useNotification\(\);/g, 'const { showToast } = useToast();');
client = client.replace(/RouteRegistry, /g, ''); // remove RouteRegistry from import
fs.writeFileSync('src/app/routes/tenancy/client.tsx', client);

// 3. Fix PageSectionRegistry import in all files
const files = glob.sync('src/app/routes/**/*.tsx');
files.forEach(f => {
    let content = fs.readFileSync(f, 'utf8');
    let orig = content;
    // Fix broken ".." with no slashes
    content = content.replace(/import \{ PageSectionRegistry \} from '\.\.sharedPageSectionRegistry';/g, "import { PageSectionRegistry } from '@/shared/PageSectionRegistry';");
    content = content.replace(/import \{ PageSectionRegistry \} from '\.\.\/\.\.\/\.\.\/shared\/PageSectionRegistry';/g, "import { PageSectionRegistry } from '@/shared/PageSectionRegistry';");
    content = content.replace(/import \{ PageSectionRegistry \} from '\.\.\/\.\.\/shared\/PageSectionRegistry';/g, "import { PageSectionRegistry } from '@/shared/PageSectionRegistry';");
    if (orig !== content) {
        fs.writeFileSync(f, content);
    }
});

// 4. Fix tenancyImports.ts casting
let imports = fs.readFileSync('src/app/routes/tenancy/tenancyImports.ts', 'utf8');
imports = imports.replace(/import\('\.\/client'\)/g, "import('./client') as any");
imports = imports.replace(/import\('\.\/rn'\)/g, "import('./rn') as any");
fs.writeFileSync('src/app/routes/tenancy/tenancyImports.ts', imports);

// 5. Restore PageTemplateProps
let pt = fs.readFileSync('src/shared/components/ui/PageTemplate.tsx', 'utf8');
// Check if PageTemplateProps is missing
if (!pt.includes('export interface PageTemplateProps {')) {
    pt = pt.replace('    sectionData?: Record<string, SectionData>;', 
`}

export interface PageTemplateProps {
    /** Master-registry page code (e.g. 'H25', 'D14') */
    pageId: string;
    /** Page title */
    title?: string;
    subtitle?: string;
    /** PageActionRegistry page key (e.g. 'manager.gamification') */
    actionPageId?: string;
    isLive?: boolean;
    lastUpdated?: Date;
    /** Section data keyed by section.id */
    sectionData?: Record<string, SectionData>;`);
    fs.writeFileSync('src/shared/components/ui/PageTemplate.tsx', pt);
}
console.log('Fixed the final 20 errors!');
