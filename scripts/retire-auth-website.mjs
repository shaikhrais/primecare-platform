// User-approved retirement: targets only the obsolete Pages UI, never auth APIs.
import { pathToFileURL } from 'node:url';

export async function retireAuthWebsite(env = process.env, request = fetch) {
  const account = env.CLOUDFLARE_ACCOUNT_ID;
  const token = env.CLOUDFLARE_API_TOKEN;
  if (!account || !token) throw new Error('Cloudflare configuration is required');
  const project = 'primecare-auth';
  const url = `https://api.cloudflare.com/client/v4/accounts/${encodeURIComponent(account)}/pages/projects/${project}`;
  const headers = { Authorization: `Bearer ${token}` };
  const current = await request(url, { headers });
  if (current.status === 404) {
    console.log('Standalone auth website is already absent.');
    return;
  }
  if (!current.ok) throw new Error(`Project lookup failed: HTTP ${current.status}`);
  const body = await current.json();
  if (!body.success || body.result?.name !== project || body.result?.subdomain !== `${project}.pages.dev`) {
    throw new Error('Unexpected project identity; nothing deleted');
  }
  let response = await request(url, { method: 'DELETE', headers });
  let result = await response.json();
  if (!result.success && result.errors?.some(e => e.code === 8000076)) {
    // Cloudflare requires individual cleanup when a project has over 100 deployments.
    // Collect before deleting so pagination cannot skip entries as the list shrinks.
    const ids = new Set();
    for (let page = 1; ; page++) {
      const listed = await request(`${url}/deployments?per_page=25&page=${page}`, { headers });
      const data = await listed.json();
      if (!listed.ok || !data.success || !Array.isArray(data.result)) {
        throw new Error(`Deployment listing failed: HTTP ${listed.status}; codes ${(data.errors || []).map(e => e.code).join(',')}`);
      }
      for (const deployment of data.result) {
        if (typeof deployment.id !== 'string' || !/^[a-zA-Z0-9-]+$/.test(deployment.id)) {
          throw new Error('Unexpected deployment identity; cleanup stopped');
        }
        if (deployment.id !== body.result.canonical_deployment?.id) ids.add(deployment.id);
      }
      const totalPages = data.result_info?.total_pages;
      if (totalPages ? page >= totalPages : data.result.length < 25) break;
      if (page >= 1000) throw new Error('Deployment pagination limit reached');
    }
    console.log(`Removing ${ids.size} historical deployments from primecare-auth only.`);
    for (const id of ids) {
      const deleted = await request(`${url}/deployments/${encodeURIComponent(id)}?force=true`, { method: 'DELETE', headers });
      const data = await deleted.json();
      if (!deleted.ok || !data.success) {
        throw new Error(`Deployment cleanup failed: HTTP ${deleted.status}; codes ${(data.errors || []).map(e => e.code).join(',')}`);
      }
    }
    response = await request(url, { method: 'DELETE', headers });
    result = await response.json();
  }
  if (!response.ok || !result.success) {
    throw new Error(`Project removal failed: HTTP ${response.status}; codes ${(result.errors || []).map(e => e.code).join(',')}`);
  }
  const verify = await request(url, { headers });
  if (verify.status !== 404) throw new Error(`Removal verification returned HTTP ${verify.status}`);
  console.log('Removed primecare-auth Pages website. Auth API and product apps are unchanged.');
}

if (process.argv[1] && import.meta.url === pathToFileURL(process.argv[1]).href) {
  await retireAuthWebsite();
}
