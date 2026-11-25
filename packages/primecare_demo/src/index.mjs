/** Deterministic synthetic-only fixtures; no production API, identities or credentials. */
export function demoTableRows(demoLabel, statusLabel) {
  return Array.from({length:12},(_,i)=>({id:'row-'+i,values:{name:demoLabel+' '+(i+1),status:statusLabel}}));
}
export function demoChartSeries(kind, demoLabel) {
  if (!['line','area','bar','donut'].includes(kind)) throw new RangeError('Unsupported sample chart kind');
  return kind==='donut'
    ? [{id:'demo',label:demoLabel,values:[12,18,9,14,7,11]}]
    : [[12,18,9],[9,7,15],[4,12,6],[18,4,14],[5,9,12],[8,14,3]].map((values,i)=>({id:'demo-'+i,label:demoLabel+' '+(i+1),values}));
}
