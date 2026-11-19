// Fixture candidate. No production credentials, route registration, or write API.
export function makeScopedCountReader({query, sql, reportingWindow}) {
  return async function readScopedCounts({userId,tenantId}) {
    if(typeof userId!=='string'||!userId||typeof tenantId!=='string'||!tenantId) return null;
    const bounds=await reportingWindow({tenantId});
    if(!bounds||!(bounds.start instanceof Date)||!(bounds.end instanceof Date)
      ||!Number.isFinite(bounds.start.valueOf())||!Number.isFinite(bounds.end.valueOf())
      ||bounds.start>=bounds.end) throw Error('Reporting window unavailable');
    const {rows}=await query(sql,[tenantId,userId,bounds.start.toISOString(),bounds.end.toISOString()]);
    if(rows.length>1) throw Error('Non-aggregate response');
    return rows[0]??null;
  };
}
