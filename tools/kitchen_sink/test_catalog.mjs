import test from 'node:test';
import assert from 'node:assert/strict';
import fs from 'node:fs';
import path from 'node:path';
import {fileURLToPath} from 'node:url';
import {build} from 'esbuild';
import {createHash} from 'node:crypto';
import {kitchenSinkCatalog as catalog} from '../../packages/primecare_kitchen_sink_catalog/src/index.mjs';

const root=path.resolve(path.dirname(fileURLToPath(import.meta.url)),'../..');
test('all reference dispositions remain exactly the existing source inventory; examples grant no production credit',()=>{
  const original=JSON.parse(fs.readFileSync(path.join(root,'packages/primecare_ui/catalogs/developer-catalogue.json')));
  assert.equal(catalog.previewOnly,true);assert.equal(catalog.fullReferenceParity,false);assert.equal(catalog.vendorSourceCopied,false);
  assert.deepEqual(catalog.references.map(r=>[r.id,r.recordedDisposition]),original.features.map(r=>[r.id,r.disposition]));
  assert.equal(catalog.references.length,72);
  for(const [source,sha] of Object.entries(catalog.sources))assert.equal(createHash('sha256').update(fs.readFileSync(path.join(root,source))).digest('hex'),sha);
});
test('all 36 stories retain existing APIs, source ownership, labels and declared platform availability',()=>{
  assert.equal(catalog.stories.length,36);assert.equal(new Set(catalog.stories.map(s=>s.id)).size,36);
  for(const story of catalog.stories){
    assert.ok(fs.existsSync(path.join(root,story.webSource)),story.webSource);
    const [symbol,method]=story.webSymbol.split('.');const source=fs.readFileSync(path.join(root,story.webSource),'utf8');
    assert.ok(source.includes('class '+symbol));assert.ok(source.includes(method+'(')||source.includes(method+'<'));
    assert.equal(story.exampleKind,'local-synthetic');assert.equal(story.productionAcceptance,'not-inferred');
    for(const locale of ['en','fr','es'])assert.ok(story.titles[locale].trim());
    assert.equal(story.flutterPreview,!['autocomplete','metric'].includes(story.id));
  }
});
test('the master forwards the original factories without renaming or duplicating class identity',async()=>{
  const result=await build({stdin:{contents:`
    import {PrimeComponentFactory,PrimeDataControls,PrimeDashboardWidgets,mountKitchenSink} from './packages/primecare_master/web/kitchen-sink';
    import {PrimeComponentFactory as C} from './packages/primecare_ui/web/component-catalogue';
    import {PrimeDataControls as D} from './packages/primecare_ui/web/data-controls';
    import {PrimeDashboardWidgets as W} from './packages/primecare_ui/web/dashboard-widgets';
    import {PrimeDashboardWidgets as DWidget,packDashboard} from './packages/primecare_master/web/dashboard';
    export const identity=PrimeComponentFactory===C&&PrimeDataControls===D&&PrimeDashboardWidgets===W&&W===DWidget;
    export const packed=packDashboard([{id:"metric",span:1,rows:1}],2);
    export {mountKitchenSink};`,resolveDir:root},bundle:true,write:false,platform:'node',format:'esm'});
  const module=await import('data:text/javascript;base64,'+Buffer.from(result.outputFiles[0].contents).toString('base64'));
  assert.equal(module.identity,true);
  assert.deepEqual(module.packed,[{id:"metric",span:1,rows:1,x:0,y:0}]);
  const body={};assert.throws(()=>module.mountKitchenSink(Object.assign(body,{ownerDocument:{body}})),/Scoped showcase root/);
  assert.throws(()=>module.mountKitchenSink({ownerDocument:{}},{locale:'invalid'}),/Unsupported kitchen sink locale/);
});
