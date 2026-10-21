const required = ['proof (en, 320)','proof (fr, 768)','proof (es, 1440)'];
/** GitHub's completion event can precede visibility of every matrix job. Never
 * substitute run success for exact successful jobs; retry only missing results. */
export async function confirmedSessionProofJobs(fetchJobs, {attempts=7, pause=()=>new Promise(r=>setTimeout(r,5000))}={}) {
 if(!Number.isInteger(attempts)||attempts<1||attempts>13)throw Error('Invalid proof visibility retry bound');
 for(let attempt=0;attempt<attempts;attempt++) {
  const jobs=await fetchJobs();
  if(!Array.isArray(jobs))throw Error('Invalid proof jobs response');
  const proof=jobs.filter(j=>typeof j.name==='string'&&j.name.startsWith('proof ('));
  if(proof.some(j=>!required.includes(j.name))||new Set(proof.map(j=>j.name)).size!==proof.length)throw Error('Unexpected or duplicate browser proof jobs');
  if(proof.some(j=>j.status==='completed'&&j.conclusion!=='success'))throw Error('Live browser proof did not succeed');
  if(proof.length===required.length&&proof.every(j=>j.status==='completed'&&j.conclusion==='success')) {
   if(proof.some(j=>!Number.isFinite(Date.parse(j.started_at))))throw Error('Proof job timestamps required');
   return proof;
  }
  if(attempt+1<attempts)await pause();
 }
 throw Error('Three exact successful live browser proof jobs required after bounded visibility retry');
}
