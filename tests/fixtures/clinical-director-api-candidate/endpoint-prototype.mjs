// Isolated contract prototype. No production route or authorization adapter.
export function makeFixtureHandler({verifySession, readScopedCounts}) {
  const json=(status,data,extra={})=>Response.json(data,{
    status,headers:{'cache-control':'no-store','vary':'Authorization',...extra},
  });
  return async function handle(request) {
    const url=new URL(request.url);
    if(url.pathname!=='/v1/clinical/dashboard') return json(404,{error:'not_found'});
    if(request.method!=='GET') return json(405,{error:'method_not_allowed'},{allow:'GET'});
    try {
      const actor=await verifySession(request);
      if(!actor) return json(401,{error:'unauthenticated'});
      if(actor.role!=='clinical_director'||!actor.userId||!actor.tenantId) return json(403,{error:'forbidden'});
      if(url.search) return json(400,{error:'unexpected_query'});
      const counts=await readScopedCounts({userId:actor.userId,tenantId:actor.tenantId});
      if(counts===null) return json(403,{error:'forbidden'});
      if(!Number.isSafeInteger(counts.booking_count)||counts.booking_count<0) return json(503,{error:'unavailable'});
      return json(200,{bookingCount:counts.booking_count});
    } catch {
      return json(503,{error:'unavailable'});
    }
  };
}
