const fs = require('fs');
const glob = require('glob');

glob.sync('packages/shared/src/registries/ApiRegistry/*.ts').forEach(f => {
    if(f.includes('api-vars')) return;
    let content = fs.readFileSync(f, 'utf8');
    if (!content.includes('import { API_VARS }')) {
        fs.writeFileSync(f, "import { API_VARS } from './api-vars';\n" + content);
        console.log('Fixed ' + f);
    }
});
