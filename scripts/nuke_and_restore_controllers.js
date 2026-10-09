// Legacy command name retained for compatibility. Validate the central hierarchy.
// Recreating every controller would overwrite reviewed workflows and restore simulations.
const path = require('path');
const {spawnSync} = require('child_process');
const result = spawnSync('python3', [path.join(__dirname, 'check-controller-inheritance.py')], {
  cwd: path.join(__dirname, '..'), stdio: 'inherit',
});
if (result.error) throw result.error;
process.exitCode = result.status ?? 1;
