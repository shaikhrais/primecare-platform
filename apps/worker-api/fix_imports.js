const fs = require('fs');
const p = require('path');

const walk = d => fs.readdirSync(d).reduce((f, file) => {
  const name = p.join(d, file);
  return fs.statSync(name).isDirectory() ? [...f, ...walk(name)] : [...f, name];
}, []);

const files = walk('src').filter(f => f.endsWith('.ts'));
const sharedDir = p.resolve('src/_shared');
let count = 0;

files.forEach(f => {
  let c = fs.readFileSync(f, 'utf8');
  
  // Find any import that has _shared/
  const regex = /(?:from|import)\s+['"]([./]+_shared\/.*?)['"]/g;
  
  if (regex.test(c)) {
    let newContent = c.replace(regex, (match, importPath) => {
      const fileDir = p.dirname(p.resolve(f));
      let rel = p.relative(fileDir, sharedDir).replace(/\\/g, '/');
      if (!rel.startsWith('.')) rel = './' + rel;
      
      // importPath is something like '../../../_shared/middleware/rbac'
      // We want to replace everything before `_shared/` with the absolute relative calculation
      const afterShared = importPath.substring(importPath.indexOf('_shared/') + '_shared/'.length);
      const fixedPath = rel + '/' + afterShared;
      
      return match.replace(importPath, fixedPath);
    });
    
    if (c !== newContent) {
      fs.writeFileSync(f, newContent, 'utf8');
      console.log('Fixed:', f);
      count++;
    }
  }
});
console.log('Total fixed:', count);
