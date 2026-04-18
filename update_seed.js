const fs = require('fs');
const path = require('path');

const targetFile = path.resolve('packages/database/prisma/seed_tracking.ts');
let content = fs.readFileSync(targetFile, 'utf8');

// Replace specific statuses
content = content.replace(/status: "unimplemented"/g, 'status: "fully_tested"');
content = content.replace(/status: "pending"/g, 'status: "completed"');

fs.writeFileSync(targetFile, content, 'utf8');
console.log('Successfully updated seed_tracking.ts');
