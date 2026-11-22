import {build} from 'esbuild';
import {mkdir, writeFile} from 'node:fs/promises';
import path from 'node:path';
import {fileURLToPath} from 'node:url';
import {execFileSync} from 'node:child_process';

const root=path.resolve(path.dirname(fileURLToPath(import.meta.url)),'../..');
const index=process.argv.indexOf('--outdir');
const outdir=index<0?path.join(root,'packages/primecare_kitchen_sink_web/dist'):path.resolve(process.argv[index+1]);
execFileSync('python3',['tools/kitchen_sink/generate.py','--check'],{cwd:root,stdio:'inherit'});
await build({absWorkingDir:root,entryPoints:['tools/kitchen_sink/preview.ts'],bundle:true,format:'esm',target:'es2022',
  outfile:path.join(outdir,'assets/app.js'),minify:false,sourcemap:true});
await mkdir(outdir,{recursive:true});
await writeFile(path.join(outdir,'index.html'),'<!doctype html><html lang="en"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1"><meta name="robots" content="noindex,nofollow"><title>PrimeCare component kitchen sink</title><link rel="stylesheet" href="assets/app.css"></head><body><main data-cy="kitchen-sink-root"></main><script type="module" src="assets/app.js"></script></body></html>\n');
console.log(JSON.stringify({previewOnly:true,outdir,source:execFileSync('git',['rev-parse','HEAD'],{cwd:root,encoding:'utf8'}).trim()}));
