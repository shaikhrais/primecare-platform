import {readFile,writeFile} from 'node:fs/promises';
import {createHash} from 'node:crypto';
const inputPath=new URL('../packages/flutter_core/test/application_modules/fixtures/application_workflow_identities.json',import.meta.url);
const bytes=await readFile(inputPath,'utf8'),input=JSON.parse(bytes);
const pin=JSON.parse(await readFile(new URL('../tools/governance-production/production-pin.json',import.meta.url),'utf8'));
if(input.kind!=='recorded_production_failure_boundary_input'||input.noActivation!==true||input.manifestSha256!==pin.manifestSha256||input.operations.length!==114)throw Error('Recorded production failure-boundary input differs');
const ids=new Set(),paths=new Set();
for(const row of input.operations){
 if(!Number.isSafeInteger(row.id)||ids.has(row.id)||!['GET','POST','PUT','PATCH','DELETE'].includes(row.method)||typeof row.path!=='string'||!/^\/v1\/[A-Za-z0-9_./{}-]+$/.test(row.path)||row.path.includes('..')||/[{}]/.test(row.path.replaceAll('{id}','')))throw Error('Unexpected existing operation identity');
 ids.add(row.id);paths.add(row.path.replace(/\/+$/, ''));
}
if(paths.size!==113)throw Error('Recorded path count differs');
const ordered=[...paths].sort(),literal=ordered.filter(path=>!path.includes('{id}')),templates=ordered.filter(path=>path.includes('{id}'));
const escape=s=>s.replace(/[.*+?^${}()|[\]\\]/g,'\\$&');
const output='// Generated from recorded production discovery '+input.runId+'; do not hand-edit.\n'+
 '// Input sha256 '+createHash('sha256').update(bytes).digest('hex')+'\n'+
 '/// Failure/cache exclusion only; no handler, role, permission or host authority.\n'+
 'const _applicationWorkflowExactPaths = {\n'+literal.map(path=>"  '"+path+"',\n").join('')+'};\n'+
 'final _applicationWorkflowPatterns = <RegExp>[\n'+templates.map(path=>"  RegExp(r'^"+path.split('{id}').map(escape).join('[^/]+')+"$'),\n").join('')+'];\n\n'+
 "bool isApplicationWorkflowPath(String path) {\n  final uri = Uri.tryParse(path);\n  if (uri == null) return false;\n  // Normalize relative/absolute forms without I/O or adding route authority.\n  final route = Uri.parse('https://api.invalid/').resolveUri(uri)\n      .normalizePath().path.replaceFirst(RegExp(r'/+$'), '');\n  return _applicationWorkflowExactPaths.contains(route) ||\n      _applicationWorkflowPatterns.any((pattern) => pattern.hasMatch(route));\n}\n";
const target=new URL('../packages/flutter_core/lib/application_modules/application_workflow_paths.dart',import.meta.url);
if(process.argv.includes('--check')){if(await readFile(target,'utf8')!==output)throw Error('Failure-boundary source differs from recorded input');}
else await writeFile(target,output);
console.log(JSON.stringify({declarations:ids.size,paths:paths.size,noActivation:true}));
