/** Register exactly the tenant theme review controls within an existing transaction. */
export async function registerThemeMigrationControls(db, schema, manifestHash, {apply = false, requireExisting = false} = {}) {
  if (!/^governance_[0-9a-f]{40}$/.test(schema)) throw Error('Invalid governance schema');
  const table = name => '"' + schema + '"."govt_' + name + '"';
  const controls = [
    {id:'theme-migration-review', key:'themeWorkspace.migrationReview', en:'Review saved themes', fr:'Vérifier les thèmes enregistrés', es:'Revisar temas guardados'},
    {id:'theme-migration-save', key:'themeWorkspace.migrationSave', en:'Confirm migration', fr:'Confirmer la migration', es:'Confirmar migración'},
    {id:'theme-migration-retry', key:'themeWorkspace.migrationRetry', en:'Retry pending save', fr:'Réessayer l’enregistrement', es:'Reintentar guardado'},
  ];
  await db.query('BEGIN');
  try {
    const names=['source_manifest','screens','roles','role_screen_permissions','api_endpoints','api_permissions','screen_api_links','languages'];
    await db.query('LOCK TABLE '+names.map(table).join(',')+' IN SHARE MODE');
    const writable=['screen_components','screen_required_elements','language_resources','language_resource_values'];
    await db.query('LOCK TABLE '+writable.map(table).join(',')+' IN SHARE ROW EXCLUSIVE MODE');
    const manifest=await db.query('SELECT manifest_sha256 FROM '+table('source_manifest'));
    if(manifest.rows.length!==1||manifest.rows[0].manifest_sha256!==manifestHash) throw Error('Authority mismatch');
    const host=await db.query('SELECT s.id FROM '+table('screens')+' s JOIN '+table('role_screen_permissions')+' v ON v.screen_id=s.id JOIN '+table('roles')+' r ON r.id=v.role_id JOIN '+table('api_permissions')+' p ON p.role_id=r.id JOIN '+table('api_endpoints')+' a ON a.id=p.api_id JOIN '+table('screen_api_links')+' l ON l.screen_id=s.id AND l.api_id=a.id WHERE s.id=2534 AND s.screen_code=$1 AND s.route_path=$2 AND s.active=1 AND r.id=72 AND r.role_code=$3 AND r.active=1 AND v.can_view=1 AND p.api_id=777 AND p.can_access=1 AND p.permission_key=$4 AND a.route_path=$5', ['tenant_admin_command_center','/tenant-dashboard','tenant_admin','authenticated_self_preferences','/v1/user/preferences']);
    if(host.rows.length!==1) throw Error('Host authority mismatch');
    const language=await db.query("SELECT language_id,language_code FROM "+table('languages')+" WHERE language_code IN ('en','fr','es') AND enabled=1");
    if(language.rows.length!==3||new Set(language.rows.map(r=>r.language_code)).size!==3) throw Error('Languages unavailable');
    async function ensure(name,pk,keys,values) {
      const entries=Object.entries(keys), fields=Object.keys(values);
      const where=entries.map(([key],i)=>'"'+key+'"=$'+(i+1)).join(' AND ');
      const rows=(await db.query('SELECT '+[pk,...fields].map(k=>'"'+k+'"').join(',')+' FROM '+table(name)+' WHERE '+where,entries.map(([,value])=>value))).rows;
      if(rows.length>1) throw Error('Duplicate metadata');
      if(rows.length===1) {
        if(fields.some(k=>String(rows[0][k])!==String(values[k]))) throw Error('Existing metadata differs');
        return rows[0][pk];
      }
      if (requireExisting) throw Error('Missing registered metadata');
      const next=(await db.query('SELECT COALESCE(MAX("'+pk+'"),0)+1 AS id,COALESCE(MAX(_primecare_import_row),-1)+1 AS ordinal FROM '+table(name))).rows[0];
      const record={_primecare_import_row:next.ordinal,[pk]:next.id,...keys,...values};
      await db.query('INSERT INTO '+table(name)+' ('+Object.keys(record).map(k=>'"'+k+'"').join(',')+') VALUES ('+Object.keys(record).map((_,i)=>'$'+(i+1)).join(',')+')',Object.values(record));
      return next.id;
    }
    for(const c of controls) {
      const rid=await ensure('language_resources','resource_id',{resource_key:c.key},{resource_group:'themeWorkspace',description:'Tenant theme migration label',context:'theme_workspace',active:1});
      for(const lang of language.rows) await ensure('language_resource_values','translation_id',{resource_id:rid,language_id:lang.language_id},{translated_text:c[lang.language_code],reviewed:0,approved:0,version:'theme-workspace-v1'});
      const key='themeWorkspace.'+c.id;
      await ensure('screen_components','id',{screen_id:2534,component_code:key},{component_name:c.en,component_type:'prime_button',data_cy:c.id,file_path:'packages/primecare_ui/web/advanced-theme-tenant-control.ts',implementation_status:'registered-unimplemented'});
      await ensure('screen_required_elements','id',{screen_id:2534,element_key:key},{element_type:'prime_button',label:c.en,test_id:c.id,required:0});
    }
    await db.query(apply ? 'COMMIT' : 'ROLLBACK');
    return {controls:controls.length,translations:9,committed:apply};
  } catch(error) {await db.query('ROLLBACK');throw error;}
}
