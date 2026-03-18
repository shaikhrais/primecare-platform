const fs = require('fs');
const path = require('path');

const errors = JSON.parse(fs.readFileSync('apps/web-admin/errors-test.json', 'utf8'));

const testFiles = [...new Set(errors.map(err => path.resolve(process.cwd(), 'apps/web-admin', err.split('(')[0])))];

const authMap = {
    'login/F1-Login': { dir: 'login', comp: 'Login' },
    'register/F2-Register': { dir: 'register', comp: 'Register' },
    'forgot-password/F3-ForgotPassword': { dir: 'forgot-password', comp: 'ForgotPassword' },
    'reset-password/F4-ResetPassword': { dir: 'reset-password', comp: 'ResetPassword' },
    'onboard-business/F5-BusinessOnboard': { dir: 'onboard-business', comp: 'BusinessOnboard' }
};

for (let file of testFiles) {
    if (!fs.existsSync(file)) continue;
    let content = fs.readFileSync(file, 'utf8');
    
    for (const [oldPath, newInfo] of Object.entries(authMap)) {
        content = content.replace(new RegExp(`@/app/routes/auth/pages/${oldPath}`, 'g'), `@/app/routes/auth/pages/${newInfo.dir}`);
        
        // Let's also patch the specific '.default' expectation if evaluating the module's default export
        // e.g., expect(mod.default) => expect(mod.Login) or expect(mod.default || mod.Login)
        // A safe patch is replacing mod.default with (mod.default || mod.${newInfo.comp}) for these specifically.
        // Actually, just changing any expectation around it is safer if we just globally replace.
        // But since we can't easily parse AST here, let's just make the component default exported again in the index file?
        // Wait, the merge script stripped `export default` and changed it to `export function`.
        // The tests use `await import('@/app/...').then(m => m.default)`. 
    }
    
    // Instead of messing with the test assertions safely given the complex strings, it's MUCH safer to just
    // append `export default Login;` at the bottom of `apps/web-admin/src/app/routes/auth/pages/login/index.tsx`.
    // Let's do that for the 5 auth components below instead of patching test assertions.
    
    fs.writeFileSync(file, content, 'utf8');
    console.log(`Patched imports in test: ${file}`);
}

// Re-add default exports to the Auth index files so tests relying on `mod.default` don't break
for (const [_, info] of Object.entries(authMap)) {
    const indexPath = path.resolve(process.cwd(), 'apps/web-admin/src/app/routes/auth/pages', info.dir, 'index.tsx');
    if (fs.existsSync(indexPath)) {
        let idxContent = fs.readFileSync(indexPath, 'utf8');
        if (!idxContent.includes(`export default ${info.comp}`)) {
            idxContent += `\nexport default ${info.comp};\n`;
            fs.writeFileSync(indexPath, idxContent, 'utf8');
            console.log(`Added default export to ${info.dir}/index.tsx`);
        }
    }
}
