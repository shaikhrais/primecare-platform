import {readFile} from 'node:fs/promises';
const account=process.env.CLOUDFLARE_ACCOUNT_ID, token=process.env.CLOUDFLARE_API_TOKEN;
if(!/^[a-f0-9]{32}$/i.test(account??'')||!token)throw Error('Scoped provider credentials required');
for(const service of ['client','provider','visit','notes','billing','scheduling','notification','verification','compliance','governance','franchise-reporting','gateway']){
 const name=service==='gateway'?'primecare-api-gateway':'primecare-'+service+'-api';
 const r=await fetch('https://api.cloudflare.com/client/v4/accounts/'+account+'/workers/scripts/'+name+'/settings',{redirect:'error',headers:{authorization:'Bearer '+token},signal:AbortSignal.timeout(30000)});
 const body=await r.json();if(!r.ok||body.success!==true||!Array.isArray(body.result?.bindings))throw Error('Live Worker settings unavailable: '+service);
 const config=JSON.parse(await readFile('.cloudflare-workers/'+service+'.jsonc','utf8'));
 const b=body.result.bindings;
 console.log(JSON.stringify({service,liveObservability:body.result.observability??null,generatedObservability:config.observability??null,additionalSecretCount:b.filter(x=>x.type==='secret_text'&&x.name!=='DB_URL').length}));
}
