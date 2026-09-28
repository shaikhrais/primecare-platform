// Dependency-free entry point for the existing `npm run api:spec` command.
import { spawnSync } from 'node:child_process';
import { fileURLToPath } from 'node:url';

const script = fileURLToPath(new URL('./export_governed_openapi.py', import.meta.url));
const result = spawnSync(process.env.PYTHON || 'python3', [script, ...process.argv.slice(2)], {
  stdio: 'inherit',
});
if (result.error) console.error('Unable to start the Python OpenAPI exporter. Python 3 is required.');
process.exit(result.status ?? 1);
