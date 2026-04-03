const fs = require('fs');

const file = 'lib/routes/app_router.dart';
let content = fs.readFileSync(file, 'utf8');

const regex = /import '.*?' as ([A-Z][a-zA-Z0-9]+);/g;
let match;
const replaces = [];

while ((match = regex.exec(content)) !== null) {
  const oldPrefix = match[1];
  const newPrefix = oldPrefix.replace(/[A-Z]/g, letter => '_' + letter.toLowerCase()).replace(/^_/, '');
  replaces.push({ oldPrefix, newPrefix });
}

for (const { oldPrefix, newPrefix } of replaces) {
  content = content.replaceAll(`${oldPrefix}.`, `${newPrefix}.`);
  content = content.replaceAll(`as ${oldPrefix};`, `as ${newPrefix};`);
}

fs.writeFileSync(file, content, 'utf8');
console.log('Fixed app_router prefixes');
