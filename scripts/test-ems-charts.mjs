import {test} from 'node:test';
import assert from 'node:assert/strict';
import {build} from 'esbuild';
import {JSDOM} from 'jsdom';
import {readFileSync} from 'node:fs';
import {readTrafficReport} from '../websites/typescript/src/endpoint-traffic-report.ts';
const built=await build({entryPoints:['websites/typescript/src/ems-charts.ts'],bundle:true,write:false,format:'esm',platform:'browser'});
const {mountEmsCharts}=await import('data:text/javascript;base64,'+Buffer.from(built.outputFiles[0].text).toString('base64'));
const report=(start=0)=>readTrafficReport({intervalSeconds:300,windowStartedAt:new Date(1700000000000+start).toISOString(),windowEndedAt:new Date(1700000300000+start).toISOString(),observedRequests:10,endpoints:[{endpoint:'GET /safe<script>',observedRequests:10,statusCounts:{200:8,500:2},declaredRequestBytes:{knownBytes:10,unknownRequests:0},declaredResponseBytes:{knownBytes:100,unknownRequests:0},responseHeaderLatencyP95Ms:10}],responseBodies:{status:'available',endpoints:[{endpoint:'GET /safe<script>',completedResponses:8,completedBytes:99,incompleteResponses:0,partialBytes:0}]}});
test('charts preserve counts, accessible tables, real time gaps, window deduplication and stale clearing',()=>{
 const dom=new JSDOM('<main></main>');const previous=globalThis.document;globalThis.document=dom.window.document;
 try{
 const host=document.querySelector('main'),charts=mountEmsCharts(host,'en');
 charts.setSummary({readiness:{ready:2,blocked:3,unverified:4,active_maintenance:1}});
 assert.equal(host.querySelector('.ems-chart-total').textContent,'10');
 assert.equal(document.querySelectorAll('style[data-pc-ems-styles]').length,1);
 host.style.setProperty('--color-primary','#123456');
 assert.equal(host.style.getPropertyValue('--color-primary'),'#123456');
 assert.equal(host.querySelector('[data-cy=ems-widget-0]').textContent,'10');
 charts.setTraffic(report());charts.setTraffic(report());
 assert.equal(host.querySelector('[data-cy=ems-widget-3]').textContent,'10');
 assert.equal(host.querySelector('[data-cy=ems-widget-5]').textContent,'80%');
 const trend=host.querySelectorAll('.ems-chart-card')[1];
 assert.equal(trend.querySelectorAll('tbody tr').length,1);
 charts.setTraffic(report(300000));assert.equal(trend.querySelectorAll('.ems-trend-line').length,1);
 charts.setTraffic(report(900000));assert.equal(trend.querySelectorAll('.ems-trend-line').length,1);
 assert.match(host.textContent,/GET \/safe<script>/);assert.equal(host.querySelectorAll('script').length,0);
 assert.equal(host.querySelectorAll('svg[role=img]').length,4);
 assert.match(host.textContent,/99/);
 assert.ok(host.querySelector('.ems-service-bars meter'));
 assert.match(host.querySelector('.ems-operational-card').textContent,/Blocked/);
 assert.ok(host.querySelector('.ems-status-card rect'));
 assert.ok(host.querySelector('.ems-operation-disclosure summary'));
 charts.setTraffic(undefined);assert.equal(host.querySelector('[data-cy=ems-widget-3]').textContent,'—');assert.equal(host.querySelectorAll('svg[role=img]').length,1);assert.doesNotMatch(trend.textContent,/Requests\/s/);
 charts.setSummary(undefined);assert.equal(host.querySelectorAll('svg[role=img]').length,0);
 charts.dispose();charts.setTraffic(report());assert.equal(host.children.length,0);
 }finally{globalThis.document=previous;dom.window.close();}
});

test('central library owns EMS presentation and has no feature palette or website dependency',()=>{
 const styles=readFileSync('packages/primecare_ui/web/ems-dashboard-styles.ts','utf8');
 assert.doesNotMatch(styles,/#[a-f0-9]{3,8}\b/i);
 assert.match(styles,/var\(--shadow-card/);
 assert.match(styles,/var\(--color-primary/);
 assert.doesNotMatch(readFileSync('packages/primecare_ui/web/ems-charts.ts','utf8'),/websites\//);
 assert.match(readFileSync('websites/typescript/src/ems-charts.ts','utf8'),/export \{mountEmsCharts,PrimeEmsDashboardControls\}/);
 assert.doesNotMatch(readFileSync('websites/typescript/src/styles.css','utf8'),/\.ems-widget/);
});
