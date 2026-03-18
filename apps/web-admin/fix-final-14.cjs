const fs = require('fs');
const path = require('path');
const glob = require('glob');

const targetPath = path.resolve('src/app/routes/shared/PageSectionRegistry');

const files = glob.sync('src/app/routes/**/*.tsx');
files.forEach(f => {
    let content = fs.readFileSync(f, 'utf8');
    if (content.includes('PageSectionRegistry')) {
        const fileDir = path.dirname(path.resolve(f));
        let relativePath = path.relative(fileDir, targetPath).replace(/\\/g, '/');
        if (!relativePath.startsWith('.')) relativePath = './' + relativePath;

        content = content.replace(/import \{ PageSectionRegistry \} from ['"][^'"]+['"];/g, `import { PageSectionRegistry } from '${relativePath}';`);
        fs.writeFileSync(f, content);
    }
});
console.log('Fixed PageSectionRegistry imports with exact relative paths.');
