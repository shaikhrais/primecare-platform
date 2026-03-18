const fs = require('fs');

const routerFile = 'apps/web-admin/src/app/router.tsx';
let content = fs.readFileSync(routerFile, 'utf8');

// Update auth imports from specific subfiles to default or named index exports
// Wait, my merge script actually converted them to named exports (`export function Login`) instead of `export default function`.
// But the router imports them like: `import Login from './routes/auth/pages/login';` which expects a default export if they point to index.
// I should just patch router.tsx to import the named exports.

content = content.replace(/import Login from '.\/routes\/auth\/pages\/login';/, "import { Login } from './routes/auth/pages/login';");
content = content.replace(/import Register from '.\/routes\/auth\/pages\/register';/, "import { Register } from './routes/auth/pages/register';");
content = content.replace(/import ForgotPassword from '.\/routes\/auth\/pages\/forgot-password';/, "import { ForgotPassword } from './routes/auth/pages/forgot-password';");
content = content.replace(/import ResetPassword from '.\/routes\/auth\/pages\/reset-password';/, "import { ResetPassword } from './routes/auth/pages/reset-password';");
content = content.replace(/import BusinessOnboard from '.\/routes\/auth\/pages\/onboard-business';/, "import { BusinessOnboard } from './routes/auth/pages/onboard-business';");

fs.writeFileSync(routerFile, content, 'utf8');
console.log('Patched router.tsx with named exports for Auth pages.');
