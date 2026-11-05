/** Scoped status update: records implementation only, never activation or approval. */
export async function recordThemeRestoreImplementation(db,pin,{apply=false,readback=false}={}) {
 const expected={screenId:2534,roleId:72,apiId:777,controls:['theme-restore-review','theme-restore-confirm'],tables:['screen_components','screen_required_elements','language_resources','language_resource_values'],runtimeActivation:false,roleGrants:false};
 if(JSON.stringify(pin.themeRestoreWriter)!==JSON.stringify(expected)||!/^governance_[0-9a-f]{24,40}$/.test(pin.schema)||pin.tablePrefix!=='govt_')throw Error('Scoped authority mismatch');
 const table=n=>'"'+pin.schema+'"."'+pin.tablePrefix+n+'"',ids=expected.controls;
 await db.query('BEGIN');
 try{
  await db.query("SET LOCAL lock_timeout='5s'");
  await db.query('LOCK TABLE '+table('source_manifest')+','+table('screens')+' IN SHARE MODE');
  await db.query('LOCK TABLE '+table('screen_components')+' IN SHARE ROW EXCLUSIVE MODE');
  const manifest=(await db.query('SELECT manifest_sha256 FROM '+table('source_manifest'))).rows;
  if(manifest.length!==1||manifest[0].manifest_sha256!==pin.manifestSha256)throw Error('Authority mismatch');
  const host=(await db.query('SELECT id FROM '+table('screens')+" WHERE id=2534 AND screen_code='tenant_admin_command_center' AND route_path='/tenant-dashboard' AND active=1")).rows;
  if(host.length!==1)throw Error('Host mismatch');
  const rows=(await db.query('SELECT id,data_cy,component_code,component_type,file_path,implementation_status FROM '+table('screen_components')+' WHERE screen_id=2534 AND data_cy=ANY($1::text[]) ORDER BY data_cy',[ids])).rows;
  if(rows.length!==2||new Set(rows.map(r=>r.data_cy)).size!==2||rows.some(r=>r.component_code!=='themeWorkspace.'+r.data_cy||r.component_type!=='prime_button'||r.file_path!=='packages/primecare_ui/web/advanced-theme-tenant-restore-control.ts'||!['registered-unimplemented','implemented-unverified'].includes(r.implementation_status)))throw Error('Control identity mismatch');
  if(readback&&rows.some(r=>r.implementation_status!=='implemented-unverified'))throw Error('Control readback mismatch');
  if(!readback)await db.query('UPDATE '+table('screen_components')+" SET implementation_status='implemented-unverified' WHERE screen_id=2534 AND data_cy=ANY($1::text[]) AND implementation_status='registered-unimplemented'",[ids]);
  await db.query(apply?'COMMIT':'ROLLBACK');
  return {controls:2,committed:apply,readback,runtimeActivated:false,humanReviewApproved:false};
 }catch(error){await db.query('ROLLBACK');throw error;}
}
