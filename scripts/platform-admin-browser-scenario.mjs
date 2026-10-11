import assert from 'node:assert/strict';
import {randomUUID} from 'node:crypto';
import {fillFlutterField} from './flutter-browser-input.mjs';
export async function runPlatformAdminBrowserScenario({page,db,strings,language,onPhase}){
 const visible=text=>page.getByText(text,{exact:false}).or(page.getByLabel(text,{exact:false})).first().waitFor();
 const suffix=randomUUID(),name='Platform '+suffix,slug='platform-'+suffix,email=suffix+'@example.invalid';
 onPhase('platform tenant provisioning');
 await page.getByRole('button',{name:strings['control.title'],exact:true}).click();
 await page.getByRole('button',{name:strings['control.refresh'],exact:true,disabled:false}).waitFor();
 await page.getByRole('button',{name:strings['control.tenants'],exact:true}).click();
 await page.getByRole('button',{name:strings['control.createTenant'],exact:true,disabled:false}).click();
 await fillFlutterField(page,strings['control.field.name'],name);await fillFlutterField(page,strings['control.field.slug'],slug);
 const creation=page.waitForResponse(r=>r.request().method()==='POST'&&new URL(r.url()).pathname.endsWith('/admin/control/tenants'));
 await page.getByRole('button',{name:strings['control.save'],exact:true}).click();assert.equal((await creation).status(),201);
 await visible(name);
 const tenant=(await db.query('SELECT id FROM tenants WHERE slug=$1',[slug])).rows[0];assert(tenant);
 onPhase('selected tenant account provisioning');
 await page.getByRole('button',{name:strings['control.accounts'],exact:true}).click();
 await page.getByRole('button',{name:strings['admin.create'],exact:true,disabled:false}).click();
 await fillFlutterField(page,strings['control.field.email'],email);await fillFlutterField(page,strings['control.field.password'],'initial-password-1234',true);
 const account=page.waitForResponse(r=>r.request().method()==='POST'&&new URL(r.url()).pathname.endsWith('/admin/control/accounts'));
 await page.getByRole('button',{name:strings['control.save'],exact:true}).click();assert.equal((await account).status(),201);await visible(email);
 assert.equal((await db.query('SELECT tenant_id FROM users WHERE email=$1',[email])).rows[0].tenant_id,tenant.id);
 onPhase('localized master provisioning');
 await page.getByRole('button',{name:strings['control.masters'],exact:true}).click();await page.getByRole('button',{name:strings['control.createMaster'],exact:true,disabled:false}).click();
 for(const [key,value] of Object.entries({code:'care-'+suffix,en:'Care '+suffix,es:'Cuidado '+suffix,fr:'Soins '+suffix}))await fillFlutterField(page,strings['control.field.'+key],value);
 const master=page.waitForResponse(r=>r.request().method()==='POST'&&new URL(r.url()).pathname.endsWith('/admin/control/masters'));
 await page.getByRole('button',{name:strings['control.save'],exact:true}).click();assert.equal((await master).status(),201);
 await visible(({en:'Care ',es:'Cuidado ',fr:'Soins '})[language]+suffix);
 const persisted=(await db.query('SELECT labels,status FROM admin_master_records WHERE tenant_id=$1',[tenant.id])).rows[0];assert.equal(persisted.labels.fr,'Soins '+suffix);assert.equal(persisted.status,'active');
 onPhase('platform monitoring and history');
 await page.getByRole('button',{name:strings['control.monitor'],exact:true}).click();await visible(strings['metric.tenantsTotal']+': 2');
 await page.getByRole('button',{name:strings['control.audit'],exact:true}).click();await visible(strings['control.event.tenant_created']);await visible(strings['control.event.account_created']);
 await page.getByRole('button',{name:strings['back'],exact:true}).click();
 // Remove only owned fixtures so each language observes the same baseline.
 await db.query('DELETE FROM admin_master_records WHERE tenant_id=$1',[tenant.id]);await db.query('DELETE FROM admin_control_audit WHERE tenant_id=$1',[tenant.id]);await db.query('DELETE FROM auth_account_audit WHERE tenant_id=$1',[tenant.id]);await db.query('DELETE FROM users WHERE tenant_id=$1',[tenant.id]);await db.query('DELETE FROM tenants WHERE id=$1',[tenant.id]);
 console.log('PASS '+language+': platform tenant, selected-tenant account, translated master, monitoring and history browser E2E');
}
