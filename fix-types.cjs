const fs = require('fs');
const path = require('path');

const d = path.join(__dirname, 'apps/web-admin/src/app/sections');

const walk = dir => {
    fs.readdirSync(dir).forEach(f => {
        const p = path.join(dir, f);
        if (fs.statSync(p).isDirectory()) walk(p);
        else if (p.endsWith('.ts')) {
            let c = fs.readFileSync(p, 'utf8');
            c = c.replace("import { SectionConfig } from '@/shared/types';\n", "");
            c = c.replace(/: SectionConfig =/g, ": any =");
            c = c.replace(/Record<string, SectionConfig>/g, "Record<string, any>");
            fs.writeFileSync(p, c, 'utf8');
        }
    });
};

walk(d);
console.log('✅ Replaced typings in all files');
