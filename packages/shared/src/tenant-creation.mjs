/** Required production tenant fields. Empty CORS lists grant no new origins. */
export async function createTenantRecord(db,{id,slug,name},table='tenants'){
 if(!/^(?:[a-z][a-z0-9_]*|"[a-z][a-z0-9_]*")(?:\.(?:[a-z][a-z0-9_]*|"[a-z][a-z0-9_]*"))?$/.test(table))throw Error('Invalid tenant table');
 const result=await db.query('INSERT INTO '+table+" (id,slug,name,status,updated_at,allowed_vpn_ranges,cors_allowed_origins,cors_allowed_methods,cors_allowed_headers) VALUES ($1,$2,$3,'active',NOW(),'','[]'::jsonb,'[]'::jsonb,'[]'::jsonb) RETURNING id,slug,name,status,created_at",[id,slug,name]);
 if(!Array.isArray(result.rows)||result.rows.length!==1||String(result.rows[0].id)!==id||result.rows[0].slug!==slug||result.rows[0].name!==name||result.rows[0].status!=='active')throw Error('Tenant insert did not persist');
 return result.rows[0];
}
