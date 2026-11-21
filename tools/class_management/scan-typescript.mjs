import fs from 'node:fs';
import path from 'node:path';
import crypto from 'node:crypto';
import {createRequire} from 'node:module';
const require=createRequire(import.meta.url);
const ts=require(process.env.CLASS_REGISTRY_TYPESCRIPT || 'typescript');
const [root,output]=process.argv.slice(2);
if(!root||!output)throw Error('Usage: scan-typescript.mjs ROOT OUTPUT');
const hash=value=>crypto.createHash('sha256').update(value).digest('hex');
const classes=[],diagnostics=[];let files=0;
const excluded=new Set(['node_modules','build','.dart_tool','.git','dist','.next','.cache','coverage','__pycache__','.venv','venv']);
function walk(folder){if(!fs.existsSync(folder))return;for(const entry of fs.readdirSync(folder,{withFileTypes:true})){
 if(excluded.has(entry.name)||entry.isSymbolicLink())continue;
 const file=path.join(folder,entry.name);
 if(entry.isDirectory()){walk(file);continue;}
 if(!/\.(ts|tsx|js|jsx)$/.test(file)||/\.d\.ts$/.test(file))continue;
 const relative=path.relative(root,file).split(path.sep).join('/');
 const source=fs.readFileSync(file,'utf8');
 const ast=ts.createSourceFile(relative,source,ts.ScriptTarget.Latest,true,relative.endsWith('x')?ts.ScriptKind.TSX:relative.endsWith('.ts')?ts.ScriptKind.TS:ts.ScriptKind.JS);
 files++;for(const issue of ast.parseDiagnostics){diagnostics.push({path:relative,line:ast.getLineAndCharacterOfPosition(issue.start||0).line+1,code:String(issue.code)});}
 function visit(node,scope=[]){
  const isClass=ts.isClassDeclaration(node)||ts.isClassExpression(node);
  const isInterface=ts.isInterfaceDeclaration(node);
  let next=scope;
  if(isClass||isInterface){
   const line=ast.getLineAndCharacterOfPosition(node.getStart(ast)).line+1;
   const binding=ts.isVariableDeclaration(node.parent)||ts.isPropertyAssignment(node.parent)?node.parent.name.getText(ast):null;
   const name=ts.isClassExpression(node)&&binding ? binding+(node.name&&node.name.text!==binding?'.'+node.name.text:'') : node.name?.text || `anonymous@${node.getStart(ast)}`;
   const qualified=[...scope,name].join('.');
   const bases=(node.heritageClauses||[]).filter(x=>x.token===ts.SyntaxKind.ExtendsKeyword).flatMap(x=>x.types.map(t=>t.getText(ast)));
   const interfaces=(node.heritageClauses||[]).filter(x=>x.token===ts.SyntaxKind.ImplementsKeyword).flatMap(x=>x.types.map(t=>t.getText(ast)));
   classes.push({id:`typescript:${hash(relative+'::'+qualified)}`,name:qualified,language:'typescript',path:relative,line,
    kind:isInterface?'interface':'class',abstract:!!node.modifiers?.some(x=>x.kind===ts.SyntaxKind.AbstractKeyword),private:name.startsWith('_'),
    scope:relative.split('/').some(x=>['test','tests','fixtures','__tests__'].includes(x))||/\.(test|spec)\./.test(relative)?'test':'source',
    sourceSha256:hash(source),bodySha256:hash(ts.createPrinter({removeComments:true}).printNode(ts.EmitHint.Unspecified,node,ast)),
    baseName:bases[0]||null,interfaces,sourceDescription:(node.jsDoc||[]).map(x=>typeof x.comment==='string'?x.comment:'').join('\n')||null,
    descriptionStatus:'needs_review',databaseStatus:'unknown',parseValid:ast.parseDiagnostics.length===0,unstableIdentity:scope.some(part=>part.startsWith('@closure'))||(!node.name&&!ts.isVariableDeclaration(node.parent))});
   next=[...scope,name];
  }else if(ts.isModuleDeclaration(node)&&node.name)next=[...scope,node.name.getText(ast)];
  else if(ts.isFunctionLike(node)){const label=node.name?.getText(ast)||(ts.isVariableDeclaration(node.parent)?node.parent.name.getText(ast):`@closure${node.getStart(ast)}`);next=[...scope,label];}
  ts.forEachChild(node,child=>visit(child,next));
 }
 visit(ast);
}}
for(const base of ['apps','packages','services','tools','scripts','cloudflare','websites'])walk(path.join(root,base));
classes.sort((a,b)=>a.id.localeCompare(b.id));fs.mkdirSync(path.dirname(output),{recursive:true});fs.writeFileSync(output,JSON.stringify({format:1,language:'typescript',files,complete:diagnostics.length===0,classes,diagnostics}));
console.log(JSON.stringify({files,classes:classes.length,diagnostics:diagnostics.length}));
