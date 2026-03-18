const fs = require('fs');
const glob = require('glob');

// 1. Fix PageTemplate interface to support missing titles
let ptPath = 'apps/web-admin/src/shared/components/ui/PageTemplate.tsx';
let pt = fs.readFileSync(ptPath, 'utf8');

if (!pt.includes('finalTitle')) {
    pt = pt.replace("import { getSectionsForPage, type PageSection, type SectionType } from 'prime-care-shared';", 
                    "import { getSectionsForPage, type PageSection, type SectionType, getPageById } from 'prime-care-shared';");
    pt = pt.replace(/title: string;\n\s+subtitle\?: string;/g, "title?: string;\n    subtitle?: string;");
    pt = pt.replace(/const sections = getSectionsForPage\(pageId\);/g, 
                    "const sections = getSectionsForPage(pageId);\n    const entry = getPageById(pageId);\n    const finalTitle = title || entry?.label || pageId;\n    const finalSubtitle = subtitle || entry?.description || '';");

    pt = pt.replace(/aria-label=\{title\}/g, "aria-label={finalTitle as string}");
    pt = pt.replace("title={title} subtitle={subtitle}", "title={finalTitle as string} subtitle={finalSubtitle}");
    fs.writeFileSync(ptPath, pt);
    console.log("Updated PageTemplate.tsx to support implicit PageRegistry lookups.");
}

// 2. Strip ALL title="..." and subtitle="..." from every page under app/routes
function processFiles(pattern) {
    const files = glob.sync(pattern);
    for (const file of files) {
        let content = fs.readFileSync(file, 'utf8');
        let original = content;

        // Use \b to prevent matching `subtitle` when replacing `title`
        content = content.replace(/\bsubtitle\s*=\s*["'][^"']*["']/g, '');
        content = content.replace(/\btitle\s*=\s*["'][^"']*["']/g, '');

        if (content !== original) {
            fs.writeFileSync(file, content);
            console.log("Stripped literal UI strings from: " + file);
        }
    }
}
processFiles('apps/web-admin/src/app/routes/**/*.tsx');

console.log("UI String Literacy Automation Complete.");
