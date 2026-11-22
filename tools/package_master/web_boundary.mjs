import fs from 'node:fs';
import path from 'node:path';
import {fileURLToPath} from 'node:url';
import ts from 'typescript';

export const root = path.resolve(path.dirname(fileURLToPath(import.meta.url)), '../..');
const master = 'packages/primecare_master';
const slash = value => value.split(path.sep).join('/');
const skipped = new Set(['node_modules', 'build', 'dist']);
function walk(directory) {
  if (!fs.existsSync(directory)) return [];
  return fs.readdirSync(directory, {withFileTypes: true}).flatMap(entry => {
    if (entry.name.startsWith('.') || skipped.has(entry.name) || entry.isSymbolicLink()) return [];
    const full = path.join(directory, entry.name);
    return entry.isDirectory() ? walk(full) : [full];
  });
}

export function references(source, filename) {
  const tree = ts.createSourceFile(filename, source, ts.ScriptTarget.Latest, true);
  if (tree.parseDiagnostics.length) throw new Error(`Cannot parse ${filename}`);
  const found = [];
  function add(node) {
    if (node && ts.isStringLiteralLike(node)) found.push({uri: node.text,
      offset: node.getStart(tree), length: node.getWidth(tree)});
  }
  function visit(node) {
    if (ts.isImportDeclaration(node) || ts.isExportDeclaration(node)) add(node.moduleSpecifier);
    else if (ts.isImportTypeNode(node) && ts.isLiteralTypeNode(node.argument)) add(node.argument.literal);
    else if (ts.isImportEqualsDeclaration(node) && ts.isExternalModuleReference(node.moduleReference)) add(node.moduleReference.expression);
    else if (ts.isCallExpression(node) && (node.expression.kind === ts.SyntaxKind.ImportKeyword ||
      (ts.isIdentifier(node.expression) && node.expression.text === 'require'))) add(node.arguments[0]);
    ts.forEachChild(node, visit);
  }
  visit(tree);
  return found;
}

function gatewaySource(entry) {
  const relative = slash(path.relative(path.dirname(entry.gateway), entry.target)).replace(/\.tsx?$/, '');
  const spec = JSON.stringify(relative.startsWith('.') ? relative : './' + relative);
  if (entry.target.endsWith('.json')) return `// Generated gateway; JSON remains owned by its original package.\nimport value from ${spec};\nexport default value;\n`;
  return `// Generated gateway. Do not copy implementation here.\nexport * from ${spec};\n` +
    (entry.defaultExport ? `export {default} from ${spec};\n` : '');
}

export function check({write = false} = {}) {
  const ledger = JSON.parse(fs.readFileSync(path.join(root, master, 'gateways.json')));
  const gateways = new Map();
  const registered = new Set();
  for (const entry of ledger.gateways) {
    if (entry.language !== 'web' || !entry.gateway.startsWith(master + '/web/') ||
      !entry.target.startsWith('packages/') || entry.target.startsWith(master + '/') ||
      entry.gateway.includes('..') || entry.target.includes('..')) throw new Error('Invalid web gateway');
    if (registered.has(entry.gateway)) throw new Error('Duplicate master gateway');
    registered.add(entry.gateway);
    gateways.set(entry.target, entry.gateway);
    if (!fs.existsSync(path.join(root, entry.target)) ||
      fs.readFileSync(path.join(root, entry.gateway), 'utf8') !== gatewaySource(entry)) {
      throw new Error(`Missing or changed master gateway: ${entry.gateway}`);
    }
    if (entry.target.endsWith('.mjs') && fs.existsSync(path.join(root, entry.target.replace(/\.mjs$/, '.d.mts')))) {
      const declaration = path.join(root, entry.gateway.replace(/\.mjs$/, '.d.mts'));
      if (!fs.existsSync(declaration) || fs.readFileSync(declaration, 'utf8') !== gatewaySource(entry))
        throw new Error(`Missing or changed master type gateway: ${entry.gateway}`);
    }
  }
  const names = new Map();
  for (const directory of fs.readdirSync(path.join(root, 'packages'))) {
    const manifest = path.join(root, 'packages', directory, 'package.json');
    if (fs.existsSync(manifest)) names.set(JSON.parse(fs.readFileSync(manifest)).name, `packages/${directory}`);
  }
  function resolve(file, uri) {
    if (uri.startsWith('.')) return slash(path.relative(root, path.resolve(root, path.dirname(file), uri)));
    if (!uri.startsWith('@primecare/')) return null;
    const name = [...names.keys()].find(name => uri === name || uri.startsWith(name + '/'));
    if (!name) throw new Error(`Unknown internal package: ${uri}`);
    const directory = names.get(name), suffix = uri.slice(name.length).replace(/^\//, '');
    if (suffix) return `${directory}/${suffix}`;
    const manifest = JSON.parse(fs.readFileSync(path.join(root, directory, 'package.json')));
    const entry = manifest.exports?.['.'];
    return path.posix.normalize(`${directory}/${typeof entry === 'string' ? entry : entry?.import || manifest.module || manifest.main || 'index.ts'}`);
  }
  const violations = [], changed = [];
  let imports = 0, consumers = 0;
  for (const group of ['websites', 'packages']) {
    for (const absolute of walk(path.join(root, group))) {
      if (!/\.(?:[cm]?js|tsx?)$/.test(absolute) || absolute.endsWith('.d.ts')) continue;
      const file = slash(path.relative(root, absolute));
      if (file.startsWith(master + '/')) continue;
      const publicConsumer = file.startsWith('websites/');
      const source = fs.readFileSync(absolute, 'utf8'), edits = [];
      for (const ref of references(source, file)) {
        const target = resolve(file, ref.uri);
        if (!target?.startsWith('packages/')) continue;
        if (target.startsWith(master + '/')) {
          const registeredTarget = ['', '.ts', '.tsx', '.mjs', '.js']
            .map(suffix => target + suffix).find(candidate => registered.has(candidate));
          if (!publicConsumer) violations.push(`${file}: private package imports master`);
          else if (!registeredTarget && ![`${master}/src/index.mjs`, `${master}/src/catalog.mjs`].includes(target))
            violations.push(`${file}: unregistered master entry ${target}`);
          if (publicConsumer && /\.tsx?$/.test(ref.uri)) {
            if (!write) violations.push(`${file}: preserve extensionless TypeScript import compatibility`);
            edits.push({...ref, replacement: JSON.stringify(ref.uri.replace(/\.tsx?$/, ''))});
          }
          imports++;
          continue;
        }
        if (!publicConsumer) continue;
        const actual = ['', '.ts', '.tsx', '.mjs', '.js', '.json', '/index.ts', '/index.mjs', '/index.js']
          .map(suffix => target + suffix).find(candidate => gateways.has(candidate));
        if (!actual) throw new Error(`No registered master gateway for ${file}: ${ref.uri}`);
        if (!write) violations.push(`${file}: direct internal import ${ref.uri}`);
        let relative = slash(path.relative(path.dirname(file), gateways.get(actual)));
        if (!relative.startsWith('.')) relative = './' + relative;
        relative = relative.replace(/\.tsx?$/, '');
        edits.push({...ref, replacement: JSON.stringify(relative)});
      }
      if (publicConsumer) consumers++;
      if (write && edits.length) {
        let output = source;
        for (const edit of edits.sort((a, b) => b.offset - a.offset))
          output = output.slice(0, edit.offset) + edit.replacement + output.slice(edit.offset + edit.length);
        fs.writeFileSync(absolute, output);
        changed.push(file);
      }
    }
  }
  if (violations.length) throw new Error(violations.slice(0, 25).join('\n'));
  return {scope: 'live TypeScript websites', gateways: registered.size, consumerFiles: consumers,
    masterImports: imports, changed};
}

if (process.argv[1] && path.resolve(process.argv[1]) === fileURLToPath(import.meta.url))
  console.log(JSON.stringify(check({write: process.argv.includes('--write')})));
