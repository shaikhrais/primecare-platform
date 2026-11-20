type Operation = {id:number;api:string};
type Window = {id:number;api:string;startsAt:string;endsAt:string;reason:string};

function timestamp(value:string) {
  const date = new Date(value);
  if (!Number.isFinite(date.getTime()) || date.toISOString() !== value) {
    throw new Error('Endpoint maintenance timestamps must use canonical UTC');
  }
  return date.getTime();
}

/** Index reviewed release configuration by exact governance declaration. */
export function endpointMaintenance(windows:readonly Window[], operations:readonly Operation[]) {
  const keys = new Set(operations.map(({id,api}) => `${id} ${api}`));
  const index = new Map<string, Array<Window & {start:number;end:number}>>();
  for (const window of windows) {
    const key = `${window.id} ${window.api}`;
    const start = timestamp(window.startsAt), end = timestamp(window.endsAt);
    if (!keys.has(key) || start >= end || typeof window.reason !== 'string' ||
        !window.reason.trim() || window.reason.length > 200 || /[\u0000-\u001f\u007f]/.test(window.reason)) {
      throw new Error('Invalid endpoint maintenance window');
    }
    const group = index.get(key) ?? [];
    group.push({...window,start,end});
    index.set(key,group);
  }
  for (const group of index.values()) {
    group.sort((a,b) => a.start-b.start);
    if (group.some((window,i) => i>0 && window.start<group[i-1].end)) {
      throw new Error('Overlapping endpoint maintenance windows');
    }
  }
  return (id:unknown,api:unknown,now:number) => {
    const window = index.get(`${id} ${api}`)?.find(item=>now<item.end);
    if (!window) return null;
    return {status:window.start<=now?'active' as const:'scheduled' as const,
      startsAt:window.startsAt,endsAt:window.endsAt,reason:window.reason};
  };
}
