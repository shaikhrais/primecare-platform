// Registration scripts operate only on explicit isolated SQLite fixtures.
if (process.env.GOVERNANCE_ALLOW_SQLITE_FIXTURES === "1") {
if (process.env.GOVERNANCE_DATABASE_URL || process.env.PRODUCTION_DATABASE_URL) throw new Error("SQLite fixtures cannot be enabled with production credentials");
execFileSync('python3',['scripts/register-platform-admin-role.py']);
execFileSync('python3',['scripts/register-admin-hierarchy.py']);
execFileSync('python3',['scripts/register-admin-form-drafts.py']);
execFileSync('python3',['scripts/register-admin-reports.py']);
execFileSync('python3',['scripts/register-report-navigation.py']);
execFileSync('python3',['scripts/register-look-manager.py']);
execFileSync('python3',['scripts/register-look-provider.py']);
execFileSync('python3',['scripts/register-auth-recovery-web.py']);
execFileSync('python3',['scripts/register-media-look.py']);
execFileSync('python3',['scripts/register-maintenance-governance.py']);
execFileSync('python3',['scripts/register-workspace-governance.py']);
execFileSync('python3',['scripts/register-workspace-visual-review.py']);
execFileSync('python3',['scripts/register-tenant-operations.py']);
execFileSync('python3',['scripts/register-platform-bundle.py']);
execFileSync('python3',['scripts/register-territory-intake.py']);
execFileSync('python3',['scripts/register-care-governance.py']);
execFileSync('python3',['scripts/register-response-compression.py']);
}
import { cpSync, mkdirSync, readFileSync, rmSync, writeFileSync } from 'node:fs';
import { execFileSync } from 'node:child_process';
import { join } from 'node:path';

const gateway = process.env.API_GATEWAY_URL || 'https://primecare-api-gateway.itpro-mohammed.workers.dev';
const source = 'websites/typescript'; const generated = join(source, 'generated'); const dist = join(source, 'dist');
execFileSync('python3', ['scripts/verify-maintenance-catalog.py'], { stdio: 'inherit' });
execFileSync('python3', ['scripts/verify-recovery-catalog.py'], { stdio: 'inherit' });
execFileSync('python3', ['scripts/verify-workspace-resources.py'], { stdio: 'inherit' });
execFileSync('python3', ['scripts/export-typescript-websites.py', '--output', generated, '--gateway', gateway], { stdio: 'inherit' });
rmSync(dist, { recursive: true, force: true }); mkdirSync(join(dist, 'assets'), { recursive: true });
execFileSync('npx', ['esbuild', join(source, 'src/main.ts'), '--bundle', '--minify', `--outfile=${join(dist, 'assets/app.js')}`], { stdio: 'inherit' });
cpSync(join(source, 'src/styles.css'), join(dist, 'assets/app.css'));
cpSync(join(source, 'public'), dist, { recursive: true });
const projects = Object.keys(JSON.parse(readFileSync('websites/typescript/projects.json', 'utf8')));
for (const project of projects) {
  const target = join(dist, project); mkdirSync(join(target, 'assets'), { recursive: true });
  cpSync(join(source, 'index.html'), join(target, 'index.html')); cpSync(join(dist, 'assets'), join(target, 'assets'), { recursive: true });
  cpSync(join(generated, project, 'portal.json'), join(target, 'portal.json'));
  writeFileSync(join(target, '_redirects'), '/* /index.html 200\n');
  writeFileSync(join(target, '_headers'), '/*\n  X-Content-Type-Options: nosniff\n  X-Frame-Options: DENY\n  Referrer-Policy: strict-origin-when-cross-origin\n  Permissions-Policy: camera=(), microphone=(), geolocation=()\n');
}
