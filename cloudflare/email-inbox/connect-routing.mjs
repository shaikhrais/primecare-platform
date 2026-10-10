/** Run only after Email Routing has been enabled for this domain. Never modifies DNS or existing rules. */
const account = process.env.CLOUDFLARE_ACCOUNT_ID;
const token = process.env.CLOUDFLARE_API_TOKEN;
if (!account || !token) throw new Error('Cloudflare credentials missing');
async function api(path, method = 'GET', body) {
  const response = await fetch(`https://api.cloudflare.com/client/v4${path}`, {
    method, headers: {Authorization:`Bearer ${token}`, 'Content-Type':'application/json'},
    ...(body ? {body:JSON.stringify(body)} : {}), signal:AbortSignal.timeout(30000)});
  const payload = await response.json();
  if (!response.ok || !payload.success) throw new Error(`Cloudflare ${method} ${path}: HTTP ${response.status}; codes ${(payload.errors || []).map(error=>error.code).join(',')}`);
  return payload;
}
const zones = (await api('/zones?name=15minutes-email.com')).result;
const zone = zones.find(value=>value.name==='15minutes-email.com' && value.account?.id===account);
if (!zone) throw new Error('Owned domain not found in configured account');
const base = `/zones/${zone.id}/email/routing`;
const settings = (await api(base)).result;
if (!settings.enabled) throw new Error('Email Routing is disabled. Configure its DNS in Cloudflare before connecting these addresses. Existing DNS is not changed by this script.');
const rules=[];
for (let page=1;;page++) {
  const payload=await api(`${base}/rules?per_page=100&page=${page}`);
  rules.push(...payload.result); if (payload.result.length<100) break;
}
const addresses=['temp@15minutes-email.com','auth-test@15minutes-email.com'];
// Check all conflicts before creating any rule.
for (const address of addresses) {
  const matches=rules.filter(rule=>rule.matchers?.some(m=>m.type==='literal' && m.field==='to' && m.value?.toLowerCase()===address));
  if (matches.some(rule=>!rule.enabled || rule.actions?.length!==1 || rule.actions[0].type!=='worker' || rule.actions[0].value?.[0]!=='primecare-email-inbox')) throw new Error(`Existing rule conflicts with ${address}; no rules changed.`);
}
for (const address of addresses) {
  if (!rules.some(rule=>rule.matchers?.some(m=>m.value?.toLowerCase()===address))) {
    await api(`${base}/rules`,'POST',{enabled:true,name:`Private inbox: ${address}`,
      matchers:[{type:'literal',field:'to',value:address}],actions:[{type:'worker',value:['primecare-email-inbox']}]});
  }
  console.log(`Email Routing connected: ${address}`);
}
