type Operation = {id:number;api:string};
type Receipt = Operation & {
  releaseId:string; verifiedAt:string; expiresAt:string; runId:string;
  successfulRequest:boolean; accessPolicyPassed:boolean; scopeChecksPassed:boolean;
};

const maxAge = 24 * 60 * 60 * 1000;
const releasePattern = /^[A-Za-z0-9][A-Za-z0-9._-]{0,79}$/;

export function endpointReadiness(receipts:readonly Receipt[]) {
  const index = new Map<string, Receipt | null>();
  for (const receipt of receipts) {
    const key = `${receipt.releaseId} ${receipt.id} ${receipt.api}`;
    index.set(key,index.has(key)?null:receipt);
  }
  return (id:unknown,api:unknown,releaseId:string|undefined,now:number) => {
    if (!releaseId || !releasePattern.test(releaseId)) return null;
    const receipt = index.get(`${releaseId} ${id} ${api}`);
    if (!receipt || receipt.successfulRequest !== true || receipt.accessPolicyPassed !== true ||
        receipt.scopeChecksPassed !== true || !/^[1-9][0-9]{0,19}$/.test(receipt.runId)) return null;
    const start = Date.parse(receipt.verifiedAt), end = Date.parse(receipt.expiresAt);
    if (!Number.isFinite(start) || !Number.isFinite(end) || end-start>maxAge || now<start || now>=end) return null;
    if (new Date(start).toISOString()!==receipt.verifiedAt || new Date(end).toISOString()!==receipt.expiresAt) return null;
    return {releaseId,verifiedAt:receipt.verifiedAt,expiresAt:receipt.expiresAt,runId:receipt.runId};
  };
}
